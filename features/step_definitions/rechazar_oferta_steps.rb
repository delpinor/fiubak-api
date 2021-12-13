Cuando('rechazo la oferta') do
  @response = Faraday.post(rechazar_oferta(@id_oferta), nil, header(@id_usuario))
end

Entonces('envio un mail rechazando la oferta') do
  mail_store = "#{Padrino.root}/tmp/emails"
  file = File.open("#{mail_store}/test@gmail.com", 'r')
  content = file.read
  content.include?('oferta fue rechazada').should be true
end
