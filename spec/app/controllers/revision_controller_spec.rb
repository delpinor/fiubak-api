require 'integration_helper'

describe 'Revision controller' do

  let(:usuario){Usuario.new(99999, 'test', 'test@gmail.com', 9999)}
  let(:auto){Auto.new('fiat', 'palio', 1988, 'dfdsf23')}

  before(:each) do
    Persistence::Repositories::RepositorioDeIntencionesDeVenta.new.delete_all
    Persistence::Repositories::RepositorioDePublicaciones.new.delete_all
    Persistence::Repositories::RepositorioDeUsuarios.new.delete_all
    Persistence::Repositories::RepositorioDeAutos.new.delete_all
    #Guarda
    Persistence::Repositories::RepositorioDeUsuarios.new.save(usuario)
    Persistence::Repositories::RepositorioDeAutos.new.save(auto)
    intencion_venta = IntencionDeVenta.new(auto, usuario, 'en revisión')
    @intencion_con_id = Persistence::Repositories::RepositorioDeIntencionesDeVenta.new.save(intencion_venta)
  end

  it 'Cuando recibo una revision me devuelve 200 OK' do
    datos = {id_intencion: @intencion_con_id.id, estado_motor: "sin danio",
             estado_estetica: "sin danio",estado_neumaticos: "sin danio", precio_lista: 1000 }
    post('/revisiones', datos.to_json, { 'CONTENT_TYPE' => 'application/json' })
    expect(last_response.status).to eq(201)
  end

  it 'La respuesta debe ser un mensaje exitoso' do
    datos = {id_intencion: @intencion_con_id.id, estado_motor: "sin danio",
             estado_estetica: "sin danio", estado_neumaticos: "sin danio", precio_lista: 1000 }
    post('/revisiones', datos.to_json, { 'CONTENT_TYPE' => 'application/json' })
    body = JSON.parse(last_response.body)
    expect(body['mensaje']).to eq('revisión exitosa')
  end

end
