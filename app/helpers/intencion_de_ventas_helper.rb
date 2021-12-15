# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module IntencionDeVentaHelper
      def intencion_a_hash(intencion)
        { estado: intencion.estado, id: intencion.id }
      end
    end

    helpers IntencionDeVentaHelper
  end
end
