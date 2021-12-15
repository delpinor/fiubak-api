require 'integration_helper'

describe 'Ventas controller' do

  let(:datos_auto) { {marca: "Mercedes", modelo: "2322", anio: 2018, patente: "MHF200"} }
  let(:datos_auto_2) { {marca: "Mercedes", modelo: "2322", anio: 2018, patente: "MHF201"} }
  let(:datos_usuario) { {dni: 12778523, nombre: "pepe", email: "pepe@gmail.com", id: 343} }
  let(:datos_usuario_2) { {dni: 4084821, nombre: "pepe", email: "pepe@gmail.com", id: 400} }
  let(:datos_usuario_3) { {dni: 1231233, nombre: "pepe", email: "pepe@gmail.com", id: 1234} }

  it 'La respuesta debe ser un mensaje exitoso' do
    post('/usuarios', datos_usuario.to_json, header_con_token(datos_usuario[:id]))
    post('/usuarios/343/intenciones_de_venta', datos_auto.to_json, header_con_token(datos_usuario[:id]))
    body = JSON.parse(last_response.body)
    id_venta = body['id']
    expect(body['mensaje']).to eq("Intención de venta registrada bajo el nro. #{id_venta}")
    expect(body['id']).to be_present
  end

  it 'Al intentar registrar un auto sin registrar el usuario recibo un mensaje de error' do
    post('/usuarios/343/intenciones_de_venta', datos_auto.to_json, header_con_token(datos_usuario[:id]))
    body = JSON.parse(last_response.body)
    expect(body['mensaje']).to eq('Para realizar esta operacion debe registrarse')
  end

  it 'Al intentar registrar una misma patente dos veces recibo un mensaje de error' do
    post('/usuarios', datos_usuario.to_json, header_con_token(datos_usuario[:id]))
    post('/usuarios/343/intenciones_de_venta', datos_auto.to_json, header_con_token(datos_usuario[:id]))
    post('/usuarios/343/intenciones_de_venta', datos_auto.to_json, header_con_token(datos_usuario[:id]))
    body = JSON.parse(last_response.body)
    expect(body['mensaje']).to eq('La patente ya se encuentra registrada en FIUBAK')
  end

  it 'cuando creamos 2 intenciones de venta la respuesta es exitosa' do
    post('/usuarios', datos_usuario_2.to_json, header_con_token(datos_usuario_2[:id]))
    post('/usuarios', datos_usuario.to_json, header_con_token(datos_usuario[:id]))
    post('/usuarios/343/intenciones_de_venta', datos_auto.to_json, header_con_token(datos_usuario[:id]))
    post('/usuarios/400/intenciones_de_venta', datos_auto_2.to_json, header_con_token(datos_usuario_2[:id]))
    body = JSON.parse(last_response.body)
    id_venta = body['id']
    expect(body['mensaje']).to eq("Intención de venta registrada bajo el nro. #{id_venta}")
    expect(body['id']).to be_present
  end

  it '2 creaciones de intenciones de venta distintas el id es distinto' do
    post('/usuarios', datos_usuario_2.to_json, header_con_token(datos_usuario_2[:id]))
    post('/usuarios', datos_usuario.to_json, header_con_token(datos_usuario[:id]))
    post('/usuarios/343/intenciones_de_venta', datos_auto.to_json, header_con_token(datos_usuario[:id]))
    primer_intencion_de_venta_id = JSON.parse(last_response.body)['id']
    post('/usuarios/400/intenciones_de_venta', datos_auto_2.to_json, header_con_token(datos_usuario_2[:id]))
    body = JSON.parse(last_response.body)
    id_venta = body['id']
    expect(body['mensaje']).to eq("Intención de venta registrada bajo el nro. #{id_venta}")
    expect(body['id']).not_to eq primer_intencion_de_venta_id
  end

  context 'Consulta de intenciones de venta' do

    #TODO VER
    it 'Cuando creo una intencion de venta y consulto las intenciones de venta del usuario entonces recibo una intencion de venta con su estado y id' do
      post('/usuarios', datos_usuario_3.to_json, header_con_token(datos_usuario_3['id']))
      post('/usuarios/1234/intenciones_de_venta', datos_auto.to_json, header_con_token(datos_usuario_3[:id]))
      id_intencion_de_venta = JSON.parse(last_response.body)['id']
      #debugger
      get('/intenciones_de_venta/' + id_intencion_de_venta.to_s, datos_auto.to_json, header_con_token(datos_usuario_3[:id]))
      body = JSON.parse(last_response.body)
      expect(body['valor']['id']).to be_present
      expect(body['valor']['estado']).to eq('en revisión')
    end

    it 'Cuando consulto el estado de una intencion de venta inexistente, entonces veo un mensaje de venta inexistente' do
      get('/intenciones_de_venta/-1',nil, header_con_token(datos_usuario['id']))
      body = JSON.parse(last_response.body)
      expect(body['mensaje']).to eq('Intención de venta inexistente.')
    end
  end
end
