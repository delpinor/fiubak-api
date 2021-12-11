Dado('que existe una publicación de Fiubak con valor {int}') do |int|
  step 'que soy usuario vendedor'
  step 'registro un auto para vender con marca "fiat", modelo "uno", año 1988 y patente "asd-457"'
  step 'se realizó la revisión sin fallas con precio de lista 100'
  step 'acepto la cotización de Fiubak'
end

Dado('existe una publicacion p2p') do
  step 'que soy usuario vendedor'
  step 'registro un auto para vender con marca "fiat", modelo "uno", año 1988 y patente "asd-457"'
  step 'se realizó la revisión sin fallas con precio de lista 100'
  step 'rechazo la cotización de Fiubak y publico por p2p con precio 200'
end

Cuando('solicito el test-drive en un dia sin lluvia') do
  Faraday.post(fijar_clima(), {:clima => "nublado"}.to_json)
  request = {id_usuario: @id_usuario}.to_json
  @response = Faraday.post(solicitar_test_drive(@id_publicacion), request, header)
end

Cuando('solicito el test-drive en un dia con lluvia') do
  Faraday.post(fijar_clima(), {:clima => "lluvioso"}.to_json)
  
  request = {id_usuario: @id_usuario}.to_json
  @response = Faraday.post(solicitar_test_drive(@id_publicacion), request, header)
end

Entonces('obtengo un mensaje {string}') do |msg|
  data = JSON.parse(@response.body)
  @mensaje = data['mensaje']
  expect(@mensaje).to eq(msg)
end

Entonces('obtengo una notificacion por mail') do
  mail_store = "#{Padrino.root}/tmp/emails"
  file = File.open("#{mail_store}/test@gmail.com", 'r')
  content = file.read
  content.include?('contratacion de test-drive exitosa').should be true
end