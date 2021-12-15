class Oferta
  attr_reader :usuario, :valor, :id_publicacion
  attr_accessor :id

  def initialize(usuario, valor, id = nil, id_publicacion = nil)
    @usuario = usuario
    @valor = valor
    @id_publicacion = id_publicacion
    @id = id
    validar_oferta
  end

  def validar_oferta
    raise PrecioNegativoError if @valor < 0
  end
end
