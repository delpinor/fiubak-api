require_relative '../models/errors/usuario_invalido_error'

class ValidadorDePropiedad
  def initialize
    @repo_intencion_venta = Persistence::Repositories::RepositorioDeIntencionesDeVenta.new
    @repo_publicaciones = Persistence::Repositories::RepositorioDePublicaciones.new
  end

  def validar_intencion_de_venta(id_usuario, id_intencion_de_venta)
    intencion_de_venta = @repo_intencion_venta.find(id_intencion_de_venta)
    raise UsuarioInvalidoError if id_usuario != intencion_de_venta.usuario.id
  end

  def validar_publicacion(id_usuario, id_publicacion)
    id_publicacion = @repo_publicaciones.find(id_publicacion)
    raise UsuarioInvalidoError if id_usuario != id_publicacion.usuario.id
  end

end
