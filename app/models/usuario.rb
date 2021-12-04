require_relative '../models/errors/dni_invalido_error'

class Usuario
  attr_reader :dni, :nombre, :email
  attr_accessor :id

  def initialize(dni, nombre, email, id)
    @dni = dni
    @nombre = nombre
    @email = email
    @id = id
    validar_usuario
  end

  def validar_usuario
    raise DniInvalidoError if @dni.negative?
  end
end
