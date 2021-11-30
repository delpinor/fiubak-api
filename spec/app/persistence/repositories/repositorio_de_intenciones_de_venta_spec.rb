require 'integration_helper'

describe Persistence::Repositories::RepositorioDeIntencionesDeVenta do
  let(:repo_autos) { Persistence::Repositories::RepositorioDeAutos.new }
  let(:repo_usuario) { Persistence::Repositories::RepositorioDeUsuarios.new }
  let(:repo_intenciones_de_venta) { Persistence::Repositories::RepositorioDeIntencionesDeVenta.new }
  let(:auto) { Auto.new("fiat", 'uno', 1999, "MFS222") }
  let(:auto1) { Auto.new("fiat", 'uno', 1999, "MFS223") }
  let(:auto2) { Auto.new("fiat", 'uno', 1999, "MFS224") }
  let(:auto3) { Auto.new("fiat", 'uno', 1999, "MFS225") }
  let(:usuario) { Usuario.new(12323423, 'Jhon', 'jhon@gmail.com', 3002) }
  let(:usuario1) { Usuario.new(12331112, 'Jhon', 'jhon@gmail.com', 3004) }
  let(:usuario2) { Usuario.new(1231234, 'Jhon', 'jhon@gmail.com', 3006) }
  let(:intencion_de_venta) { IntencionDeVenta.new(auto, usuario, "en revision", 1) }
  let(:intencion_de_venta1) { IntencionDeVenta.new(auto1, usuario1, "en revision") }
  let(:intencion_de_venta2) { IntencionDeVenta.new(auto2, usuario1, "en revision") }
  let(:intencion_de_venta3) { IntencionDeVenta.new(auto3, usuario2, "en revision") }


  before do
    repo_intenciones_de_venta.delete_all
    repo_autos.delete_all
    repo_usuario.delete_all
  end

  it 'Al crear una intencion de venta debería tener cantidad 1' do
    repo_autos.save(auto)
    repo_usuario.save(usuario)
    repo_intenciones_de_venta.save(intencion_de_venta)
    expect(repo_intenciones_de_venta.all.count).to eq(1)
  end

  it 'Debería asignar un id' do
    repo_autos.save(auto)
    repo_usuario.save(usuario)
    nueva_intencion_de_venta = repo_intenciones_de_venta.save(intencion_de_venta)
    expect(nueva_intencion_de_venta.id).to be_present
  end

  context 'Cuando una intencion de venta existe' do
    before :each do
      repo_autos.save(auto)
      repo_usuario.save(usuario)
      @nueva_intencion_de_venta = repo_intenciones_de_venta.save(intencion_de_venta)
      @id_intencion_de_venta = @nueva_intencion_de_venta.id
    end

    it 'No debería tener intenciones de venta al eliminar todas' do
      repo_intenciones_de_venta.delete_all
      expect(repo_intenciones_de_venta.all.count).to eq(0)
    end

    it 'Deber encontrar por el id' do
      intencion_de_venta = repo_intenciones_de_venta.find(@id_intencion_de_venta)
      expect(intencion_de_venta.id).to eq(@nueva_intencion_de_venta.id)
    end

    it 'Deber encontrar por el id y poder mapear el estado' do
      intencion_de_venta = repo_intenciones_de_venta.find(@id_intencion_de_venta)
      expect(intencion_de_venta.estado).to eq("en revision")
    end

    it 'Deber encontrar por el id y poder mapear el auto' do
      intencion_de_venta = repo_intenciones_de_venta.find(@id_intencion_de_venta)
      expect(intencion_de_venta.auto.id).to eq(auto.id)
    end

    it 'Deber encontrar por el id y poder mapear el usuario' do
      intencion_de_venta = repo_intenciones_de_venta.find(@id_intencion_de_venta)
      expect(intencion_de_venta.usuario.id).to eq(usuario.id)
    end

    it 'Deber encontrar por el id_usuario y poder mapear el auto' do
      intenciones_de_venta = repo_intenciones_de_venta.encontrar_por_id_usuario(3002)
      expect(intenciones_de_venta[0].auto.patente).to eq(auto.patente)
      expect(intenciones_de_venta.size).to eq(1)
    end
  end

  context 'Cuando existen 3 intenciones de venta' do
    before :each do
      repo_autos.save(auto1)
      repo_autos.save(auto2)
      repo_autos.save(auto3)
      repo_usuario.save(usuario1)
      repo_usuario.save(usuario2)
      @nueva_intencion_de_venta1 = repo_intenciones_de_venta.save(intencion_de_venta1)
      @nueva_intencion_de_venta2 = repo_intenciones_de_venta.save(intencion_de_venta2)
      @nueva_intencion_de_venta3 = repo_intenciones_de_venta.save(intencion_de_venta3)
    end

    it 'Entonces puedo encontrar por el id_usuario 1 y sus dos intenciones' do
      intenciones_de_venta = repo_intenciones_de_venta.encontrar_por_id_usuario(3004)
      expect(intenciones_de_venta[0].auto.patente).to eq(auto1.patente)
      expect(intenciones_de_venta[0].estado).to eq('en revision')
      expect(intenciones_de_venta[1].auto.patente).to eq(auto2.patente)
      expect(intenciones_de_venta[1].estado).to eq('en revision')
      expect(intenciones_de_venta.size).to eq(2)
    end
  end
end