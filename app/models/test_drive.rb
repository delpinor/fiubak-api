class TestDrive
  attr_reader :publicacion, :fecha

  def initialize(publicacion, fecha)
    @publicacion = publicacion
    @fecha = fecha
  end

  def obtener_costo()
    return 8
  end

end