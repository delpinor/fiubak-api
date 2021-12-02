class RevisionAuto
  def initialize(auto)
    @partes= [ParteEstetica.new, ParteMotor.new, ParteNeumaticos.new]
    @auto = auto
  end

  def resultado
    precio = RepositorioListaPrecios.new.precio_de_lista(@auto)
    ResultadoRevision.new(@partes, precio)
  end
end
