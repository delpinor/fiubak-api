Cuando('se recibe una revision sin fallas') do
  @request = {id_intencion: @id_intencion,
              nivel_danio_motor: 0,
              nivel_danio_estetica: 0,
              nivel_danio_neumaticos: 0,
              precio_lista: 1000}.to_json
  @response = Faraday.post(revisiones_url, @request, header(@id_usuario))
  expect(@response.status).to eq(201)
end

Dado('se realizó la revisión sin fallas con precio de lista {int}') do |precio_lista|
  @request = {id_intencion: @id_intencion,
              nivel_danio_motor: 0,
              nivel_danio_estetica: 0,
              nivel_danio_neumaticos: 0,
              precio_lista: precio_lista}.to_json
  @response = Faraday.post(revisiones_url, @request, header(@id_usuario))
  expect(@response.status).to eq(201)
end

Entonces('recibo un mail con la cotizacion por mi auto') do
  expect(true).to eq(true)
  mail_store = "#{Padrino.root}/tmp/emails"
  file = File.open("#{mail_store}/test@gmail.com", 'r')
  content = file.read
  content.include?(@patente).should be true
end

Entonces('el estado de mi auto sera ‘revisado y cotizado’') do
  #step 'se recibe una revision sin fallas'
  @response = Faraday.get(consultar_intenciones_de_venta(@id_intencion), nil, header(@id_usuario))
  data = JSON.parse(@response.body)
  expect(data['valor']['estado']).to eq('revisado y cotizado')
end
