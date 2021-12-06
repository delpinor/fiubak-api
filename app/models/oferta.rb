class Oferta
  attr_reader :usuario, :valor, :id_publicacion, :estado
  attr_accessor :id

  def initialize(usuario, valor, estado, id = nil, id_publicacion = nil)
    @usuario = usuario
    @valor = valor
    @id_publicacion = id_publicacion
    @estado = estado
    @id = id
    validar_oferta
  end

  def rechazar_oferta
    @estado = "Rechazada"
  end

  def validar_oferta
    #Validar estados: creada, aceptada, rechazada
    nil
  end
end
