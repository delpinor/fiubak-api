class IntencionDeVenta
  attr_reader :auto, :usuario, :estado, :precio_cotizado
  attr_accessor :id

  def initialize(auto, usuario, estado, id = nil)
    @auto = auto
    @usuario = usuario
    @estado = estado
    @id = id
    @precio_cotizado = 0
    validar_intencion_de_venta
  end

  def set_valor_cotizado(precio)
    @precio_cotizado = precio
  end

  def concretar_por_fiubak
    @estado = 'vendido'
    Publicacion.new(@usuario, @auto, @precio_cotizado, 'Fiubak')
  end

  def concretar_por_p2p(precio)
    @estado = 'vendido' # todo en vez de 'vendido' el estado podria ser 'concretada' ?
    # Ya que publicacion va a ser 'vendido'
    Publicacion.new(@usuario, @auto, precio, "p2p")
  end

  def revisado_y_cotizado
    @estado = 'revisado y cotizado'
  end

  def validar_intencion_de_venta
    # todo validar tipos de estado
    # todo validar precio que no sea negativo (y no sea decimal)
    nil
  end
end
