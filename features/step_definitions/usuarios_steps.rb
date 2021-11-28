
Cuando('me registro con con nombre {string}, dni {string} y email {string}') do |nombre, dni, email|
  Persistence::Repositories::RepositorioDeUsuarios.new.delete_all
  datos = {nombre: nombre, dni: dni, email: email}.to_json
  post('/usuarios', datos, { 'CONTENT_TYPE' => 'application/json' })
end

Entonces('me registro exitosamente') do
  body = JSON.parse(last_response.body)
  #expect(last_response.status).to eq(201)
  expect(body['mensaje']).to eq('registro exitoso')
end
