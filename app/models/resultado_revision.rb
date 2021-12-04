class ResultadoRevision
  attr_reader :estado_partes, :precio_de_lista

  def initialize(partes, precio_de_lista)
    @estado_partes = partes
    @precio_de_lista = precio_de_lista
  end
end
