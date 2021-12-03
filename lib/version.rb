class Version
  MAYOR = 0
  MINOR = 2
  PATCH = 8

  def self.current
    "#{MAYOR}.#{MINOR}.#{PATCH}"
  end
end
