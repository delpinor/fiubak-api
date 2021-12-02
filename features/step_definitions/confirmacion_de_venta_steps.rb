Dado('que fiubak puede comprar el auto con marca {string}, modelo {string}, año {int} a un precio de {int}') do |marca, modelo, anio, precio_de_lista|
  
end

Dado('se realizó la revisión sin fallas') do
  
end


Cuando('acepto la cotización de Fiubak') do
  datos = {id_intencion: @id_intencion}.to_json
  res = Faraday.put(aceptar_cotizacion_url, datos, header)
  data = JSON.parse(res.body)
  expect(res.status).to eq(200)
end


Entonces('veo el auto publicado para venta a un valor de {int}') do |precio|
  @response = Faraday.get(obtener_publicaciones)
  publicaciones = JSON.parse(@response.body)
  expect(publicaciones.size).to eq(1)
  expect(publicaciones[0].precio).to eq(precio)
  expect(publicaciones[0].id).to eq(1)
end

Dado('la cotización del auto no fue rechazada') do
  @response = Faraday.get(consultar_intenciones_de_venta(@id_intencion))
  data = JSON.parse(@response.body)
  expect(data['valor']['estado']).not_to eq('rechazada')
end

Cuando('consulto el estado de mis autos') do
  @response = Faraday.get(consultar_intenciones_de_venta(@id_intencion))
  @data = JSON.parse(@response.body)
  expect(@response.status).to eq(200)
end

Entonces('figura en estado {string}') do |estado|
  expect(@data['valor']['estado']).to eq(estado)
end

