# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module UsuarioHelper
      def repositorio_de_usuarios
        Persistence::Repositories::RepositorioDeUsuarios.new
      end

      def usuario_a_json(usuario)
        atributos_json(usuario).to_json
      end

      def crear_usuario(data)
        data = JSON.parse(data)
        Usuario.new(data['dni'].to_i, data['nombre'], data['email'], data['id'])
      end

      private

      def atributos_json(usuario)
        {id: usuario.id, dni: usuario.dni, nombre: usuario.nombre, email: usuario.email}
      end
    end

    helpers UsuarioHelper
  end
end
