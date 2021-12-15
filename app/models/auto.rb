class Auto
  attr_reader :marca, :modelo, :anio, :patente
  attr_accessor :id

  def initialize(marca, modelo, anio, patente, id = nil)
    @marca = marca
    @modelo = modelo
    @anio = anio
    @patente = patente
    @id = id
    validar_auto
  end

  def validar_auto
    raise AutoInvalidoError if (@marca and @modelo and @anio).nil? == true
  end

  def ==(other)
    return true if (@marca == other.marca) && (@modelo == other.modelo) && (@anio == other.anio)

    false
  end
end
