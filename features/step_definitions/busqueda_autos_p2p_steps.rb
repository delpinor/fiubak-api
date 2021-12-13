Entonces('veo el auto {string} del anio {int} de modelo {string} y tipo {string} publicado por p2p por {int}') do |marca, anio, modelo, tipo, precio|
  @response = Faraday.get(obtener_publicaciones, nil, header(@id_usuario))
  publicaciones = JSON.parse(@response.body)
  datos = {"anio"=>anio, "marca"=>marca, "modelo"=>modelo, "precio"=>precio, "tipo"=>tipo}
  publicaciones.each { |pub| pub.delete("id") }
  expect(publicaciones.include?(datos)).to eq(true)
end


Cuando('busco ofertas de auto p2p') do
  @response = Faraday.get(obtener_publicaciones, nil, header(@id_usuario))
end
