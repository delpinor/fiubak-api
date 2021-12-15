module Persistence
  module Repositories
    class RepositorioDeAutos < AbstractRepository
      self.table_name = :autos
      self.model_class = 'Auto'

      def check_by_patente(patente)
        patente_downcase = patente.downcase
        row_downcase = dataset.first(patente: patente_downcase)
        row = dataset.first(patente: patente)
        return (row.nil? == false or row_downcase.nil? == false)
      end

      protected


      def load_object(a_hash)
        Auto.new(a_hash[:marca], a_hash[:modelo], a_hash[:anio], a_hash[:patente], a_hash[:id])
      end

      def changeset(auto)
        {
          marca: auto.marca,
          modelo: auto.modelo,
          anio: auto.anio,
          patente: auto.patente
        }
      end
    end
  end
end
