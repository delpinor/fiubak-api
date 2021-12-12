require 'integration_helper'

describe Persistence::Repositories::RepositorioDeTestDrives do
  let(:repo_autos) { Persistence::Repositories::RepositorioDeAutos.new }
  let(:repo_test_drives) { Persistence::Repositories::RepositorioDeTestDrives.new }
  let(:repo_usuario) { Persistence::Repositories::RepositorioDeUsuarios.new }
  let(:repo_publicaciones) { Persistence::Repositories::RepositorioDePublicaciones.new }
  let(:auto) { Auto.new("fiat", 'uno', 1999, "MFS222", 1) }
  let(:publicacion) { Publicacion.new(usuario, auto, 75000, "Fiubak", 1) }
  let(:usuario) { Usuario.new(12323423, 'Jhon', 'jhon@gmail.com', 34212) }
  let(:test_drive) { TestDrive.new(publicacion, "2020-05-05", 400) }

  before do
    repo_usuario.delete_all
    repo_autos.save(auto)
    repo_usuario.save(usuario)
  end

  it 'Al crear un test_drive debería tener cantidad 1' do
    publicacion_guardada = repo_publicaciones.save(publicacion)
    test_drive = TestDrive.new(publicacion_guardada, "2020-05-05", 400)
    td = repo_test_drives.save(test_drive)
    expect(repo_test_drives.all.count).to eq(1)
  end

  it 'Debería asignar un id' do
    publicacion_guardada = repo_publicaciones.save(publicacion)
    test_drive = TestDrive.new(publicacion_guardada, "2020-05-05", 400)
    td = repo_test_drives.save(test_drive)
    nuevo_test_drive = repo_test_drives.find(test_drive.id)
    expect(nuevo_test_drive.id).to be_present
  end
end
