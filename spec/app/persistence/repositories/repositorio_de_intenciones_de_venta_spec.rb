require 'integration_helper'

describe Persistence::Repositories::RepositorioDeIntencionesDeVenta do
  let(:repo_autos) { Persistence::Repositories::RepositorioDeAutos.new }
  let(:repo_usuario) { Persistence::Repositories::RepositorioDeUsuarios.new }
  let(:repo_intenciones_de_venta) { Persistence::Repositories::RepositorioDeIntencionesDeVenta.new }
  let(:repo_publicaciones) { Persistence::Repositories::RepositorioDePublicaciones.new }
  let(:auto) { Auto.new("fiat", 'uno', 1999, "MFS222") }
  let(:usuario) { Usuario.new(12323423, 'Jhon', 'jhon@gmail.com', 3002) }
  let(:intencion_de_venta) { IntencionDeVenta.new(auto, usuario, "en revisión", 1) }

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

    it 'Al actualizar le valor cotizacion debe actualizarse en el repositorio' do
      intencion_de_venta.set_valor_cotizado(3343)
      repo_intenciones_de_venta.save(intencion_de_venta)
      intencion_de_recuperada = repo_intenciones_de_venta.find(@id_intencion_de_venta)
      expect(intencion_de_recuperada.precio_cotizado).to eq(intencion_de_venta.precio_cotizado)
    end


    it 'Deber encontrar por el id' do
      intencion_de_venta = repo_intenciones_de_venta.find(@id_intencion_de_venta)
      expect(intencion_de_venta.id).to eq(@nueva_intencion_de_venta.id)
    end

    it 'Deber encontrar por el id y poder mapear el estado' do
      intencion_de_venta = repo_intenciones_de_venta.find(@id_intencion_de_venta)
      expect(intencion_de_venta.estado).to eq("en revisión")
    end

    it 'Deber encontrar por el id y poder mapear el auto' do
      intencion_de_venta = repo_intenciones_de_venta.find(@id_intencion_de_venta)
      expect(intencion_de_venta.auto.id).to eq(auto.id)
    end

    it 'Deber encontrar por el id y poder mapear el usuario' do
      intencion_de_venta = repo_intenciones_de_venta.find(@id_intencion_de_venta)
      expect(intencion_de_venta.usuario.id).to eq(usuario.id)
    end
  end
end
