Cuando('hago una oferta por el auto publicado con un monto distinto') do
  @precio = 50
  body = {
    'valor': @precio,
    'id_usuario': 1
  }
  @response = Faraday.post(registrar_nueva_oferta(@ids[0]), body.to_json, header(@id_usuario))
end

Cuando('hago una oferta por el auto publicado con el monto exacto') do
  @precio = 150
  body = {
    'valor': @precio,
    'id_usuario': 1
  }
  @response = Faraday.post(registrar_nueva_oferta(@ids[0]), body.to_json, header(@id_usuario))end


Dado('veo el auto publicado para venta') do
  @response = Faraday.get(obtener_publicaciones, nil, header(@id_usuario))
  publicaciones = JSON.parse(@response.body)
  @ids = []
  publicaciones.each { |pub| @ids.append(pub["id"]) }
end

Cuando('se acepta la oferta') do
  @response = Faraday.post(aceptar_oferta(@id_oferta), nil, header(0))
end

Entonces('recibo un mensaje que contiene {string}') do |mensaje|
  data = JSON.parse(@response.body)
  data['mensaje'].include?(mensaje).should be true
end

