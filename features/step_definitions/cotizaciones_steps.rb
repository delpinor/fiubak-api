Dado('que existe un auto en estado revision') do
  step "que soy usuario vendedor"
  step "registro un auto para vender con marca 'fiat', modelo 'uno', año 1988 y patente 'asd-457'"
end

Dado('cuando termina la revision el estado tiene falla de neumaticos {string} y precio de lista {int}') do |nivel, precio|
  @request = {id_intencion: @id_intencion,
              nivel_danio_motor: 0,
              nivel_danio_estetica: 0,
              nivel_danio_neumaticos: NivelDanioHerlper.new.nivel_en_letra(nivel),
              precio_lista: precio}.to_json
  @response = Faraday.post(revisiones_url, @request, header(@id_usuario))
  expect(@response.status).to eq(201)
end

Entonces('el precio de la cotización es {int}') do |precio|
  intencion = Persistence::Repositories::RepositorioDeIntencionesDeVenta.new.find(@id_intencion)
  expect(intencion.precio_cotizado).to eq (precio)
end
