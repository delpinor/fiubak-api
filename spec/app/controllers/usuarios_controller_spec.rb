require 'integration_helper'

describe 'Usuarios controller' do

  let(:repo_usuario) { Persistence::Repositories::RepositorioDeUsuarios.new }
  let(:datos_usuario) { {:dni => 12456123, :nombre => 'pepe', :email => 'nmd@gmail.com'} }

  before do
    repo_usuario.delete_all
  end

  it 'La respuesta debe ser un JSON con el mismo nombre' do
    headers = { "CONTENT_TYPE" => "application/json" }
    post '/usuarios', :params => datos_usuario.to_json, :headers => headers
    expect(last_response.body.include?(datos_usuario[:nombre])).to eq(true)
  end

  it 'La respuesta debe tener un DNI' do
    headers = { "CONTENT_TYPE" => "application/json" }
    post '/usuarios', :params => datos_usuario.to_json, :headers => headers
    expect(last_response.body.include?(datos_usuario[:dni].to_s)).to eq(true)
  end

  xit 'La respuesta debe ser 201' do
    headers = { "CONTENT_TYPE" => "application/json" }
    post '/usuarios', :params => datos_usuario.to_json, :headers => headers
    expect(last_response.status).to eq(201)
  end
end
