class Publicacion
  attr_reader :auto, :usuario, :precio
  attr_accessor :id
  def initialize(usuario, auto, precio, id=nil)
    @usuario = usuario
    @auto = auto
    @precio = precio
    @id = id
    validar_publicacion
  end

  def validar_publicacion
  end

end
