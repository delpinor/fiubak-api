Entonces('obtengo un mensaje indicando que el auto no esta en condiciones de ser publicado') do
  expect(@response.status).to eq(409)
  data = JSON.parse(@response.body)
  mensaje = data['mensaje']
  expect(mensaje).to eq("El auto no esta en condiciones de ser publicado")
end