# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module CotizacionHelper
      def parsear_cotizacion(data)
        cotizacion = CotizacionAuto.new(data['precio_lista'].to_f)
        cotizacion.agregar_parte(ParserPartesAuto.new.json_a_parte_auto(:motor, data))
        cotizacion.agregar_parte(ParserPartesAuto.new.json_a_parte_auto(:neumaticos, data))
        cotizacion.agregar_parte(ParserPartesAuto.new.json_a_parte_auto(:estetica, data))
        cotizacion
      end
    end
    helpers CotizacionHelper
  end
end
