require_relative '../models/errors/dni_invalido_error'

class Usuario
  attr_reader :dni, :nombre, :email
  def initialize(dni, nombre, email)
    @dni = dni
    @nombre = nombre
    @email = email
    validar_usuario
  end

  def validar_usuario
    raise DniInvalidoError if @dni < 0
  end

end
