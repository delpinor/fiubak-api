require_relative '../models/errors/dni_invalido_error'

class Auto
  attr_reader :marca, :modelo, :anio, :patente
  attr_accessor :id
  def initialize(marca, modelo, anio, patente)
    @marca = marca
    @modelo = modelo
    @anio = anio
    @patente = patente
    validar_auto
  end

  def validar_auto
    return
  end

end
