# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module AutoHelper
      def repositorio_de_autos
        Persistence::Repositories::RepositorioDeAutos.new
      end

      def crear_auto(data)
        data = JSON.parse(data)
        auto = Auto.new(data['marca'], data['modelo'], data['anio'].to_i, data['patente'])
        repositorio_de_autos.save(auto)
      end
    end

    helpers AutoHelper
  end
end
