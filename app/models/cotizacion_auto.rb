class CotizacionAuto
  def initialize(auto, precio_lista)
    @partes = []
    @auto = auto
    @valor_lista = precio_lista
  end

  def agregar_parte(parte)
    @partes << parte
  end

  def valor_cotizado
    200
  end

  private

  def calcular_precio
    RepositorioListaPrecios.new.precio_de_lista(@auto)
  end
end
