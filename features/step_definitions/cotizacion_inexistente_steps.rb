Cuando('intento aceptar la cotización de id {int} de Fiubak') do |id_consulta|
  datos = {id_intencion: id_consulta}
  @response = Faraday.put(aceptar_cotizacion_url, datos.to_json, header(@id_usuario))
  expect(@response.status).to eq(404)
end
