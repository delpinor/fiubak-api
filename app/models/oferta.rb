class Oferta
  attr_reader :usuario, :valor
  attr_accessor :id

  def initialize(usuario, valor, id = nil)
    @usuario = usuario
    @valor = valor
    validar_oferta
  end

  def validar_oferta
    nil
  end
end
