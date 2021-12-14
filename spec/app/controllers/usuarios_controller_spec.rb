require 'integration_helper'

describe 'Usuarios controller' do

  let(:repo_usuario) { Persistence::Repositories::RepositorioDeUsuarios.new }
  let(:datos_usuario) { {dni: 12778523, nombre: "pepe", email: "pepe@gmail.com", id: 343} }
  let(:datos_usuario2) { {dni: 12778523, nombre: "pepe", email: "mama@gmail.com", id: 3443} }
  let(:datos_usuario3) { {dni: 12779999, nombre: "lucas", email: "pepe@gmail.com", id: 3443} }
  let(:datos_usuario4) { {dni: 12779999, nombre: "gaston", email: "PEPE@gmail.com", id: 3443} }

  it 'La respuesta debe ser un mensaje exitoso' do
    post('/usuarios', datos_usuario.to_json, header_con_token(datos_usuario[:id]))
    body = JSON.parse(last_response.body)
    expect(body['mensaje']).to eq('Registro exitoso bajo id: 343')
  end

  it 'La respuesta debe ser un mensaje de error al cargar DNI duplicado' do
    post('/usuarios', datos_usuario.to_json, header_con_token(datos_usuario[:id]))
    post('/usuarios', datos_usuario2.to_json, header_con_token(datos_usuario2[:id]))
    body = JSON.parse(last_response.body)
    expect(body['mensaje']).to eq('El número de DNI ya está registrado.')
  end

  it 'La respuesta debe ser un mensaje de email duplicado al cargar email duplicado' do
    post('/usuarios', datos_usuario.to_json, header_con_token(datos_usuario[:id]))
    post('/usuarios', datos_usuario3.to_json, header_con_token(datos_usuario3[:id]))
    body = JSON.parse(last_response.body)
    expect(body['mensaje']).to eq('El email ya se encuentra registrado')
  end

  it 'La respuesta debe ser email duplicado al cargar email duplicado aunque se diferencie por letras capitales' do
    post('/usuarios', datos_usuario3.to_json, header_con_token(datos_usuario3[:id]))
    post('/usuarios', datos_usuario4.to_json, header_con_token(datos_usuario4[:id]))
    body = JSON.parse(last_response.body)
    expect(body['mensaje']).to eq('El email ya se encuentra registrado')
  end

  it 'El estado debe ser 201 al crear correctamente' do
    post('/usuarios', datos_usuario.to_json, header_con_token(datos_usuario[:id]))
    expect(last_response.status).to eq(201)
  end

  it 'El estado debe ser 401 al  dado que no estoy autorizado' do
    post('/usuarios', datos_usuario.to_json, header_sin_token(datos_usuario[:id]))
    expect(last_response.status).to eq(401)
  end

end
