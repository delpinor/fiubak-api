# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module UsuarioHelper

      def usuario_a_json(usuario)
        atributos_json(usuario).to_json
      end

      private

      def atributos_json(usuario)
        {id: usuario.id, dni: usuario.dni, nombre: usuario.nombre, email: usuario.email}
      end
    end

    helpers UsuarioHelper
  end
end
