Dado('que fiubak puede comprar el auto con marca {string}, modelo {string}, año {int} a un precio de {int}') do |marca, modelo, anio, precio_de_lista|
  
end

Dado('se realizó la revisión sin fallas') do
  
end


Cuando('acepto la cotización de Fiubak') do
  
end


Entonces('veo el auto publicado para venta a un valor de {int}') do |precio|
  @response = Faraday.get(obtener_publicaciones)
  publicaciones = JSON.parse(@response.body)
  expect(publicaciones.size).to eq(1)
  expect(publicaciones[0].precio).to eq(precio)
  expect(publicaciones[0].id).to eq(1)
end
