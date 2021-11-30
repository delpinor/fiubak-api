require 'integration_helper'

describe 'Ventas controller' do

  let(:datos_auto) { {marca: "Mercedes", modelo: "2322", anio: 2018, patente: "MHF200"} }
  let(:datos_auto_2) { {marca: "Mercedes", modelo: "2322", anio: 2018, patente: "MHF201"} }

  it 'La respuesta debe ser un mensaje exitoso' do
    post('/usuarios/1/intenciones_de_venta', datos_auto.to_json, { 'CONTENT_TYPE' => 'application/json' })
    body = JSON.parse(last_response.body)
    expect(body['mensaje']).to eq('intencion de venta registrada con exito')
    expect(body['id']).to eq(1)
  end

  it 'La respuesta debe ser un mensaje exitoso' do
    post('/usuarios/1/intenciones_de_venta', datos_auto.to_json, { 'CONTENT_TYPE' => 'application/json' })
    post('/usuarios/2/intenciones_de_venta', datos_auto_2.to_json, { 'CONTENT_TYPE' => 'application/json' })
    body = JSON.parse(last_response.body)
    expect(body['mensaje']).to eq('intencion de venta registrada con exito')
    expect(body['id']).to eq(2)
  end

end
