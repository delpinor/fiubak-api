class Version
  MAYOR = 0
  MINOR = 0
  PATCH = 35

  def self.current
    "#{MAYOR}.#{MINOR}.#{PATCH}"
  end
end
