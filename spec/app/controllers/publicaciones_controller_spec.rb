require 'integration_helper'

describe 'Publicaciones controller' do

  let(:publicacion) { {id: 1, marca: "fiat", modelo: "uno", anio: 2015, precio: 50000} }

  it 'La respuesta debe ser un mensaje exitoso' do
    get('/publicaciones')
    body = JSON.parse(last_response.body)
    expect(body).to eq([])
    expect(last_response.status).to eq(201)
  end

end
