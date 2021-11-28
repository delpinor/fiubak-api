
Cuando('me registro con con nombre {string}, dni {string} y email {string}') do |nombre, dni, email|
  body = {
    'nombre': nombre,
    'dni': dni,
    'email':email
  }
  @response = Faraday.post('/usuarios', body.to_json, header)
end

Entonces('me registro exitosamente') do
  body = JSON.parse(@response.body)
  expect(body['mensaje']).to eq('registro exitoso')
end
