require_relative '../models/errors/monto_distinto_error'

class ValidadorOfertaFiubak
  PUBLICACION_DE_FIUBAK = 'Fiubak'.freeze
  def initialize
    @repo_intencion_venta = Persistence::Repositories::RepositorioDeIntencionesDeVenta.new
    @repo_publicaciones = Persistence::Repositories::RepositorioDePublicaciones.new
    @repo_ofertas = Persistence::Repositories::RepositorioDeOfertas.new
  end

  def validar_oferta_a_fiubak(valor_oferta, publicacion)
    raise MontoDistintoError if valor_oferta != publicacion.precio and publicacion.tipo == PUBLICACION_DE_FIUBAK
  end
end
