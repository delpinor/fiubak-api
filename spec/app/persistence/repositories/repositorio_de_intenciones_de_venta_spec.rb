require 'integration_helper'

describe Persistence::Repositories::RepositorioDeIntencionesDeVenta do
  let(:repo_autos) { Persistence::Repositories::RepositorioDeAutos.new }
  let(:repo_usuario) { Persistence::Repositories::RepositorioDeUsuarios.new }
  let(:repo_intenciones_de_venta) { Persistence::Repositories::RepositorioDeIntencionesDeVenta.new }
  let(:auto) { Auto.new("fiat", 'uno', 1999, "MFS222", 1) }
  let(:usuario) { Usuario.new(12323423, 'Jhon', 'jhon@gmail.com', 34212) }
  let(:intencion_de_venta) { IntencionDeVenta.new(auto, usuario, "revision", 1) }

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
end