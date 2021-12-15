Entonces('obtengo un error de patente registrada') do
  body = JSON.parse(@response.body)
  expect(body['mensaje']).to eq("La patente ya se encuentra registrada en FIUBAK")
end