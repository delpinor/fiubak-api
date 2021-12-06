Dado('que no existen autos registrados') do
  Persistence::Repositories::RepositorioDeAutos.new.delete_all
end

Cuando('intento aceptarla cotización de id {int} de Fiubak') do |id_consulta|
  datos = {id_intencion: id_consulta}.to_json
  res = Faraday.put(aceptar_cotizacion_url, datos, header)
  data = JSON.parse(res.body)
  expect(res.status).to eq(404)
end
