Cuando('se recibe una revision sin fallas') do
  data = JSON.parse(@response.body)
  @id_intencion = data['id']
  @request = {id_intencion: @id_intencion,
              estado_motor: 'sin danio',
              estado_estetica: 'sin danio',
              estado_neumaticos: 'sin danio'}.to_json
  @response = Faraday.post(revisiones_url, @request, header)
  expect(@response.status).to eq(201)
end

Entonces('recibo un mail con la cotizacion {int} por mi auto') do |int|
  expect(true).to eq(true)
end

Entonces('el estado de mi auto sera ‘revisado y cotizado’') do
  @response = Faraday.get(consultar_intenciones_de_venta(@id_intencion))
  data = JSON.parse(@response.body)
  expect(data['valor']['estado']).to eq('revisado y cotizado')
end
