# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App

    module IntencionDeVentaHelper

      def crear_intencion_de_venta(id_usuario, auto)
        return id_usuario.to_i
      end

    end

    helpers IntencionDeVentaHelper
  end
end
