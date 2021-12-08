require 'integration_helper'

describe Persistence::Repositories::RepositorioDeOfertas do
  let(:repo_autos) { Persistence::Repositories::RepositorioDeAutos.new }
  let(:repo_ofertas) { Persistence::Repositories::RepositorioDeOfertas.new }
  let(:repo_usuario) { Persistence::Repositories::RepositorioDeUsuarios.new }
  let(:repo_publicaciones) { Persistence::Repositories::RepositorioDePublicaciones.new }
  let(:auto) { Auto.new("fiat", 'uno', 1999, "MFS222", 1) }
  let(:publicacion) { Publicacion.new(usuario, auto, 75000, "Fiubak", 1) }
  let(:usuario) { Usuario.new(12323423, 'Jhon', 'jhon@gmail.com', 34212) }
  let(:oferta) { Oferta.new(usuario, 45000, nil, publicacion.id) }

  before do
    repo_usuario.delete_all

    repo_autos.save(auto)
    repo_usuario.save(usuario)
    publicacion_guardada = repo_publicaciones.save(publicacion)
    publicacion_guardada.ofertas << oferta
    repo_publicaciones.save(publicacion_guardada)
  end

  it 'Al crear una oferta debería tener cantidad 1' do
    expect(repo_ofertas.all.count).to eq(1)
  end

  it 'Debería asignar un id' do
    nuevo_oferta = repo_ofertas.find(oferta.id)
    expect(nuevo_oferta.id).to be_present
  end
end
