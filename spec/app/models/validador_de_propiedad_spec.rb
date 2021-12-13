require 'spec_helper'

describe 'Validador de propiedad' do

  let(:validador){ValidadorDePropiedad.new}


  let(:usuario){Usuario.new(99999, 'test', 'test@gmail.com', 9999)}
  let(:usuario_comprador){Usuario.new(88888, 'test2', 'test2@gmail.com', 777)}
  let(:auto){Auto.new('fiat', 'palio', 1988, 'dfdsf23')}

  before(:each) do
    Persistence::Repositories::RepositorioDeIntencionesDeVenta.new.delete_all
    Persistence::Repositories::RepositorioDePublicaciones.new.delete_all
    Persistence::Repositories::RepositorioDeUsuarios.new.delete_all
    Persistence::Repositories::RepositorioDeAutos.new.delete_all
    Persistence::Repositories::RepositorioDeOfertas.new.delete_all
    #Guarda
    Persistence::Repositories::RepositorioDeUsuarios.new.save(usuario)
    Persistence::Repositories::RepositorioDeAutos.new.save(auto)
    intencion_venta = IntencionDeVenta.new(auto, usuario, 'en revisión')
    @intencion_con_id = Persistence::Repositories::RepositorioDeIntencionesDeVenta.new.save(intencion_venta)
    @usuario_comprador_con_id = Persistence::Repositories::RepositorioDeUsuarios.new.save(usuario_comprador)
    @publicacion = Publicacion.new(usuario, auto, 75000, "Fiubak")
    @publicacion = Persistence::Repositories::RepositorioDePublicaciones.new.save(@publicacion)
    @oferta = Oferta.new(usuario_comprador, 45000, 50, @publicacion.id)
    Persistence::Repositories::RepositorioDeOfertas.new.save(@oferta)
  end


  it 'Cuando un usuario consulta una intencion de venta que no le pertenece, levanta excepcion' do
    id_usuario = 20
    expect{validador.validar_intencion_de_venta(id_usuario, @intencion_con_id.id)}.to raise_error(UsuarioInvalidoError)
  end

  it 'Cuando un usuario consulta por una publicacion que no le pertenece, levanta excepcion' do
    id_usuario = 20
    expect{validador.validar_publicacion(id_usuario, @publicacion.id)}.to raise_error(UsuarioInvalidoError)
  end

  it 'Cuando un usuario consulta por una oferta que no le pertenece, levanta excepcion' do
    id_usuario = 20
    expect{validador.validar_oferta(id_usuario, @oferta.id)}.to raise_error(UsuarioInvalidoError)
  end

  it 'Cuando se recibe un id de usuario distinto al usuario que llega por token, levanta excepcion' do
    id_usuario = 20
    id_usuario_params = 100
    expect{validador.validar_usuario(id_usuario, id_usuario_params)}.to raise_error(UsuarioInvalidoError)
  end

end
