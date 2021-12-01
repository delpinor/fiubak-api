require 'integration_helper'

describe 'Cotizacones controller' do

  let(:usuario){Usuario.new(9999, 'test', 'test@gmail.com', 999)}
  let(:auto){Auto.new('fiat', 'palio', 1988, nil)}
  let(:intencion){IntencionDeVenta.new(auto, usuario, 'en revision')}

  before(:each) do
    Persistence::Repositories::RepositorioDeIntencionesDeVenta.new.delete_all
    Persistence::Repositories::RepositorioDeUsuarios.new.delete_all
    Persistence::Repositories::RepositorioDeAutos.new.delete_all
    intencion_venta = IntencionDeVenta.new(auto, usuario, 'en revision')
    Persistence::Repositories::RepositorioDeUsuarios.new.save(usuario)
    Persistence::Repositories::RepositorioDeAutos.new.save(auto)
    @id_intencion = Persistence::Repositories::RepositorioDeIntencionesDeVenta.new.save(intencion_venta)

  end

  it 'Cuando acepto la cotizacion obtengo el mensaje  de aceptacion' do
    datos = {id_usuario: usuario.id, id_intencion: @id_intencion}
    put('/aceptar_cotizacion', datos.to_json, { 'CONTENT_TYPE' => 'application/json' })
    body = JSON.parse(last_response.body)
    expect(body['mensaje']).to eq("La intención de venta fue concretada con éxito")
  end

  it 'Cuando acepto la cotizacion obtengo un 200 OK' do
    datos = {id_usuario: usuario.id, id_intencion: @id_intencion}
    put('/aceptar_cotizacion', datos.to_json, { 'CONTENT_TYPE' => 'application/json' })
    expect(last_response.status).to eq(200)
  end

end
