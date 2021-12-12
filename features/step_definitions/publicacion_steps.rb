Cuando('rechazo la cotización de Fiubak y publico por p2p con precio {int}') do |precio|
    body = {
    'id_intencion_de_venta': @id_intencion,
    'precio': precio
  }
  @response = Faraday.post(crear_publicaciones, body.to_json, header)
  data = JSON.parse(@response.body)
  @id_publicacion = data['valor']['id_publicacion']
end

Entonces('veo el auto publicado con id correspondiente para venta a un valor de {int}') do |precio|
    @response = Faraday.get(obtener_publicaciones, nil, header)
    publicaciones = JSON.parse(@response.body)
    expect(publicaciones.any?{ |publicacion| publicacion['id'] == @id_publicacion && publicacion['precio'] == precio}).to eq(true)
  end
