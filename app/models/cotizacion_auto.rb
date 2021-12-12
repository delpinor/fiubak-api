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
    fallas_graves = 0
    @partes.each do |parte|
      penalizacion = parte.obtener_penalizacion()
      fallas_graves += 1 if parte.estado == DanioAlto.new
      total_pct_descuento += penalizacion
    end
    return 0 if (total_pct_descuento >= 1 || fallas_graves >=2)
    @precio_lista * (1 - total_pct_descuento)
  end

end
