class DanioBajo < DanioAuto
  def initialize
    @id = :bajo
  end

  def ==(other)
    return true if @id == other.id

    false
  end
  def penalizacion_por_falla
    0.03
  end
end
