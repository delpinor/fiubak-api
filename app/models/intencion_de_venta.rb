class IntencionDeVenta
  attr_reader :auto, :usuario, :estado
  attr_accessor :id
  def initialize(auto, usuario, estado, id=nil)
    @auto = auto
    @usuario = usuario
    @estado = estado
    @id = id
    validar_intencion_de_venta
  end

  def concretar
    @estado = 'vendido'
    Publicacion.new(@usuario, @auto, 75000)
  end

  def revisado_y_cotizado
    @estado = 'revisado y cotizado'
  end

  def validar_intencion_de_venta
    return
  end

end
