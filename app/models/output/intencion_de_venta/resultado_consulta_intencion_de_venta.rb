class ResultadoConsultaIntencionDeVenta
    attr_reader :auto, :estado
    attr_accessor :id
    def initialize(auto, estado, id=nil)
      @auto = auto
      @estado = estado
      @id = id
    end
  end