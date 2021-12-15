Cuando('rechazo la cotización de Fiubak y publico por p2p con precio {int}') do |precio|
    body = {
    'id_intencion_de_venta': @id_intencion,
    'precio': precio
  }
  @response = Faraday.post(crear_publicaciones, body.to_json, header(1))
  data = JSON.parse(@response.body)
  @id_publicacion = data['valor']['id_publicacion']
end


Cuando('rechazo la cotización de Fiubak y publico por p2p con un precio de {int}') do |precio|
  body = {
  'id_intencion_de_venta': @id_intencion,
  'precio': precio
  }
  require 'byebug'
  @response = Faraday.post(crear_publicaciones, body.to_json, header(1))
  data = JSON.parse(@response.body)
end

Entonces('veo el auto publicado con id correspondiente para venta a un valor de {int}') do |precio|
  @response = Faraday.get(obtener_publicaciones, nil, header(@id_usuario))
  publicaciones = JSON.parse(@response.body)
  expect(publicaciones.any?{ |publicacion| publicacion['id'] == @id_publicacion && publicacion['precio'] == precio}).to eq(true)
end

Entonces('recibo un mensaje de error al crear la publicacion {string}') do |mensaje|
  data = JSON.parse(@response.body)
  expect(data['mensaje']).to eq(mensaje)
  expect(@response.status).to eq(409)
end

