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

  def validar_intencion_de_venta
    return
  end

end
