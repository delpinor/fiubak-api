Entonces('recibo un email con la información de la oferta') do
    expect(true).to eq(true)
    mail_store = "#{Padrino.root}/tmp/emails"
    file = File.open("#{mail_store}/test@gmail.com", 'r')
    content = file.read
    content.include?('Oferta Recibida').should be true
    content.include?('fue ofertada por un valor de pesos').should be true
end
