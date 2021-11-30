module Persistence
    module Repositories
      class RepositorioDeIntencionesDeVenta < AbstractRepository
        self.table_name = :intenciones_de_venta
        self.model_class = 'IntencionDeVenta'

        def encontrar_por_id_usuario(id_usuario)
          dataset_intenciones_de_venta = DB[:intenciones_de_venta]
          intenciones_de_venta = dataset_intenciones_de_venta.where(id_usuario: id_usuario)
          intenciones_de_venta_buscadas = []
          intenciones_de_venta.each do | intencion_de_venta |
            intenciones_de_venta_buscadas << IntencionDeVenta.new(
                RepositorioDeAutos.new.find(intencion_de_venta[:id_auto]),
                nil, 
                intencion_de_venta[:estado], 
                intencion_de_venta[:id]
              )
          end
          intenciones_de_venta_buscadas
        end
  
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