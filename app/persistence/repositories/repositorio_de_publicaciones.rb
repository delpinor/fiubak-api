module Persistence
  module Repositories
    class RepositorioDePublicaciones < AbstractRepository
      self.table_name = :publicaciones
      self.model_class = 'Publicaciones'


      def save(publicacion)
        if find_dataset_by_id(publicacion.id).first
          update(publicacion)
        else
          !insert(publicacion)
        end
        save_ofertas(publicacion)
        publicacion
      end

      def find(id)
        found_record = dataset.first(pk_column => id)
        raise PublicacionNoEncontradaError.new(self.class.model_class, id) if found_record.nil?

        load_object dataset.first(found_record)
      end

      protected

      def load_object(a_hash)
        usuario = RepositorioDeUsuarios.new.find(a_hash[:id_usuario])
        auto = RepositorioDeAutos.new.find(a_hash[:id_auto])
        ofertas = RepositorioDeOfertas.new.find_by_publicacion(a_hash[:id])
        publicacion = Publicacion.new(usuario, auto, a_hash[:precio], a_hash[:tipo], a_hash[:id])
        ofertas.each do |oferta|
          publicacion.agregar_oferta(oferta)
        end
        publicacion
      end

      def save_ofertas(publicacion)
        ofertas_dataset = DB[:ofertas]
        ofertas_viejas = ofertas_dataset.where(id_publicacion: publicacion.id)
        ofertas_viejas.delete
        # now we can create the current relations
        repo_ofertas = RepositorioDeOfertas.new
        publicacion.ofertas.each do |oferta|
          repo_ofertas.save(oferta)
        end
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
