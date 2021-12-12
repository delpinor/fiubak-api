require_relative '../models/errors/usuario_invalido_error'

class ValidadorDePropiedad
  def initialize
    @repo = Persistence::Repositories::RepositorioDeIntencionesDeVenta.new
  end

  def validar_intencion_de_venta(id_usuario, id_intencion_de_venta)
    intencion_de_venta = @repo.find(id_intencion_de_venta)
    raise UsuarioInvalidoError if id_usuario != intencion_de_venta.usuario.id
  end

end
