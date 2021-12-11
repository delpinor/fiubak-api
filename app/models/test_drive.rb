class TestDrive
  attr_reader :publicacion, :fecha

  def initialize(publicacion, fecha, proveedor_de_clima)
    @publicacion = publicacion
    @fecha = fecha
    @precio = calcular_precio(publicacion.precio, proveedor_de_clima)
  end

  def obtener_costo()
    return @precio
  end

  protected
  def calcular_precio(precio, proveedor_de_clima)
    clima = proveedor_de_clima.obtener_clima
    
    return precio * 0.008 if clima == "lluvioso" else precio * 0.01
  end

end