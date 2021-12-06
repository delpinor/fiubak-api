Cuando('intento aceptar la cotización de id {int} de Fiubak') do |id_consulta|
  datos = {id_intencion: id_consulta}
  @response = put('/aceptar_cotizacion', datos.to_json, { 'CONTENT_TYPE' => 'application/json' })
  expect(last_response.status).to eq(404)
end
