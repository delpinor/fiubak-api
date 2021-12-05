Dado('que no soy un usuario registrado') do
  Persistence::Repositories::RepositorioDeUsuarios.new.delete_all
end

Entonces('recibo un mensaje de error {string}') do |mensaje|
  data = JSON.parse(@response.body)
  expect(data['mensaje']).to eq(mensaje)
  expect(@response.status).to eq(404)

end
