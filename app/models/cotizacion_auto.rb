class CotizacionAuto
  COMISION_POR_VENTA = 1.5
  def initialize(auto, precio_lista)
    @partes = []
    @auto = auto
    @valor_lista = precio_lista
  end

  def agregar_parte(parte)
    @partes << parte
  end

  def valor_cotizado
    total_pct_descuento = 0
    @partes.each do |parte|
      total_pct_descuento += parte.estado.penalizacion_por_falla
    end
    @valor_lista *(COMISION_POR_VENTA - total_pct_descuento)
  end

  private

  def calcular_precio
    RepositorioListaPrecios.new.precio_de_lista(@auto)
  end
end
