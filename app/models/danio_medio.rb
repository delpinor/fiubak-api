class DanioMedio < NiverlDanio
  def initialize
    @id = :medio
  end

  def ==(other)
    return true if @id == other.id

    false
  end
  def penalizacion
    0.08
  end
end
