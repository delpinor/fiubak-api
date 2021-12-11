Dado('Ya esta registrado el usuario de nombre {string}, dni {string} y email {string}') do |nombre, dni, email|
  body = {
    'id': 23_734,
    'nombre': nombre,
    'dni': dni,
    'email': email
  }
  @response = Faraday.post(registrar_usuario_url, body.to_json, header)
end
