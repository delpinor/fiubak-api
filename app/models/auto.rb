class Auto
  attr_reader :marca, :modelo, :anio, :patente
  attr_accessor :id
  def initialize(marca, modelo, anio, patente, id=nil)
    @marca = marca
    @modelo = modelo
    @anio = anio
    @patente = patente
    @id = id
    validar_auto
  end

  def validar_auto
    return
  end

end
