require_relative 'errors/tipo_invalido_error.rb'
require_relative 'errors/precio_negativo_error.rb'

class Publicacion
  attr_reader :auto, :usuario, :precio, :tipo
  attr_accessor :id

  CATEGORIAS = ["Fiubak", "p2p"]

  def initialize(usuario, auto, precio, tipo, id = nil)
    @usuario = usuario
    @auto = auto
    @precio = precio
    @id = id
    raise TipoInvalidoError unless CATEGORIAS.include? tipo
    raise PrecioNegativoError if precio.negative?
    @tipo = tipo
    validar_publicacion
  end

  def validar_publicacion
    # todo validar tipo de venta (solo 'Fiubak' y 'p2p')
    # todo validar tipos de estado
    # todo validar precio que no sea negativo (y no sea decimal)
  end

  def obtener_ofertas
    []
  end
end
