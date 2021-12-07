module Persistence
  module Repositories
    class RepositorioDeOfertas < AbstractRepository
      self.table_name = :ofertas
      self.model_class = 'Oferta'

      def find_by_publicacion(id_publicacion)
        ofertas_dataset = DB[:ofertas]
        ofertas = ofertas_dataset.where(id_publicacion: id_publicacion)
        ofertas
      end

      protected

      def load_object(a_hash)
        usuario = RepositorioDeUsuarios.new.find(a_hash[:id_usuario])
        publicacion = RepositorioDePublicaciones.new.find(a_hash[:id_publicacion])
        Oferta.new(usuario, a_hash[:valor], a_hash[:estado], a_hash[:id], a_hash[:id_publicacion])
      end

      def changeset(oferta)
        {
          id_usuario: oferta.usuario.id,
          id_publicacion: oferta.id_publicacion,
          valor: oferta.valor,
          estado: oferta.estado
        }
      end
    end
  end
end
