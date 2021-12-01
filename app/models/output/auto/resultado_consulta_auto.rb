class ResultadoConsultaAuto
    attr_reader :marca, :modelo, :anio, :patente
    attr_accessor :id
    def initialize(auto)
      @marca = auto.marca
      @modelo = auto.modelo
      @anio = auto.anio
      @patente = auto.patente
      @id = auto.id
    end
end