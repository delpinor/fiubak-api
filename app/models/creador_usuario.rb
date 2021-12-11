class CreadorUsuario
  def initialize
    @repo = Persistence::Repositories::RepositorioDeUsuarios.new
  end

  def crear_usuario(dni, nombre, email, id)
    usuario = Usuario.new(dni, nombre, email, id)
    validar_usuario(usuario)
    @repo.load_by_email(usuario.email)
    usuario_con_id = @repo.save(usuario)
    usuario_con_id
  end

  def validar_usuario(usuario)
    raise MailYaRegistradoError.new if @repo.check_by_email(usuario.email)
  end
end
