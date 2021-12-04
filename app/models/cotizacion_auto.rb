class CotizacionAuto
  def initialize(auto, precio_lista)
    @partes = []
    @auto = auto
    @precio_lista = precio_lista
  end

  def agregar_parte(parte)
    @partes << parte
  end

  def valor_cotizado
    total_pct_descuento = 0
    @partes.each do |parte|
      total_pct_descuento += parte.estado.penalizacion_por_falla
    end
    @precio_lista * (1 - total_pct_descuento)
  end
end
