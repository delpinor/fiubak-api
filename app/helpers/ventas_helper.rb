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

      def recuperar_intenciones_de_venta(id_usuario)
        return repositorio_de_intencion_de_ventas.encontrar_por_id_usuario(id_usuario).map {
           |intencion_de_venta| ResultadoConsultaIntencionDeVenta.new(
                                          ResultadoConsultaAuto.new(intencion_de_venta.auto),
                                          intencion_de_venta.estado, 
                                          intencion_de_venta.id
            ) 
          }
      end

    end

    helpers IntencionDeVentaHelper
  end
end
