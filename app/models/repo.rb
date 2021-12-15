class Repo

  def self.recuperar_oferta(id_oferta)
    ofertas.find(id_oferta)
  end

  def self.guardar_oferta(oferta)
    ofertas.save(oferta)
  end

  def self.eliminar_oferta(oferta)
    ofertas.destroy(oferta)
  end

  def self.recuperar_intencion(id_intencion)
    intenciones.find(id_intencion)
  end

  def self.recuperar_intencion_por_auto(id_auto)
    intenciones.find_by_id_auto(id_auto)
  end

  def self.guardar_intencion(intencion)
    intenciones.save(intencion)
  end

  def self.recuperar_usuario(id_usuario)
    usuarios.find(id_usuario)
  end

  def self.guardar_usuario(usuario)
    usuarios.save(usuario)
  end

  def self.recuperar_publicacion(id_publicacion)
    publicaciones.find(id_publicacion)
  end

  def self.recuperar_publicaciones
    publicaciones.all
  end

  def self.guardar_publicacion(publicacion)
    publicaciones.save(publicacion)
  end

  def self.eliminar_publicacion(publicacion)
    publicaciones.destroy(publicacion)
  end

  def self.guardar_test_drive(test_drive)
    test_drives.save(test_drive)
  end

  def self.guardar_auto(auto)
    autos.save(auto)
  end

  def self.intenciones
    Persistence::Repositories::RepositorioDeIntencionesDeVenta.new
  end

  def self.publicaciones
    Persistence::Repositories::RepositorioDePublicaciones.new
  end

  def self.usuarios
    Persistence::Repositories::RepositorioDeUsuarios.new
  end

  def self.ofertas
    Persistence::Repositories::RepositorioDeOfertas.new
  end

  def self.test_drives
    Persistence::Repositories::RepositorioDeTestDrives.new
  end

  def self.autos
    Persistence::Repositories::RepositorioDeAutos.new
  end
end
