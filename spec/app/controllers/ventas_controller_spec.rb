require 'integration_helper'

describe 'Ventas controller' do

  let(:datos_auto) { {marca: "Mercedes", modelo: "2322", anio: 2018, patente: "MHF200"} }
  let(:datos_auto_2) { {marca: "Mercedes", modelo: "2322", anio: 2018, patente: "MHF201"} }
  let(:datos_usuario) { {dni: 12778523, nombre: "pepe", email: "pepe@gmail.com", id: 343} }
  let(:datos_usuario_2) { {dni: 4084821, nombre: "pepe", email: "pepe@gmail.com", id: 400} }
  let(:datos_usuario_3) { {dni: 1231233, nombre: "pepe", email: "pepe@gmail.com", id: 1234} }

  it 'La respuesta debe ser un mensaje exitoso' do
    post('/usuarios', datos_usuario.to_json, { 'CONTENT_TYPE' => 'application/json' })
    post('/usuarios/343/intenciones_de_venta', datos_auto.to_json, { 'CONTENT_TYPE' => 'application/json' })
    body = JSON.parse(last_response.body)
    expect(body['mensaje']).to eq('intencion de venta registrada con exito')
    expect(body['id']).to be_present
  end

  it 'cuando creamos 2 intenciones de venta la respuesta es exitosa' do
    post('/usuarios', datos_usuario_2.to_json, { 'CONTENT_TYPE' => 'application/json' })
    post('/usuarios', datos_usuario.to_json, { 'CONTENT_TYPE' => 'application/json' })
    post('/usuarios/343/intenciones_de_venta', datos_auto.to_json, { 'CONTENT_TYPE' => 'application/json' })
    post('/usuarios/400/intenciones_de_venta', datos_auto_2.to_json, { 'CONTENT_TYPE' => 'application/json' })
    body = JSON.parse(last_response.body)
    expect(body['mensaje']).to eq('intencion de venta registrada con exito')
    expect(body['id']).to be_present
  end

  it '2 creaciones de intenciones de venta distintas el id es distinto' do
    post('/usuarios', datos_usuario_2.to_json, { 'CONTENT_TYPE' => 'application/json' })
    post('/usuarios', datos_usuario.to_json, { 'CONTENT_TYPE' => 'application/json' })
    post('/usuarios/343/intenciones_de_venta', datos_auto.to_json, { 'CONTENT_TYPE' => 'application/json' })
    primer_intencion_de_venta_id = JSON.parse(last_response.body)['id']
    post('/usuarios/400/intenciones_de_venta', datos_auto_2.to_json, { 'CONTENT_TYPE' => 'application/json' })
    body = JSON.parse(last_response.body)
    expect(body['mensaje']).to eq('intencion de venta registrada con exito')
    expect(body['id']).not_to eq primer_intencion_de_venta_id
  end

  it 'Cuando creo una intencion de venta y consulto las intenciones de venta del usuario entonces veo la intencion de venta' do
    post('/usuarios', datos_usuario_3.to_json, { 'CONTENT_TYPE' => 'application/json' })
    post('/usuarios/1234/intenciones_de_venta', datos_auto.to_json, { 'CONTENT_TYPE' => 'application/json' })
    get('/usuarios/1234/intenciones_de_venta', datos_auto.to_json, { 'CONTENT_TYPE' => 'application/json' })
    body = JSON.parse(last_response.body)
    expect(body['intenciones_de_venta'].size).to eq(1) 
  end

end
