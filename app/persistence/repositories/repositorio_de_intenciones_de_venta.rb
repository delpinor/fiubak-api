module Persistence
  module Repositories
    class RepositorioDeIntencionesDeVenta < AbstractRepository
      self.table_name = :intenciones_de_venta
      self.model_class = 'IntencionDeVenta'

      def find_by_id_auto(id_auto)
        intencion = dataset.first(id_auto: id_auto)
        load_object(intencion)
      end

      protected

      def load_object(a_hash)
        usuario = RepositorioDeUsuarios.new.find(a_hash[:id_usuario])
        auto = RepositorioDeAutos.new.find(a_hash[:id_auto])
        intencion = IntencionDeVenta.new(auto, usuario, a_hash[:estado], a_hash[:id])
        intencion.set_valor_cotizado(a_hash[:precio_cotizado])
        intencion
      end

      def changeset(intencionDeVenta)
        {
          id_auto: intencionDeVenta.auto.id,
          id_usuario: intencionDeVenta.usuario.id,
          estado: intencionDeVenta.estado,
          precio_cotizado: intencionDeVenta.precio_cotizado
        }
      end
    end
  end
end
