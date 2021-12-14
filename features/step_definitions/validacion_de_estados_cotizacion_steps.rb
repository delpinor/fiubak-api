Entonces('obtengo un mensaje indicando que el auto no esta en condiciones de ser publicado') do
  expect(@response.status).to eq(409)
  data = JSON.parse(@response.body)
  mensaje = data['mensaje']
  expect(mensaje).to eq("El auto no esta en condiciones de ser publicado")
end


Cuando('rechazo la cotización de Fiubak y publico por p2p con precio {int} final') do |precio|
  body = {
  'id_intencion_de_venta': @id_intencion,
  'precio': precio
  }
  @response = Faraday.post(crear_publicaciones, body.to_json, header(1))
end


Cuando('acepto la cotización de Fiubak del auto') do
  datos = {id_intencion: @id_intencion}.to_json
  @response = Faraday.put(aceptar_cotizacion_url, datos, header(1))
end