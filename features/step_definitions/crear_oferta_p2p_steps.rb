Cuando('hago una oferta por el auto publicado') do
  @precio = 150
  body = {
    'valor': @precio,
    'id_usuario': 1
  }
  @response = Faraday.post(registrar_nueva_oferta(@id_publicacion), body.to_json, header)
  data = JSON.parse(@response.body)
  @id_oferta = data['valor']['id']
  @precio = data['valor']['valor']
  @mensaje = data['mensaje']
end

Entonces('recibo un mensaje de que la oferta se generó correctamente') do
  expect(@mensaje).to eq("Generaste la oferta #{@id_oferta} con un monto de $#{@precio}")
end


Entonces('el vendedor es capaz de visualizar las ofertas consultando su publicacion') do
  @response = Faraday.get(consultar_detalle_publicacion(@id_publicacion), nil, header)
  body = JSON.parse(@response.body)
  expect(body['id']).to eq(@id_publicacion)
  expect(body['ofertas']).to be_present
  expect(body['ofertas'][0]['valor']).to be_present
end