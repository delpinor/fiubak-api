class ParteMotor
  attr_reader :estado

  def initialize(estado)
    @estado = estado
  end

  def obtener_penalizacion()
    return 1 if (@estado == DanioAlto.new || @estado == DanioMedio.new)
    @estado.penalizacion
  end

end
