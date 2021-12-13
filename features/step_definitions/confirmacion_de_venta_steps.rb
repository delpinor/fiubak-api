Dado('que fiubak puede comprar el auto con marca {string}, modelo {string}, año {int} a un precio de {int}') do |marca, modelo, anio, precio_de_lista|
end

Dado('se realizó la revisión sin fallas') do
end

Cuando('acepto la cotización de Fiubak') do
  datos = {id_intencion: @id_intencion}.to_json
  res = Faraday.put(aceptar_cotizacion_url, datos, header(@id_usuario))
  data = JSON.parse(res.body)
  expect(res.status).to eq(200)
end

Entonces('veo el auto publicado para venta a un valor de {int}') do |precio|
  @response = Faraday.get(obtener_publicaciones, nil, header(@id_usuario))
  publicaciones = JSON.parse(@response.body)
  datos = {"anio"=>2015, "marca"=>"Renault", "modelo"=>"Kangoo", "precio"=>precio, "tipo"=>"Fiubak"}
  publicaciones.each { |pub| pub.delete("id") }
  expect(publicaciones.include?(datos)).to eq(true)
end

Dado('la cotización del auto no fue rechazada') do
  @response = Faraday.get(consultar_intenciones_de_venta(@id_intencion), nil, header(@id_usuario))
  data = JSON.parse(@response.body)
  expect(data['valor']['estado']).not_to eq('rechazada')
end

Cuando('consulto el estado de mis autos') do
  @response = Faraday.get(consultar_intenciones_de_venta(@id_intencion), nil, header(@id_usuario))
  @data = JSON.parse(@response.body)
  expect(@response.status).to eq(200)
end

Entonces('figura en estado {string}') do |estado|
  expect(@data['valor']['estado']).to eq(estado)
end
