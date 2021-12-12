class TestDrive
  attr_reader :publicacion, :fecha, :id_publicacion
  attr_accessor :id

  def initialize(publicacion, fecha, id=nil)
    @publicacion = publicacion
    @fecha = fecha
    @id = id
  end

  def obtener_costo(proveedor_de_clima)
    calcular_precio(publicacion.precio, proveedor_de_clima)
  end

  protected
  def calcular_precio(precio, proveedor_de_clima)
    clima = proveedor_de_clima.obtener_clima
    
    return precio * 0.008 if clima == "lluvioso" else precio * 0.01
  end

end