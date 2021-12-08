Cuando('acepto la oferta') do
  @response = Faraday.post(aceptar_oferta(@id_oferta))
end

Entonces('envio un mail de compra concretada con exito') do
  mail_store = "#{Padrino.root}/tmp/emails"
  file = File.open("#{mail_store}/test@gmail.com", 'r')
  content = file.read
  content.include?('oferta fue aceptada').should be true
end

Entonces('la publicacion no existe mas') do
  @response = Faraday.get(obtener_publicaciones)
  publicaciones = JSON.parse(@response.body)
  expect(publicaciones.any?{ |publicacion| publicacion['id'] == @id_publicacion}).to eq(false)
end

Entonces('el auto figura en estado "vendido"') do
  require 'byebug'
  debugger
  step 'consulto el estado de mis autos'
  step 'figura en estado "vendido"'
end