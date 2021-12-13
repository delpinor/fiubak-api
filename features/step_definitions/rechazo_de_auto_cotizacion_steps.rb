Dado('cuando termina la revision el estado tiene falla de neumaticos {string} y falla de estetica {string} y falla de motor {string} y precio de lista {int}') do |neumaticos, estetica, motor, precio|
  @request = {id_intencion: @id_intencion,
              nivel_danio_motor: NivelDanioHerlper.new.nivel_en_letra(motor),
              nivel_danio_estetica: NivelDanioHerlper.new.nivel_en_letra(estetica),
              nivel_danio_neumaticos: NivelDanioHerlper.new.nivel_en_letra(neumaticos),
              precio_lista: precio}.to_json
  @response = Faraday.post(revisiones_url, @request, header(@id_usuario))
end

Entonces('la cotizacion es rechazada') do
  expect(@response.status).to eq(200)
  data = JSON.parse(@response.body)
  mensaje = data['mensaje']
  expect(mensaje).to eq("El auto no se encontraba en buen estado y no logró pasar la revisión")
end

Entonces('el estado del auto es rechazado') do
  step 'consulto el estado de mis autos'
  step 'figura en estado "rechazado"'
end
