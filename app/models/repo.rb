class Repo
  def self.recuperar_intencion(id_intencion)
    intenciones.find(id_intencion)
  end

  def self.guardar_intencion(intencion)
    intenciones.save(intencion)
  end

  def self.recuperar_publicacion(publicacion)
    publicaciones.find(publicacion)
  end

  def self.guardar_publicacion(publicacion)
    publicaciones.save(publicacion)
  end

  def self.intenciones
    Persistence::Repositories::RepositorioDeIntencionesDeVenta.new
  end

  def self.publicaciones
    Persistence::Repositories::RepositorioDePublicaciones.new
  end
end
