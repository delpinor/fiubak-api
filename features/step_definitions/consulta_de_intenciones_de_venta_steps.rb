Cuando('registro un auto para vender con marca {string}, modelo {string}, año {int} y patente {string} y guardo el id') do |marca, modelo, anio, patente|
    body = {
      'marca': marca,
      'modelo': modelo,
      'anio': anio,
      'patente': patente
    }
    @response = Faraday.post(registrar_nueva_venta(1), body.to_json, header)
  end

Cuando('consulto por mis autos registrados') do
    body = JSON.parse(@response.body)
    @response = Faraday.get(consultar_intenciones_de_venta(body['id']), nil, header)
end
  
Entonces('puedo ver mi auto con marca {string}, modelo {string}, año {int} y patente {string} y estado {string}') do |marca, modelo, anio, patente, estado|
    body = JSON.parse(@response.body)
    expect(body['mensaje']).to eq('intencion de venta recuperadas con exito')
    expect(body['valor']['estado']).to eq(estado)
    expect(body['valor']['auto']['marca']).to eq(marca)
    expect(body['valor']['auto']['modelo']).to eq(modelo)
    expect(body['valor']['auto']['anio']).to eq(anio)
    expect(body['valor']['auto']['patente']).to eq(patente)
end