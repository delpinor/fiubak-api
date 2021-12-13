Cuando('me registro con con nombre {string}, dni {string} y email {string}') do |nombre, dni, email|
  body = {
    'id': 23_734,
    'nombre': nombre,
    'dni': dni,
    'email': email
  }
  @response = Faraday.post(registrar_usuario_url, body.to_json, header(@id_usuario))
end

Entonces('me registro exitosamente') do
  body = JSON.parse(@response.body)
  expect(body['mensaje']).to eq('Registro exitoso bajo id: 23734')
end
