module Persistence
  module Repositories
    class RepositorioDePublicaciones < AbstractRepository
      self.table_name = :publicaciones
      self.model_class = 'Publicaciones'
      
      protected

      def load_object(a_hash)
          usuario = RepositorioDeUsuarios.new.find(a_hash[:id_usuario])
          auto = RepositorioDeAutos.new.find(a_hash[:id_auto])
          Publicacion.new(usuario, auto, a_hash[:precio], a_hash[:tipo], a_hash[:id])
      end


      def changeset(publicacion)
        {
          id_auto: publicacion.auto.id,
          id_usuario: publicacion.usuario.id,
          precio: publicacion.precio,
          tipo: publicacion.tipo
        }
      end

    end
  end
end
