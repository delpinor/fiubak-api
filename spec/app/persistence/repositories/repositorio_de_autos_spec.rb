require 'integration_helper'

describe Persistence::Repositories::RepositorioDeAutos do
  let(:repo_autos) { Persistence::Repositories::RepositorioDeAutos.new }
  let(:auto) { Auto.new("fiat", 'uno', 1999, "MFS222", 1) }

  before do
    repo_autos.delete_all
  end

  it 'Al crear un auto debería tener cantidad 1' do
    repo_autos.save(auto)
    expect(repo_autos.all.count).to eq(1)
  end

  it 'Debería asignar un id' do
    nuevo_auto = repo_autos.save(auto)
    expect(nuevo_auto.id).to be_present
  end

  context 'Cuando un auto existe' do
    before :each do
      @nuevo_auto = repo_autos.save(auto)
      @id_auto = @nuevo_auto.id
    end

    it 'No debería tener autos al eliminar todos' do
      repo_autos.delete_all
      expect(repo_autos.all.count).to eq(0)
    end

    it 'Deber encontrar por el id' do
      auto = repo_autos.find(@id_auto)
      expect(auto.id).to eq(@nuevo_auto.id)
    end
  end

  it 'consultar auto por patente devuelve true si ya existe' do
    nuevo_auto = repo_autos.save(auto)
    expect(repo_autos.check_by_patente(nuevo_auto.patente)).to be(true)
  end

  it 'consultar auto por patente devuelve false si no existe' do
    expect(repo_autos.check_by_patente(auto.patente)).to be(false)
  end

  it 'Debería lanzar un error cuando el auto no existe' do
    expect do
      repo_autos.find(99999)
    end.to raise_error(ObjectNotFound)
  end
end
