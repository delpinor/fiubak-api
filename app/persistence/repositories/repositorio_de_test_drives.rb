module Persistence
  module Repositories
    class RepositorioDeTestDrives < AbstractRepository
      self.table_name = :test_drives
      self.model_class = 'TestDrive'

      def find_by_publicacion_y_fecha(id_publicacion, fecha)
        test_drive_dataset = DB[:test_drives]
        test_drive = test_drives_dataset.first(id_publicacion: id_publicacion, fecha: fecha)
        publicacion = RepositorioDePublicaciones.new.find(id_publicacion)
        TestDrive.new(publicacion, test_drive[:fecha], ProveedorDeClima.new, test_drive[:id])
      end

      protected

      def load_object(a_hash)
        publicacion = RepositorioDePublicaciones.new.find(a_hash[:id_publicacion])
        TestDrive.new(publicacion, a_hash[:fecha], ProveedorDeClima.new, a_hash[:id])
      end

      def changeset(test_drive)
        {
          fecha: test_drive.fecha,
          id_publicacion: test_drive.publicacion.id,
          id: test_drive.id
        }
      end
    end
  end
end
