require 'integration_helper'
require 'byebug'
describe 'Publicaciones controller' do

  let(:usuario){Usuario.new(99999, 'test', 'test@gmail.com', 9999)}
  let(:auto){Auto.new('fiat', 'palio', 1988, 'dfdsf23')}

  before(:each) do
    Persistence::Repositories::RepositorioDeIntencionesDeVenta.new.delete_all
    Persistence::Repositories::RepositorioDePublicaciones.new.delete_all
    Persistence::Repositories::RepositorioDeUsuarios.new.delete_all
    Persistence::Repositories::RepositorioDeAutos.new.delete_all
    intencion_venta = IntencionDeVenta.new(auto, usuario, 'en revisión')
    Persistence::Repositories::RepositorioDeUsuarios.new.save(usuario)
    Persistence::Repositories::RepositorioDeAutos.new.save(auto)
    @intencion_con_id = Persistence::Repositories::RepositorioDeIntencionesDeVenta.new.save(intencion_venta)
  end

  it 'La respuesta debe ser un mensaje exitoso' do
    get('/publicaciones')
    body = JSON.parse(last_response.body)
    expect(body).to eq([])
    expect(last_response.status).to eq(200)
  end

  it 'Cuando el usuario confirma la venta y consulto las busquedas obtengo una nueva publicacion' do
    publicacion = @intencion_con_id.concretar_por_fiubak
    Persistence::Repositories::RepositorioDePublicaciones.new.save(publicacion)

    get('/publicaciones')
    body = JSON.parse(last_response.body)
    expect(body.length()).to eq(1)
    expect(body[0]['id']).to be_present
    expect(body[0]['marca']).to eq(auto.marca)
    expect(body[0]['modelo']).to eq(auto.modelo)
    expect(body[0]['anio']).to eq(auto.anio)
    expect(last_response.status).to eq(200)
  end


  it 'Cuando publico por p2p obtengo el id de la publicacion, el precio y el id de la intencion de venta' do
    datos = { id_intencion_de_venta: @intencion_con_id.id,
             precio: 45000 }

    post('/publicaciones', datos.to_json, { 'CONTENT_TYPE' => 'application/json' })
    body = JSON.parse(last_response.body)
    expect(body['valor']['id_publicacion']).to be_present
    expect(body['valor']['precio']).to eq(45000)

    expect(last_response.status).to eq(201)
  end

end
