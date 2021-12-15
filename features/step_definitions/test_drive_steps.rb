Dado('que existe una publicación de Fiubak con valor {int}') do |precio|
  step 'que soy usuario vendedor'
  step 'registro un auto para vender con marca "fiat", modelo "uno", año 1988 y patente "asd-457"'
  step "se realizó la revisión sin fallas con precio de lista 1000"
  step 'acepto la cotización de Fiubak'
  step "veo el auto publicado por Fiubak para venta a un valor de #{precio}"
  
end

Dado('existe una publicacion p2p con valor {int}') do |precio|
  step 'que soy usuario vendedor'
  step 'registro un auto para vender con marca "fiat", modelo "uno", año 1988 y patente "xd-457"'
  step 'se realizó la revisión sin fallas con precio de lista 100'
  step "rechazo la cotización de Fiubak y publico por p2p con precio #{precio}"
end

Entonces('veo el auto publicado por Fiubak para venta a un valor de {int}') do |precio|
  @response = Faraday.get(obtener_publicaciones, nil, header(@id_usuario))
  publicaciones = JSON.parse(@response.body)
  datos = {"anio": 1988, "marca": "fiat", "modelo": "uno", "precio": precio, "tipo": "Fiubak"}
  find_pub = publicaciones.select {|pub| (pub["anio"] == 1988 and pub["marca"] == "fiat" and pub["modelo"] == "uno" and pub["precio"] == precio and pub["tipo"] == "Fiubak" )}
  expect(find_pub[0]["id"]).to be_present
  @id_publicacion_fiubak = find_pub[0]["id"]
end


Cuando('solicito el test-drive en un dia sin lluvia') do
  Faraday.post(fijar_clima(), {:clima => "nublado"}.to_json, header(@id_usuario))
  request = {id_usuario: @id_usuario}.to_json
  @response = Faraday.post(solicitar_test_drive(@id_publicacion_fiubak), request, header(@id_usuario))
end

Cuando('solicito el test-drive en un dia con lluvia') do
  Faraday.post(fijar_clima(), {:clima => "lluvioso"}.to_json, header(@id_usuario))
  request = {id_usuario: @id_usuario}.to_json
  @response = Faraday.post(solicitar_test_drive(@id_publicacion_fiubak), request, header(@id_usuario))
end

Cuando('solicito el test-drive en un dia con lluvia de una publicacion p2p') do
  Faraday.post(fijar_clima(), {:clima => "lluvioso"}.to_json, header(@id_usuario))
  request = {id_usuario: @id_usuario}.to_json
  @response = Faraday.post(solicitar_test_drive(@id_publicacion), request, header(@id_usuario))
end

Entonces('obtengo un mensaje {string}') do |msg|
  data = JSON.parse(@response.body)
  @mensaje = data['mensaje']
  expect(@mensaje).to eq(msg)
end

Entonces('recibo un email confirmando la reserva de test-drive') do
  mail_store = "#{Padrino.root}/tmp/emails"
  file = File.open("#{mail_store}/test@gmail.com", 'r')
  content = file.read
  content.include?('La reserva de un test-drive para el auto').should be true
end
