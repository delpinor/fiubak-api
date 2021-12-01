module Persistence
    module Repositories
      class RepositorioDeIntencionesDeVenta < AbstractRepository
        self.table_name = :intenciones_de_venta
        self.model_class = 'IntencionDeVenta'
        
        protected
  
        def load_object(a_hash)
            usuario = RepositorioDeUsuarios.new.find(a_hash[:id_usuario])
            auto = RepositorioDeAutos.new.find(a_hash[:id_auto])
            IntencionDeVenta.new(auto, usuario, a_hash[:estado], a_hash[:id])
        end
  
  
        def changeset(intencionDeVenta)
          {
            id_auto: intencionDeVenta.auto.id,
            id_usuario: intencionDeVenta.usuario.id,
            estado: intencionDeVenta.estado
          }
        end
  
      end
    end
  end