class Oferta
  attr_reader :usuario, :valor, :id_publicacion
  attr_accessor :id

  def initialize(usuario, valor, id = nil, id_publicacion = nil)
    @usuario = usuario
    @valor = valor
    @id_publicacion = id_publicacion
    validar_oferta
  end

  def validar_oferta
    nil
  end
end
