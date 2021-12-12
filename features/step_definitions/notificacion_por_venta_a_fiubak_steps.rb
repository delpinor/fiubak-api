Entonces('recibo un email con la información de compra') do
  expect(true).to eq(true)
  mail_store = "#{Padrino.root}/tmp/emails"
  file = File.open("#{mail_store}/test@gmail.com", 'r')
  content = file.read
  content.include?(@patente).should be true
  content.include?('Felicidades! Su auto con patente').should be true
  content.include?('fue vendido con exito').should be true
end
