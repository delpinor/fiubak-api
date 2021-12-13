Dado('que soy usuario vendedor') do
  @id_usuario = 1
  body = {
    'nombre': 'nombre',
    'dni': 35_555_555,
    'email': 'test@gmail.com',
    'id': 1
  }
  @response = Faraday.post(registrar_usuario_url, body.to_json, header(@id_usuario))
end

Cuando('registro un auto para vender con marca {string}, modelo {string}, año {int} y patente {string}') do |marca, modelo, anio, patente|
  body = {
    'marca': marca,
    'modelo': modelo,
    'anio': anio,
    'patente': patente
  }
  @response = Faraday.post(registrar_nueva_venta(1), body.to_json, header(@id_usuario))
  data = JSON.parse(@response.body)
  @id_intencion = data['id']
  @patente = patente
end

Entonces('el auto se carga exitosamente con estado ‘en revisión’') do
  step 'consulto por mis autos registrados'
  step 'puedo ver mi intencion de venta con id y estado "en revisión"'
end
