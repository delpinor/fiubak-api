module Persistence
  module Repositories
    class RepositorioDeUsuarios < AbstractRepository
      self.table_name = :usuarios
      self.model_class = 'Usuario'

      def find(id)
        found_record = dataset.first(pk_column => id)
        raise UsuarioNoEncontradoError.new(self.class.model_class, id) if found_record.nil?

        load_object dataset.first(found_record)
      end

      protected

      def load_object(a_hash)
        Usuario.new(a_hash[:dni], a_hash[:nombre], a_hash[:email], a_hash[:id])
      end

      def changeset(user)
        {
          dni: user.dni,
          nombre: user.nombre,
          email: user.email,
          id: user.id
        }
      end
    end
  end
end
