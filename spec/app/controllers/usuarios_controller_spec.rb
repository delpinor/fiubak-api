require 'integration_helper'

describe 'Usuarios controller' do

  let(:repo_usuario) { Persistence::Repositories::RepositorioDeUsuarios.new }
  let(:datos_usuario) { {dni: 12778523, nombre: "pepe", email: "pepe@gmail.com", id: 343} }
  let(:datos_usuario2) { {dni: 12778523, nombre: "pepe", email: "pepe@gmail.com", id: 3443} }

  it 'La respuesta debe ser un mensaje exitoso' do
    post('/usuarios', datos_usuario.to_json, { 'CONTENT_TYPE' => 'application/json' })
    body = JSON.parse(last_response.body)
    expect(body['mensaje']).to eq('registro exitoso')
  end

  it 'La respuesta debe ser un mensaje de error al cargar DNI duplicado' do
    post('/usuarios', datos_usuario.to_json, { 'CONTENT_TYPE' => 'application/json' })
    post('/usuarios', datos_usuario2.to_json, { 'CONTENT_TYPE' => 'application/json' })
    body = JSON.parse(last_response.body)
    expect(body['mensaje']).to eq('se produjo un error')
  end

  it 'El estado debe ser 201 al crear correctamente' do
    post('/usuarios', datos_usuario.to_json, { 'CONTENT_TYPE' => 'application/json' })
    expect(last_response.status).to eq(201)
  end

end
