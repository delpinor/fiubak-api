# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module AutoHelper

      def crear_auto(data)
        data = JSON.parse(data)
        auto = Auto.new(data['marca'], data['anio'].to_i, data['patente'], data['id'])
        return auto.id
      end

    end

    helpers AutoHelper
  end
end
