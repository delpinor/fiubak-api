require 'spec_helper'

describe 'Validador de oferta a Fiubak' do

  let(:validador){ValidadorOfertaFiubak.new}


  let(:usuario){Usuario.new(99999, 'test', 'test@gmail.com', 9999)}
  let(:usuario_fiubak_con_id){CreadorUsuario.new.crear_usuario_fiubak}
  let(:usuario_comprador){Usuario.new(88888, 'test2', 'test2@gmail.com', 777)}
  let(:auto){Auto.new('fiat', 'palio', 1988, 'dfdsf23')}

  before(:each) do
    Persistence::Repositories::RepositorioDePublicaciones.new.delete_all
    Persistence::Repositories::RepositorioDeUsuarios.new.delete_all
    Persistence::Repositories::RepositorioDeAutos.new.delete_all
    Persistence::Repositories::RepositorioDeOfertas.new.delete_all
    #Guarda
    Persistence::Repositories::RepositorioDeUsuarios.new.save(usuario)
    Persistence::Repositories::RepositorioDeAutos.new.save(auto)
    @usuario_comprador_con_id = Persistence::Repositories::RepositorioDeUsuarios.new.save(usuario_comprador)
    @publicacion = Publicacion.new(usuario_fiubak_con_id, auto, 75000, "Fiubak")
    @publicacion = Persistence::Repositories::RepositorioDePublicaciones.new.save(@publicacion)
    @oferta = Oferta.new(usuario_comprador, 45000, 50, @publicacion.id)
    Persistence::Repositories::RepositorioDeOfertas.new.save(@oferta)
  end

  it 'Cuando oferto por una publicacion de Fiubak, con el monto equivocado, obtengo un error' do
    expect{validador.validar_oferta_a_fiubak(150 ,@publicacion)}.to raise_error(MontoDistintoError)
  end

end
