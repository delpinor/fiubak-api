Cuando('registro un auto para vender con marca {string}, modelo {string}, año {int} y patente {string} y espero mensaje') do |marca, modelo, anio, patente|
  body = {
    'marca': marca,
    'modelo': modelo,
    'anio': anio,
    'patente': patente
  }
  @response = Faraday.post(registrar_nueva_venta(1), body.to_json, header(@id_usuario))
end

Cuando('consulto por mis autos registrados') do
  body = JSON.parse(@response.body)
  @response = Faraday.get(consultar_intenciones_de_venta(body['id']), nil, header(@id_usuario))
end

Cuando('consulto por el estado de la intención de venta con id {int}') do |id_intencion_de_venta|
  @response = Faraday.get(consultar_intenciones_de_venta(id_intencion_de_venta), nil, header(@id_usuario))
end

Entonces('puedo ver mi intencion de venta con id y estado {string}') do |estado|
  body = JSON.parse(@response.body)
  expect(body['mensaje']).to eq('intencion de venta recuperadas con exito')
  expect(body['valor']['estado']).to eq(estado)
  expect(body['valor']['id']).to be_present
end
