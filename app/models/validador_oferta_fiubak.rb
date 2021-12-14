require_relative '../models/errors/monto_distinto_error'

class ValidadorOfertaFiubak
  PUBLICACION_DE_FIUBAK = 'Fiubak'.freeze
  def initialize
    @repo_intencion_venta = Persistence::Repositories::RepositorioDeIntencionesDeVenta.new
    @repo_publicaciones = Persistence::Repositories::RepositorioDePublicaciones.new
    @repo_ofertas = Persistence::Repositories::RepositorioDeOfertas.new
  end

  def validar_oferta_a_fiubak(id_oferta)
    oferta = @repo_ofertas.find(id_oferta)
    id_publicacion = @repo_publicaciones.find(oferta.id_publicacion)
    raise MontoDistintoError if oferta.valor != id_publicacion.precio and id_publicacion.tipo == PUBLICACION_DE_FIUBAK
  end
end
