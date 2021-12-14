require_relative '../models/errors/usuario_invalido_error'

class ValidadorDePropiedad
  USUARIO_SIN_REGISTRAR = ''.freeze
  def initialize
    @repo_intencion_venta = Persistence::Repositories::RepositorioDeIntencionesDeVenta.new
    @repo_publicaciones = Persistence::Repositories::RepositorioDePublicaciones.new
    @repo_ofertas = Persistence::Repositories::RepositorioDeOfertas.new
  end

  def validar_intencion_de_venta(id_usuario, id_intencion_de_venta)
    intencion_de_venta = @repo_intencion_venta.find(id_intencion_de_venta)
    raise UsuarioInvalidoError if id_usuario != intencion_de_venta.usuario.id.to_s
  end

  def validar_publicacion(id_usuario, id_publicacion)
    id_publicacion = @repo_publicaciones.find(id_publicacion)
    raise UsuarioInvalidoError if id_usuario != id_publicacion.usuario.id.to_s
  end

  def validar_oferta(id_usuario, id_oferta)
    oferta = @repo_ofertas.find(id_oferta)
    id_publicacion = @repo_publicaciones.find(oferta.id_publicacion)
    raise UsuarioInvalidoError if id_usuario != id_publicacion.usuario.id.to_s
  end

  def validar_usuario(id_usuario_header, id_usuario_param)
      raise UsuarioInvalidoError if id_usuario_param != id_usuario_header and id_usuario_header != USUARIO_SIN_REGISTRAR
  end

end
