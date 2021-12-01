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

      def crear_intencion_de_venta(id_usuario, auto)
        usuario = repositorio_de_usuarios.find(id_usuario.to_i)
        intencion_venta = IntencionDeVenta.new(auto, usuario, 'en revision')
        intencion_de_venta_con_id = repositorio_de_intencion_de_ventas.save(intencion_venta)
        return intencion_de_venta_con_id.id.to_i
      end

      def recuperar_intencion_de_venta(id_intencion_de_venta)
      atributos_json(repositorio_de_intencion_de_ventas.find(id_intencion_de_venta))
      end

      private

      def atributos_json(intencion_de_venta)
        { auto: { patente: intencion_de_venta.auto.patente, marca: intencion_de_venta.auto.marca, modelo: intencion_de_venta.auto.modelo, anio: intencion_de_venta.auto.anio, id: intencion_de_venta.auto.id}, estado: intencion_de_venta.estado, id: intencion_de_venta.id }
      end

    end

    helpers IntencionDeVentaHelper
  end
end
