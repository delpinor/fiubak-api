# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module CotizacionHelper

      def procesar_cotizacion(data)
        repo = Persistence::Repositories::RepositorioDeIntencionesDeVenta.new
        intencion_de_venta = repo.find(data['id_intencion'].to_i)
        cotizacion = calcular_cotizacion(intencion_de_venta.auto, data)
        intencion_de_venta.revisado_y_cotizado
        enviar_cotizacion_por_email(cotizacion, intencion_de_venta)
        repo.save(intencion_de_venta)
      end

      private 

      def calcular_cotizacion(auto, data)
        cotizacion = CotizacionAuto.new(auto, data['precio_lista'].to_i)
        cotizacion.agregar_parte(ParserPartesAuto.new.json_a_parte_auto(:motor, data))
        cotizacion.agregar_parte(ParserPartesAuto.new.json_a_parte_auto(:neumaticos, data))
        cotizacion.agregar_parte(ParserPartesAuto.new.json_a_parte_auto(:estetica, data))
        cotizacion
      end

      def enviar_cotizacion_por_email(cotizacion, intencion)
        EnviadorMails.new.notificar_revision(cotizacion, intencion)
      end

    end
    helpers CotizacionHelper
  end
end
