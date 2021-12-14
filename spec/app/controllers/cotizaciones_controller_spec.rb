require 'integration_helper'

describe 'Cotizacones controller' do

  let(:usuario){Usuario.new(99999, 'test', 'test@gmail.com', 9999)}
  let(:auto){Auto.new('fiat', 'palio', 1988, 'dfdsf23')}
  let(:intencion){IntencionDeVenta.new(auto, usuario, 'en revisión')}

  before(:each) do
    Persistence::Repositories::RepositorioDeIntencionesDeVenta.new.delete_all
    Persistence::Repositories::RepositorioDeUsuarios.new.delete_all
    Persistence::Repositories::RepositorioDeAutos.new.delete_all
    intencion_venta = IntencionDeVenta.new(auto, usuario, 'en revisión')
    intencion_venta_revisada = IntencionDeVenta.new(auto, usuario, 'revisado y cotizado')
    Persistence::Repositories::RepositorioDeUsuarios.new.save(usuario)
    Persistence::Repositories::RepositorioDeAutos.new.save(auto)
    @intencion_con_id = Persistence::Repositories::RepositorioDeIntencionesDeVenta.new.save(intencion_venta)
    @intencion_con_id_revisada = Persistence::Repositories::RepositorioDeIntencionesDeVenta.new.save(intencion_venta_revisada)

  end

  it 'Cuando acepto la cotizacion obtengo el mensaje  de aceptacion' do
    datos = {id_usuario: usuario.id, id_intencion: @intencion_con_id_revisada.id}
    put('/aceptar_cotizacion', datos.to_json, header_con_token(usuario.id))
    body = JSON.parse(last_response.body)
    expect(body['mensaje']).to eq("La intención de venta fue concretada con éxito")
  end

  it 'Cuando acepto la cotizacion obtengo un 200 OK' do
    datos = {id_usuario: usuario.id, id_intencion: @intencion_con_id_revisada.id}
    put('/aceptar_cotizacion', datos.to_json, header_con_token(usuario.id))
    expect(last_response.status).to eq(200)
  end

  it 'Cuando busco por un id invalido obtengo un error' do
    datos = {id_intencion: -1}
    @response = put('/aceptar_cotizacion', datos.to_json, header_con_token(usuario.id))
    expect(last_response.status).to eq(404)
  end

  it 'se lanza un error si el auto no estaba listo para aceptar cotizacion' do
    datos = {id_usuario: usuario.id, id_intencion: @intencion_con_id.id}
    @response = put('/aceptar_cotizacion', datos.to_json, header_con_token(usuario.id))
    body = JSON.parse(last_response.body)
    expect(body['mensaje']).to eq("El auto no esta en condiciones de ser publicado")
  end
end
