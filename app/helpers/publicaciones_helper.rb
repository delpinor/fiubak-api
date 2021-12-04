# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module PublicacionesHelper
      def repositorio_de_publicaciones
        Persistence::Repositories::RepositorioDePublicaciones.new
      end

      def obtener_publicaciones
        publicaciones = repositorio_de_publicaciones.all
        { estado: intencion_de_venta.estado, id: intencion_de_venta.id }
      end

      def publicaciones_a_json(publicaciones)
        publicaciones.map { |publicacion| atributos_publicacion(publicacion) }.to_json
      end

      def atributos_publicacion(publicacion)
        {id: publicacion.id, marca: publicacion.auto.marca, modelo: publicacion.auto.modelo, anio: publicacion.auto.anio, precio: publicacion.precio}
      end
    end

    helpers PublicacionesHelper
  end
end
