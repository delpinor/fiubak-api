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

      def crear_intencion_de_venta(id_usuario, data)
        usuario = repositorio_de_usuarios.find(id_usuario.to_i)
        auto = crear_auto(data)
        intencion_venta = IntencionDeVenta.new(auto, usuario, 'en revisión')
        intencion_de_venta_con_id = repositorio_de_intencion_de_ventas.save(intencion_venta)
        intencion_de_venta_con_id.id.to_i
      end

      def recuperar_intencion_de_venta(id_intencion_de_venta)
        intencion_de_venta = repositorio_de_intencion_de_ventas.find(id_intencion_de_venta)
        { estado: intencion_de_venta.estado, id: intencion_de_venta.id }
      end

      def cambiar_a_vendido_por_fiubak(id_intencion)
        intencion_de_venta = repositorio_de_intencion_de_ventas.find(id_intencion)
        publicacion = intencion_de_venta.concretar_por_fiubak
        repositorio_de_intencion_de_ventas.save(intencion_de_venta)
        repositorio_de_publicaciones.save(publicacion)
        enviar_mail_informacion_de_compra(intencion_de_venta)
      end

      def enviar_mail_informacion_de_compra(intencion)
        EnviadorMails.new.notificar_venta_exitosa(intencion)
      end
    end

    helpers IntencionDeVentaHelper
  end
end
