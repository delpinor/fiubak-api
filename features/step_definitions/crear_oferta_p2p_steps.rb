Cuando('hago una oferta por el auto publicado') do
  @precio = 150
  body = {
    'precio': @precio
  }
  @response = Faraday.post(registrar_nueva_oferta(1), body.to_json, header)
  data = JSON.parse(@response.body)
  @id_intencion = data['id']
  @patente = patente
end

Entonces('recibo un mensaje de que la oferta se generó correctamente') do
  data = JSON.parse(@response.body)
  expect(body['mensaje']).to eq("Generaste la oferta #{data['id']} con un monto de $#{@precio}}")
end