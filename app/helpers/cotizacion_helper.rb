# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module CotizacionHelper

      def procesar_cotizacion(data)
        repo = Persistence::Repositories::RepositorioDeIntencionesDeVenta.new
        intencion_de_venta = repo.find(data['id_intencion'].to_i)
        cotizacion = calcular_cotizacion(intencion_de_venta.auto)
        intencion_de_venta.revisado_y_cotizado
        enviar_cotizacion_por_email(cotizacion, intencion_de_venta)
        repo.save(intencion_de_venta)
      end

      private 

      def calcular_cotizacion(auto)
        cotizacion = CotizacionAuto.new(auto)
        cotizacion.agregar_parte(ParteEstetica.new(SinDanio.new))
        cotizacion.agregar_parte(ParteMotor.new(SinDanio.new))
        cotizacion.agregar_parte(ParteNeumaticos.new(SinDanio.new))
        cotizacion
      end

      def enviar_cotizacion_por_email(cotizacion, intencion)
        return
      end

    end
    helpers CotizacionHelper
  end
end
