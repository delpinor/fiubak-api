class DanioBajo < NiverlDanio
  def initialize
    @id = :bajo
  end

  def ==(other)
    return true if @id == other.id

    false
  end
  def penalizacion
    0.03
  end
end
