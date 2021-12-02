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

      def crear_intencion_de_venta(id_usuario, auto)
        usuario = repositorio_de_usuarios.find(id_usuario.to_i)
        intencion_venta = IntencionDeVenta.new(auto, usuario, 'en revision')
        intencion_de_venta_con_id = repositorio_de_intencion_de_ventas.save(intencion_venta)
        return intencion_de_venta_con_id.id.to_i
      end

      def recuperar_intencion_de_venta(id_intencion_de_venta)
        intencion_de_venta = repositorio_de_intencion_de_ventas.find(id_intencion_de_venta)
        { estado: intencion_de_venta.estado, id: intencion_de_venta.id }

      end

      def cambiar_a_vendido(id_intencion)
        intencion_de_venta = repositorio_de_intencion_de_ventas.find(id_intencion)
        publicacion = intencion_de_venta.concretar
        repositorio_de_intencion_de_ventas.save(intencion_de_venta)
        repositorio_de_publicaciones.save(publicacion)
      end

    end

    helpers IntencionDeVentaHelper
  end
end
