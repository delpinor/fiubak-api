class DanioAlto < NiverlDanio
  def initialize
    @id = :alto
  end

  def ==(other)
    return true if @id == other.id

    false
  end
  def penalizacion
    0.15
  end
end
