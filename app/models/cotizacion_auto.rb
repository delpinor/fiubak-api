class CotizacionAuto
  def initialize(auto)
    @partes = []
    @auto = auto
  end

  def agregar_parte(parte)
    @partes << parte
  end

  def valor_cotizado
    calcular_precio
  end

  private

  def calcular_precio
    RepositorioListaPrecios.new.precio_de_lista(@auto)
  end
end
