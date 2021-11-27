class Usuario
  attr_reader :dni, :nombre, :email
  def initialize(dni, nombre, email)
    @dni = dni
    @nombre = nombre
    @email = email
  end
end
