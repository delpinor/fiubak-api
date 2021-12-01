class Version
  MAYOR = 0
  MINOR = 1
  PATCH = 12

  def self.current
    "#{MAYOR}.#{MINOR}.#{PATCH}"
  end
end
