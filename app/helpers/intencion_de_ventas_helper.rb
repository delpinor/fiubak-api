# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module IntencionDeVentaHelper
      def repositorio_de_usuarios
        Persistence::Repositories::RepositorioDeUsuarios.new
      end

      def repositorio_de_intencion_de_ventas
        Persistence::Repositories::RepositorioDeIntencionesDeVenta.new
      end

      def repositorio_de_publicaciones
        Persistence::Repositories::RepositorioDePublicaciones.new
      end


      def recuperar_intencion_de_venta(id_intencion_de_venta)
        intencion_de_venta = repositorio_de_intencion_de_ventas.find(id_intencion_de_venta)
        { estado: intencion_de_venta.estado, id: intencion_de_venta.id }
      end
    end

    helpers IntencionDeVentaHelper
  end
end
