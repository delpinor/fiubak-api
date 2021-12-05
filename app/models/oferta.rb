class Oferta
  attr_reader :usuario_comprador, :publicacion, :valor
  attr_accessor :id

  def initialize(usuario_comprador, publicacion, valor, id = nil)
    @usuario_comprador = usuario_comprador
    @publicacion = publicacion
    @valor = valor
    validar_oferta
  end

  def validar_oferta
    nil
  end
end
