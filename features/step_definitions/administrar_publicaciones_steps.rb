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

Dado('que existe una publicación p2p del auto del otro usuario') do
  step "rechazo la cotización de Fiubak y publico por p2p con precio 900000"
end

Dado('que dicha publicación recibe una oferta') do
  step "hago una oferta por el auto publicado"
end

Cuando('intento aceptar la oferta') do
  @response = Faraday.post(aceptar_oferta(@id_oferta), nil, header(@id_segundo_usuario))
end

Cuando('intento rechazar la oferta') do
  @response = Faraday.post(rechazar_oferta(@id_oferta), nil, header(@id_segundo_usuario))
end

Cuando('consulto la publicación de ese usuario') do
  @response = Faraday.get(consultar_detalle_publicacion(@id_publicacion), nil, header(@id_segundo_usuario))
end

Cuando('acepto la cotización') do
  datos = {id_intencion: @id_intencion}.to_json
  @response = Faraday.put(aceptar_cotizacion_url, datos, header(4393))
end

Cuando('yo rechazo la cotización de Fiubak y publico por p2p con precio {int}') do |precio|
  body = {
    'id_intencion_de_venta': @id_intencion,
    'precio': precio
  }
  @response = Faraday.post(crear_publicaciones, body.to_json, header(@id_segundo_usuario))
end

Cuando('registro un auto de otro usuario') do
  body = {
    'marca': "fiat",
    'modelo': "uno",
    'anio': 1988,
    'patente': "asd-457"
  }
  @response = Faraday.post(registrar_nueva_venta(@id_segundo_usuario), body.to_json, header(@id_primer_usuario))
end
