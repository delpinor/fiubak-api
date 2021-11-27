require 'integration_helper'

describe Persistence::Repositories::UserRepository do
  let(:repo_usuario) { Persistence::Repositories::RepositorioDeUsuario.new }
  let(:usuario) { Usuario.new(23434231, 'Jhon', 'jhon@gmail.com') }

  xit 'Debe haber un usuario' do
    repo_usuario.save(usuario)
    expect(repo_usuario.all.count).to eq(1)
  end

  xit 'Debe asignar un id' do
    nuevo_usuario = repo_usuario.save(usuario)
    expect(nuevo_usuario.id).to be_present
  end

  context 'Cuando un usuario existe' do
    before :each do
      @nuevo_usuario = repo_usuario.save(usuario)
      @id_usuario = @nuevo_usuario.id
    end

    xit 'No debería tener usuario al eliminar todos' do
      repo_usuario.delete_all
      expect(repo_usuario.all.count).to eq(0)
    end

    xit 'Deber encontrar por el id' do
      usuario = repo_usuario.find(@id_usuario)
      expect(usuario.nombre).to eq(@nuevo_usuario.nombre)
    end
  end

  xit 'Debería lanzar un error cuando el usuario no existe' do
    expect do
      repo_usuario.find(99_999)
    end.to raise_error(ObjectNotFound)
  end
end
