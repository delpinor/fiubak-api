module Persistence
  module Repositories
    class RepositorioDeTestDrives < AbstractRepository
      self.table_name = :test_drives
      self.model_class = 'TestDrive'

      def chequear_por_publicacion_y_fecha(id_publicacion, fecha)
        row = dataset.first(id_publicacion: id_publicacion, fecha: fecha)
        return row.nil? == false
      end

      protected

      def load_object(a_hash)
        publicacion = RepositorioDePublicaciones.new.find(a_hash[:id_publicacion])
        TestDrive.new(publicacion, a_hash[:fecha], a_hash[:id])
      end

      def changeset(test_drive)
        {
          fecha: test_drive.fecha,
          id_publicacion: test_drive.publicacion.id
        }
      end
    end
  end
end
