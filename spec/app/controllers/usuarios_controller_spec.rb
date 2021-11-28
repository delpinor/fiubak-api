require 'integration_helper'

describe 'Usuarios controller' do

  let(:repo_usuario) { Persistence::Repositories::RepositorioDeUsuarios.new }
  let(:datos_usuario) { {:dni => 12456123, :nombre => 'pepe', :email => 'nmd@gmail.com'} }

  before do
    repo_usuario.delete_all
  end

  xit 'La respuesta debe ser un JSON con el mismo nombre' do
    headers = { "CONTENT_TYPE" => "application/json" }
    post '/usuarios', :params => datos_usuario.to_json, :headers => headers
    json = JSON.parse(last_response.body)
    expect(json['test']).to eq(datos_usuario[:nombre])
  end

  xit 'La respuesta debe tener un id' do
    headers = { "CONTENT_TYPE" => "application/json" }
    post '/usuarios', :params => datos_usuario.to_json, :headers => headers
    json = JSON.parse(last_response.body)
    expect(json['id']).not_to be_nil
  end

  xit 'La respuesta debe ser 201' do
    headers = { "CONTENT_TYPE" => "application/json" }
    post '/usuarios', :params => datos_usuario.to_json, :headers => headers
    expect(last_response.status).to eq(201)
  end
end
