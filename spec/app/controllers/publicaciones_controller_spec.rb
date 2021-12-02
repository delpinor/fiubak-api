require 'integration_helper'

describe 'Publicaciones controller' do

  let(:usuario){Usuario.new(99999, 'test', 'test@gmail.com', 9999)}
  let(:auto){Auto.new('fiat', 'palio', 1988, 'dfdsf23')}
  let(:intencion){IntencionDeVenta.new(auto, usuario, 'en revision')}

  it 'La respuesta debe ser un mensaje exitoso' do
    get('/publicaciones')
    body = JSON.parse(last_response.body)
    expect(body).to eq([])
    expect(last_response.status).to eq(200)
  end

  xit 'Cuando el usuario confirma la venta y consulto las busquedas obtengo una nueva publicacion' do
    IntencionDeVenta.concretar()
    
    get('/publicaciones')
    body = JSON.parse(last_response.body)
    expect(body.length()).to eq(1)
    expect(body[0]['id']).to be_present
    expect(body[0]['marca']).to eq(datos_auto['marca'])
    expect(body[0]['modelo']).to eq(datos_auto['modelo'])
    expect(body[0]['anio']).to eq(datos_auto['anio'])
    expect(body[0]['precio']).to eq(75000)
    expect(last_response.status).to eq(200)
  end


end
