require_relative 'errors/tipo_invalido_error.rb'
require_relative 'errors/precio_negativo_error.rb'

class Publicacion
  attr_reader :auto, :usuario, :precio, :ofertas, :tipo
  attr_accessor :id

  CATEGORIAS = ["Fiubak", "p2p"]

  def initialize(usuario, auto, precio, tipo, id = nil)
    @usuario = usuario
    @auto = auto
    @precio = precio
    @id = id
    @tipo = tipo
    @ofertas = []
    validar_publicacion
  end

  def es_fiubak?
    @tipo == 'Fiubak'
  end

  def validar_publicacion
    raise TipoInvalidoError unless CATEGORIAS.include? tipo
    raise PrecioNegativoError if precio.negative?
  end

  def obtener_ofertas
    @ofertas
  end

  def agregar_oferta(oferta)
    @ofertas << oferta
  end
end
