Cuando('se recibe una revision sin fallas') do
  @request = {id_intencion: @id_intencion,
              estado_motor: 'sin danio',
              estado_estetica: 'sin danio',
              estado_neumaticos: 'sin danio'}.to_json
  @response = Faraday.post(revisiones_url, @request, header)
  expect(@response.status).to eq(201)
end

@local
Entonces('recibo un mail con la cotizacion por mi auto') do
  expect(true).to eq(true)
  mail_store = "#{Padrino.root}/tmp/emails"
  file = File.open("#{mail_store}/test@gmail.com", 'r')
  content = file.read
  content.include?(@patente).should be true
end

Entonces('el estado de mi auto sera ‘revisado y cotizado’') do
  step 'se recibe una revision sin fallas'
  @response = Faraday.get(consultar_intenciones_de_venta(@id_intencion))
  data = JSON.parse(@response.body)
  expect(data['valor']['estado']).to eq('revisado y cotizado')
end
