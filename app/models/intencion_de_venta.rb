class IntencionDeVenta
  attr_reader :auto, :usuario, :estado, :precio_cotizado
  attr_accessor :id
  COMISION_POR_VENTA = 1.5

  ESTADOS = {
    :vendido => "vendido",
    :revisado_y_cotizado => "revisado y cotizado",
    :publicado => "publicado",
    :rechazado => "rechazado"
  }.freeze

  TIPOS_VENTA = {
    :peer_to_peer => "p2p",
    :fiubak => "Fiubak"
  }

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
    a_vendido
    Publicacion.new(@usuario, @auto, @precio_cotizado*COMISION_POR_VENTA, TIPOS_VENTA[:fiubak])
  end

  def concretar_por_p2p(precio)
    a_publicado
    Publicacion.new(@usuario, @auto, precio, TIPOS_VENTA[:peer_to_peer])
  end

  def a_vendido
    @estado = ESTADOS[:vendido]
  end

  def a_publicado
    raise TransicionEstadoAutoInvalida if @estado == ESTADOS[:rechazado]
    @estado = ESTADOS[:publicado]
  end

  def revisado_y_cotizado
    @estado = ESTADOS[:revisado_y_cotizado]
  end

  def a_rechazado
    @estado = ESTADOS[:rechazado]
  end

  def validar_intencion_de_venta
    # todo validar tipos de estado
    # todo validar precio que no sea negativo (y no sea decimal)
    nil
  end
end
