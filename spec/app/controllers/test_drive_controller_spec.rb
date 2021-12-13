require 'integration_helper'
describe 'Test drive controller' do

  let(:usuario){Usuario.new(99999, 'test', 'test@gmail.com', 9999)}
  let(:usuario_comprador){Usuario.new(999999, 'test2', 'test2@gmail.com', 99999)}
  let(:auto){Auto.new('fiat', 'palio', 1988, 'dfdsf23')}

  before(:each) do
    Persistence::Repositories::RepositorioDeIntencionesDeVenta.new.delete_all
    Persistence::Repositories::RepositorioDePublicaciones.new.delete_all
    Persistence::Repositories::RepositorioDeUsuarios.new.delete_all
    Persistence::Repositories::RepositorioDeAutos.new.delete_all
    Persistence::Repositories::RepositorioDeTestDrives.new.delete_all
    intencion_venta = IntencionDeVenta.new(auto, usuario, 'en revisión')
    Persistence::Repositories::RepositorioDeUsuarios.new.save(usuario)
    Persistence::Repositories::RepositorioDeAutos.new.save(auto)
    @intencion_con_id = Persistence::Repositories::RepositorioDeIntencionesDeVenta.new.save(intencion_venta)
    @usuario_comprador_con_id = Persistence::Repositories::RepositorioDeUsuarios.new.save(usuario_comprador)
    @publicacion = Publicacion.new(usuario, auto, 75000, "Fiubak", 1)
    @publicacion_p2p = Publicacion.new(usuario, auto, 75000, "p2p", 2)
  end

  context 'contratacion de test drives' do
    it 'Al contratar un test drive recibo un mensaje exitoso con el costo día lluvioso' do
      pub = Persistence::Repositories::RepositorioDePublicaciones.new.save(@publicacion)
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
      pub = Persistence::Repositories::RepositorioDePublicaciones.new.save(@publicacion)
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
      pub = Persistence::Repositories::RepositorioDePublicaciones.new.save(@publicacion)
      api_key = ENV['CLIMA_API_KEY']
      url = "https://api.openweathermap.org/data/2.5/weather?q=Buenos%20Aires&appid="
      stub = stub_request(:get, url + api_key)
        .to_return(body: {"weather": [{"main": "Cold"}, {"main": "Hot"}]}.to_json)
      post("/publicaciones/#{pub.id}/test_drives",nil, header_con_token(usuario.id))
      post("/publicaciones/#{pub.id}/test_drives",nil, header_con_token(usuario.id))
      body = JSON.parse(last_response.body)
      expect(body['mensaje']).to eq("Contratacion fallida: Ya existe un test-drive asociado al dia de hoy")
      expect(last_response.status).to eq(409)
    end

    it 'Obtengo un error al intentar contratar test drive de un auto que no es de fiubak' do
      pub = Persistence::Repositories::RepositorioDePublicaciones.new.save(@publicacion_p2p)
      api_key = ENV['CLIMA_API_KEY']
      url = "https://api.openweathermap.org/data/2.5/weather?q=Buenos%20Aires&appid="
      stub = stub_request(:get, url + api_key)
        .to_return(body: {"weather": [{"main": "Cold"}, {"main": "Hot"}]}.to_json)
      post("/publicaciones/#{pub.id}/test_drives", nil, header_con_token(usuario.id))
      body = JSON.parse(last_response.body)
      expect(body['mensaje']).to eq("Solo puede contratar test-drive para autos de Fiubak")
      expect(last_response.status).to eq(409)
    end
  end

end
