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
  step "registro un auto para vender con marca 'fiat', modelo 'uno', año 1988 y patente 'asd-457'"
  step "se realizó la revisión sin fallas con precio de lista 100"
  step "rechazo la cotización de Fiubak y publico por p2p con precio 200"
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
