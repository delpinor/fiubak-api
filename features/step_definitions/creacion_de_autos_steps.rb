Dado('que soy usuario vendedor') do
  body = {
    'nombre': "nombre",
    'dni': 35555555,
    'email': "test@gmail.com",
    'id': 1
  }
  @response = Faraday.post(registrar_usuario_url, body.to_json, header)
end

Cuando('registro un auto para vender con marca {string}, modelo {string}, año {int} y patente {string}') do |marca, modelo, anio, patente|
  body = {
    'marca': marca,
    'modelo': modelo,
    'anio': anio,
    'patente': patente
  }
  @response = Faraday.post(registrar_nueva_venta(1), body.to_json, header)
  data = JSON.parse(@response.body)
  @id_intencion = data['id']
end

Entonces('el auto se carga exitosamente con estado ‘en revisión’') do
  body = JSON.parse(@response.body)
  expect(body['mensaje']).to eq('intencion de venta registrada con exito')
  expect(body['id']).to be_present
  # TODO: llamar a consulta de venta para obtener el estado, y validar ids con caracteristicas del auto
end
