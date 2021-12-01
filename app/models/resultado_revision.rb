class ResultadoRevision
  attr_reader :estado_partes
  def initialize
    @estado_partes = []
    @estado_partes << 23
    @estado_partes << 23
    @estado_partes << 23
  end
  def agregar_estado_parte(parte)
    @estado_partes << parte
  end
end
