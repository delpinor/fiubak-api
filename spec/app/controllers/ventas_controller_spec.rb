require 'integration_helper'

describe 'Ventas controller' do

  let(:datos_auto) { {marca: "Mercedes", modelo: "2322", anio: 2018, patente: "MHF200"} }

  it 'La respuesta debe ser un mensaje exitoso' do
    post('/usuarios/1/ventas', datos_auto.to_json, { 'CONTENT_TYPE' => 'application/json' })
    body = JSON.parse(last_response.body)
    expect(body['mensaje']).to eq('intencion de venta registrada con exito')
  end

end
