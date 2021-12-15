class IntencionDeVenta
  attr_reader :auto, :usuario, :estado, :precio_cotizado
  attr_accessor :id
  COMISION_POR_VENTA = 1.5

  ESTADOS = {
    :vendido => 'vendido',
    :revisado_y_cotizado => 'revisado y cotizado',
    :publicado => 'publicado',
    :rechazado => 'rechazado',
    :en_revision => 'en revisión'
  }.freeze

  TIPOS_VENTA = {
    :peer_to_peer => 'p2p',
    :fiubak => 'Fiubak'
  }.freeze

  def initialize(auto, usuario, estado, id = nil)
    @auto = auto
    @usuario = usuario
    @estado = estado
    @id = id
    @precio_cotizado = 0
  end

  def self.crear_en_revision(auto, usuario)
    IntencionDeVenta.new(auto, usuario, 'en revisión')
  end
  
  def set_valor_cotizado(precio)
    raise PrecioNegativoError if precio < 0
    @precio_cotizado = precio
  end

  def concretar_por_fiubak
    raise TransicionEstadoAutoInvalida if [ESTADOS[:publicado]].include? @estado
    a_vendido
    usuario_fiubak = CreadorUsuario.new.crear_usuario_fiubak
    Publicacion.new(usuario_fiubak, @auto, @precio_cotizado*COMISION_POR_VENTA, TIPOS_VENTA[:fiubak])
  end

  def concretar_por_p2p(precio)
    raise PrecioDePublicacionInvalido if precio <= @precio_cotizado
    a_publicado
    Publicacion.new(@usuario, @auto, precio, TIPOS_VENTA[:peer_to_peer])
  end

  def a_vendido
    raise TransicionEstadoAutoInvalida unless [ESTADOS[:revisado_y_cotizado], ESTADOS[:publicado]].include? @estado
    @estado = ESTADOS[:vendido]
  end

  def a_publicado
    raise TransicionEstadoAutoInvalida if ![ESTADOS[:revisado_y_cotizado]].include? @estado
    @estado = ESTADOS[:publicado]
  end

  def revisado_y_cotizado
    raise TransicionEstadoAutoInvalida if @estado != ESTADOS[:en_revision]
    @estado = ESTADOS[:revisado_y_cotizado]
  end

  def a_rechazado
    raise TransicionEstadoAutoInvalida if @estado != ESTADOS[:en_revision]
    @estado = ESTADOS[:rechazado]
  end
end
