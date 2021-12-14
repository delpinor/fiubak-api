require 'integration_helper'

describe "Repo usuarios" do
  let(:repo_usuario) { Persistence::Repositories::RepositorioDeUsuarios.new }
  let(:usuario) { Usuario.new(12323423, 'Jhon', 'jhon@gmail.com', 34212) }

  before do
    repo_usuario.delete_all
  end

  it 'Al crear un usuario debería tener cantidad 1' do
    repo_usuario.save(usuario)
    expect(repo_usuario.all.count).to eq(1)
  end

  it 'Debería asignar un id' do
    nuevo_usuario = repo_usuario.save(usuario)
    expect(nuevo_usuario.id).to be_present
  end

  context 'Cuando un usuario existe' do
    before :each do
      @nuevo_usuario = repo_usuario.save(usuario)
      @id_usuario = @nuevo_usuario.id
    end

    it 'No debería tener usuarios al eliminar todos' do
      repo_usuario.delete_all
      expect(repo_usuario.all.count).to eq(0)
    end

    it 'Deber encontrar por el id' do
      usuario = repo_usuario.find(@id_usuario)
      expect(usuario.nombre).to eq(@nuevo_usuario.nombre)
    end
  end

  it 'Debería lanzar un error cuando el usuario no existe' do
    expect do
      repo_usuario.find(99999)
    end.to raise_error(UsuarioNoEncontradoError)
  end
end
