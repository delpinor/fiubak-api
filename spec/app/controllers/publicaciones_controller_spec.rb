require 'integration_helper'
describe 'Publicaciones controller' do

  let(:usuario){Usuario.new(99999, 'test', 'test@gmail.com', 9999)}
  let(:usuario_comprador){Usuario.new(999999, 'test2', 'test2@gmail.com', 99999)}
  let(:auto){Auto.new('fiat', 'palio', 1988, 'dfdsf23')}
  let(:auto_2){Auto.new('fiat', 'palio', 1988, 'dfdsf23')}

  before(:each) do
    Persistence::Repositories::RepositorioDeIntencionesDeVenta.new.delete_all
    Persistence::Repositories::RepositorioDePublicaciones.new.delete_all
    Persistence::Repositories::RepositorioDeUsuarios.new.delete_all
    Persistence::Repositories::RepositorioDeAutos.new.delete_all
    Persistence::Repositories::RepositorioDeTestDrives.new.delete_all
    Persistence::Repositories::RepositorioDeUsuarios.new.save(usuario)
    Persistence::Repositories::RepositorioDeAutos.new.save(auto)
    Persistence::Repositories::RepositorioDeAutos.new.save(auto_2)
    intencion_venta = IntencionDeVenta.new(auto, usuario, 'en revisión')
    intencion_venta_revisada = IntencionDeVenta.new(auto_2, usuario, 'revisado y cotizado')
    intencion_venta_revisada.set_valor_cotizado(50)
    @intencion_con_id = Persistence::Repositories::RepositorioDeIntencionesDeVenta.new.save(intencion_venta)
    @intencion_con_id_revisada = Persistence::Repositories::RepositorioDeIntencionesDeVenta.new.save(intencion_venta_revisada)
    @usuario_comprador_con_id = Persistence::Repositories::RepositorioDeUsuarios.new.save(usuario_comprador)
    @publicacion = Publicacion.new(usuario, auto, 75000, "p2p", 1)
    @publicacion_fiubak = Publicacion.new(usuario, auto_2, 75000, "Fiubak", 2)

  end

  it 'La respuesta debe ser un mensaje exitoso' do
    get('/publicaciones', nil, header_con_token(usuario.id))
    body = JSON.parse(last_response.body)
    expect(body).to eq([])
    expect(last_response.status).to eq(200)
  end

  it 'Cuando el usuario confirma la venta y consulto las busquedas obtengo una nueva publicacion' do
    publicacion = @intencion_con_id_revisada.concretar_por_fiubak
    Persistence::Repositories::RepositorioDePublicaciones.new.save(publicacion)

    get('/publicaciones', nil, header_con_token(usuario.id))
    body = JSON.parse(last_response.body)
    expect(body.length()).to eq(1)
    expect(body[0]['id']).to be_present
    expect(body[0]['marca']).to eq(auto.marca)
    expect(body[0]['modelo']).to eq(auto.modelo)
    expect(body[0]['anio']).to eq(auto.anio)
    expect(last_response.status).to eq(200)
  end


  it 'Cuando publico por p2p obtengo el id de la publicacion, el precio y el id de la intencion de venta' do
    datos = { id_intencion_de_venta: @intencion_con_id_revisada.id,
             precio: 45000 }

    post('/publicaciones', datos.to_json, header_con_token(usuario.id))
    body = JSON.parse(last_response.body)
    expect(body['valor']['id_publicacion']).to be_present
    expect(body['valor']['precio']).to eq(45000)

    expect(last_response.status).to eq(201)
  end


  it 'Cuando publico por p2p con precio menor o igual al de la cotizacion obtengo un error.' do
    datos = { id_intencion_de_venta: @intencion_con_id_revisada.id,
             precio: 10 }

    post('/publicaciones', datos.to_json, header_con_token(usuario.id))
    body = JSON.parse(last_response.body)
    mensaje = body['mensaje']
    expect(mensaje).to eq("El precio de publicación debe ser mayor al de cotización")
  end

  context 'Ofertas' do
    it 'Al crear una oferta recibo un mensaje exitoso' do
      pub = Persistence::Repositories::RepositorioDePublicaciones.new.save(@publicacion)
      datos = { id_usuario: @usuario_comprador_con_id.id.to_i, valor: 150 }
      post("/publicaciones/#{pub.id}/ofertas", datos.to_json, header_con_token(usuario.id))
      body = JSON.parse(last_response.body)
      expect(body['valor']['id']).to be_present
      id_oferta = body['valor']['id']
      expect(body['mensaje']).to eq("Generaste la oferta #{id_oferta} con un monto de $#{datos[:valor]}")
      expect(last_response.status).to eq(201)
    end

    it 'Cuando envio una oferta, espero un mensaje de oferta rechazada con exito' do
      datos_venta = { id_intencion_de_venta: @intencion_con_id_revisada.id,
                      precio: 45000 }

      post('/publicaciones', datos_venta.to_json, header_con_token(usuario.id))
      expect(last_response.status).to eq 201
      body = JSON.parse(last_response.body)
      pub_id = body['valor']['id_publicacion']

      datos_oferta = { id_usuario: @usuario_comprador_con_id.id.to_i, valor: 150 }
      post("/publicaciones/#{pub_id}/ofertas", datos_oferta.to_json, header_con_token(usuario.id))
      expect(last_response.status).to eq 201
      body = JSON.parse(last_response.body)

      id_oferta = body['valor']['id']
      post("/ofertas/#{id_oferta}/rechazar", nil, header_con_token(usuario.id))

      body = JSON.parse(last_response.body)
      expect(body['mensaje']).to eq('oferta rechazada con exito')
    end

    it 'Cuando envio una oferta y luego acepto, espero un mensaje de oferta aceptada con exito' do
      datos_venta = { id_intencion_de_venta: @intencion_con_id_revisada.id,
                      precio: 45000 }

      post('/publicaciones', datos_venta.to_json, header_con_token(usuario.id))
      expect(last_response.status).to eq 201
      body = JSON.parse(last_response.body)
      pub_id = body['valor']['id_publicacion']

      datos_oferta = { id_usuario: @usuario_comprador_con_id.id.to_i, valor: 150 }
      post("/publicaciones/#{pub_id}/ofertas", datos_oferta.to_json, header_con_token(usuario.id))
      expect(last_response.status).to eq 201
      body = JSON.parse(last_response.body)

      id_oferta = body['valor']['id']
      post("/ofertas/#{id_oferta}/aceptar", nil, header_con_token(usuario.id))

      body = JSON.parse(last_response.body)
      expect(body['mensaje']).to eq('oferta aceptada con exito')
    end

    it 'Al querer publicar un estado que no esta revisado obtengo un error' do
      datos_venta = { id_intencion_de_venta: @intencion_con_id.id,
                      precio: 45000 }

      post('/publicaciones', datos_venta.to_json, header_con_token(usuario.id))
      expect(last_response.status).to eq 409
      body = JSON.parse(last_response.body)
      expect(body['mensaje']).to eq('El auto no esta en condiciones de ser publicado')
    end


    it 'Cuando trato de aceptar una oferta inexistente obtengo un error' do
      post("/ofertas/22/aceptar", nil, header_con_token(usuario.id))
      body = JSON.parse(last_response.body)
      expect(last_response.status).to eq 404
      expect(body['mensaje']).to eq('oferta no encontrada')
    end

    it 'Cuando envio una oferta y luego acepto, al consultar las publicaciones la misma no debe estar presente' do
      datos_venta = { id_intencion_de_venta: @intencion_con_id_revisada.id,
                      precio: 45000 }
      post('/publicaciones', datos_venta.to_json, header_con_token(usuario.id))
      expect(last_response.status).to eq 201
      body = JSON.parse(last_response.body)
      pub_id = body['valor']['id_publicacion']

      datos_oferta = { id_usuario: @usuario_comprador_con_id.id.to_i, valor: 150 }
      post("/publicaciones/#{pub_id}/ofertas", datos_oferta.to_json, header_con_token(usuario.id))
      expect(last_response.status).to eq 201
      body = JSON.parse(last_response.body)

      id_oferta = body['valor']['id']
      post("/ofertas/#{id_oferta}/aceptar", nil, header_con_token(usuario.id))

      get('/publicaciones', nil, header_con_token(usuario.id))
      body = JSON.parse(last_response.body)
      expect(body.length()).to eq(0)
    end

    it 'Al crear otra oferta recibo un mensaje exitoso' do
      pub = Persistence::Repositories::RepositorioDePublicaciones.new.save(@publicacion)
      datos = { id_usuario: @usuario_comprador_con_id.id.to_i, valor: 400 }
      post("/publicaciones/#{pub.id}/ofertas", datos.to_json, header_con_token(usuario.id))
      body = JSON.parse(last_response.body)
      expect(body['valor']['id']).to be_present
      id_oferta = body['valor']['id']
      expect(body['mensaje']).to eq("Generaste la oferta #{id_oferta} con un monto de $#{datos[:valor]}")
      expect(last_response.status).to eq(201)
    end

    it 'Al una oferta con usuario inexistente recibo un error' do
      pub = Persistence::Repositories::RepositorioDePublicaciones.new.save(@publicacion)
      datos = { id_usuario: 41242141, valor: 400 }
      post("/publicaciones/#{pub.id}/ofertas", datos.to_json, header_con_token(usuario.id))
      body = JSON.parse(last_response.body)
      expect(body['mensaje']).to eq("Para realizar esta operacion debe registrarse")
      expect(last_response.status).to eq(400)
    end

    it 'Al una oferta con una publicacion inexistente recibo un error' do
      pub = Persistence::Repositories::RepositorioDePublicaciones.new.save(@publicacion)
      datos = { id_usuario: @usuario_comprador_con_id.id.to_i, valor: 400 }
      post("/publicaciones/223222/ofertas", datos.to_json, header_con_token(usuario.id))
      body = JSON.parse(last_response.body)
      expect(body['mensaje']).to eq("La publicacion no existe")
      expect(last_response.status).to eq(404)
    end
    
  end

  context 'Detalle de publicacion' do
    it 'Al consultar el detalle de una publicacion que no existe obtengo un error' do
      get('/publicaciones/4242', nil, header_con_token(usuario.id))
      body = JSON.parse(last_response.body)
      expect(body['mensaje']).to eq("La publicacion no existe")
      expect(last_response.status).to eq(404)
    end

    it 'Al consultar el detalle de una publicacion obtengo sus datos incluyendo oferta' do
      # Genero la publicacion y la oferta
      pub = Persistence::Repositories::RepositorioDePublicaciones.new.save(@publicacion)
      datos = { id_usuario: @usuario_comprador_con_id.id.to_i, valor: 400 }
      post("/publicaciones/#{pub.id}/ofertas", datos.to_json, header_con_token(usuario.id))
      body = JSON.parse(last_response.body)
      id_oferta = body['valor']['id']

      # Obtengo los datos
      get("/publicaciones/#{pub.id}", nil, header_con_token(usuario.id))
      body = JSON.parse(last_response.body)
      expect(body['id']).to eq(pub.id)
      expect(body['patente']).to eq(pub.auto.patente)
      expect(body['modelo']).to eq(pub.auto.modelo)
      expect(body['anio']).to eq(pub.auto.anio)
      expect(body['ofertas'][0]['valor']).to eq(400)
      expect(body['ofertas'][0]['id']).to eq(id_oferta)
      expect(body['ofertas'][0]['nombre_comprador']).to eq(@usuario_comprador_con_id.nombre)
      expect(last_response.status).to eq(200)
    end
  end

  context 'contratacion de test drives' do
    it 'Al contratar un test drive recibo un mensaje exitoso con el costo día lluvioso' do
      pub = Persistence::Repositories::RepositorioDePublicaciones.new.save(@publicacion_fiubak)
      api_key = ENV['CLIMA_API_KEY']
      url = "https://api.openweathermap.org/data/2.5/weather?q=Buenos%20Aires&appid="
      stub = stub_request(:get, url + api_key)
        .to_return(body: {"weather": [{"main": "Rain"}, {"main": "Hot"}]}.to_json)
      post("/publicaciones/#{pub.id}/test_drives", nil, header_con_token(usuario.id))
      body = JSON.parse(last_response.body)
      expect(body['mensaje']).to eq("Test-drive para el día de hoy contratado con éxito. Deberá abonar una suma de $600")
      expect(last_response.status).to eq(201)
    end

    it 'Al contratar un test drive recibo un mensaje exitoso con el costo día no lluvioso' do
      pub = Persistence::Repositories::RepositorioDePublicaciones.new.save(@publicacion_fiubak)
      api_key = ENV['CLIMA_API_KEY']
      url = "https://api.openweathermap.org/data/2.5/weather?q=Buenos%20Aires&appid="
      stub = stub_request(:get, url + api_key)
        .to_return(body: {"weather": [{"main": "Cold"}, {"main": "Hot"}]}.to_json)
      post("/publicaciones/#{pub.id}/test_drives", nil, header_con_token(usuario.id))
      body = JSON.parse(last_response.body)
      expect(body['mensaje']).to eq("Test-drive para el día de hoy contratado con éxito. Deberá abonar una suma de $750")
      expect(last_response.status).to eq(201)
    end

    it 'Obtengo un error al intentar contratar dos test drive para una publicacion' do
      pub = Persistence::Repositories::RepositorioDePublicaciones.new.save(@publicacion_fiubak)
      api_key = ENV['CLIMA_API_KEY']
      url = "https://api.openweathermap.org/data/2.5/weather?q=Buenos%20Aires&appid="
      stub = stub_request(:get, url + api_key)
        .to_return(body: {"weather": [{"main": "Cold"}, {"main": "Hot"}]}.to_json)
      post("/publicaciones/#{pub.id}/test_drives", nil, header_con_token(usuario.id))
      post("/publicaciones/#{pub.id}/test_drives", nil, header_con_token(usuario.id))
      body = JSON.parse(last_response.body)
      expect(body['mensaje']).to eq("Contratacion fallida: Ya existe un test-drive asociado al dia de hoy")
      expect(last_response.status).to eq(409)
    end
  end

end
