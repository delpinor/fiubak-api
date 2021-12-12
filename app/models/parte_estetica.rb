class ParteEstetica
  attr_reader :estado

  def initialize(estado)
    @estado = estado
  end

  def obtener_penalizacion()
    @estado.penalizacion
  end
end
