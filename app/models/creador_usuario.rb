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

  def crear_usuario_fiubak
    fiubak = Usuario.new(0, 'Fiubak', 'fiubak@gmail.com', 0)
    @repo.load_by_email(fiubak.email)
    fiubak_con_id = @repo.save(fiubak)
    fiubak_con_id
  end

  def validar_usuario(usuario)
    raise MailYaRegistradoError.new if @repo.check_by_email(usuario.email)
    raise DniInvalidoError.new if @repo.check_by_dni(usuario.dni)
  end
end
