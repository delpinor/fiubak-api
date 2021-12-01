require 'integration_helper'

describe Persistence::Repositories::RepositorioDePublicaciones do
  let(:repo_autos) { Persistence::Repositories::RepositorioDeAutos.new }
  let(:repo_usuario) { Persistence::Repositories::RepositorioDeUsuarios.new }
  let(:repo_publicaciones) { Persistence::Repositories::RepositorioDePublicaciones.new }
  let(:auto) { Auto.new("fiat", 'uno', 1999, "MFS222") }
  let(:usuario) { Usuario.new(12323423, 'Jhon', 'jhon@gmail.com', 3002) }
  let(:publicacion) { Publicacion.new(usuario, auto, 75000, 1) }

  before do
    repo_autos.delete_all
    repo_usuario.delete_all
    repo_publicaciones.delete_all
  end

  it 'Al crear una publicacion debería tener cantidad 1' do
    repo_autos.save(auto)
    repo_usuario.save(usuario)
    repo_publicaciones.save(publicacion)
    expect(repo_publicaciones.all.count).to eq(1)
  end

  it 'Debería asignar un id' do
    repo_autos.save(auto)
    repo_usuario.save(usuario)
    nueva_publicacion = repo_publicaciones.save(publicacion)
    expect(nueva_publicacion.id).to be_present
  end

  context 'Cuando una publicacion existe' do
    before :each do
      repo_autos.save(auto)
      repo_usuario.save(usuario)
      @nueva_publicacion = repo_publicaciones.save(publicacion)
      @id_publicacion = @nueva_publicacion.id
    end

    it 'No debería tener publicaciones al eliminar todas' do
      repo_publicaciones.delete_all
      expect(repo_publicaciones.all.count).to eq(0)
    end

    it 'Deber encontrar por el id' do
      publicacion = repo_publicaciones.find(@id_publicacion)
      expect(publicacion.id).to eq(@nueva_publicacion.id)
    end

    it 'Deber encontrar por el id y poder mapear el precio' do
      publicacion = repo_publicaciones.find(@id_publicacion)
      expect(publicacion.precio).to eq(75000)
    end

    it 'Deber encontrar por el id y poder mapear el auto' do
      publicacion = repo_publicaciones.find(@id_publicacion)
      expect(publicacion.auto.id).to eq(auto.id)
    end

    it 'Deber encontrar por el id y poder mapear el usuario' do
      publicacion = repo_publicaciones.find(@id_publicacion)
      expect(publicacion.usuario.id).to eq(usuario.id)
    end
  end
end