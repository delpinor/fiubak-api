class Publicacion
  attr_reader :auto, :usuario, :precio, :tipo
  attr_accessor :id

  def initialize(usuario, auto, precio, tipo, id = nil)
    @usuario = usuario
    @auto = auto
    @precio = precio
    @id = id
    @tipo = tipo
    validar_publicacion
  end

  def validar_publicacion
    # todo validar tipo de venta (solo 'Fiubak' y 'p2p')
    # todo validar tipos de estado
    # todo validar precio que no sea negativo (y no sea decimal)
  end
end
