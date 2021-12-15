# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module AutoHelper
      def parsear_auto(data)
        Auto.new(data['marca'], data['modelo'], data['anio'].to_i, data['patente'])
      end
    end
    helpers AutoHelper
  end
end
