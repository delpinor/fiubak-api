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

  def concretar(tipo)
    @estado = 'vendido'
    Publicacion.new(@usuario, @auto, @precio_cotizado, tipo)
  end

  def revisado_y_cotizado
    @estado = 'revisado y cotizado'
  end

  def validar_intencion_de_venta
    nil
  end
end
