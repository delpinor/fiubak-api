Cuando('consulto por mis autos registrados') do
    @response = Faraday.get(consultar_intenciones_de_venta(1), nil, header)
end
  
Entonces('puedo ver mi auto con marca {string}, modelo {string}, año {int} y patente {string} y estado {string}') do |marca, modelo, anio, patente, estado|
    body = JSON.parse(@response.body)
    expect(body['mensaje']).to eq('intenciones de venta recuperadas con exito')
    expect(body['intenciones_de_venta'][0]['estado']).to eq(estado)
    expect(body['intenciones_de_venta'][0]['auto']['marca']).to eq(marca)
    expect(body['intenciones_de_venta'][0]['auto']['modelo']).to eq(modelo)
    expect(body['intenciones_de_venta'][0]['auto']['anio']).to eq(anio)
    expect(body['intenciones_de_venta'][0]['auto']['patente']).to eq(patente)
end