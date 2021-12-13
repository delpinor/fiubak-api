Dado('existe otro usuario registrado') do
  @id_primer_usuario = 1
  body = {
    'nombre': 'luis',
    'dni': 40_555_555,
    'email': 'luisito@gmail.com',
    'id': @id_primer_usuario
  }
  @response = Faraday.post(registrar_usuario_url, body.to_json, header(@id_primer_usuario))
end

Dado('que registro mi usuario') do
  @id_segundo_usuario = 2
  body = {
    'nombre': 'juan',
    'dni': 35_555_555,
    'email': 'juancito@gmail.com',
    'id': @id_segundo_usuario
  }
  @response = Faraday.post(registrar_usuario_url, body.to_json, header(@id_segundo_usuario))
end

Cuando('consulto el estado por la intención de venta') do
  @response = Faraday.get(consultar_intenciones_de_venta(@id_intencion), nil, header(@id_segundo_usuario))
end
