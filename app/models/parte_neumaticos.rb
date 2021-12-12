class ParteNeumaticos
  attr_reader :estado

  def initialize(estado)
    @estado = estado
  end

  def obtener_penalizacion
    @estado.penalizacion
  end
end
