class SinDanio
  attr_reader :id
  def initialize
    @id = :sindanio
  end

  def ==(other)
    return true if @id == other.id

    false
  end
end
