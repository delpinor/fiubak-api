class RevisionAuto
  def initialize(auto)
    @partes= [ParteEstetica.new, ParteMotor.new, ParteNeumaticos.new]
    @auto = auto
  end

  def resultado
    ResultadoRevision.new(@partes)
  end
end
