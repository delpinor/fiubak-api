module WebTemplate
  class App
    module ControllerHelper
      def obtener_token_api(request)
        (request.env['HTTP_API_TOKEN'] or request.env['API_TOKEN'])
      end

      def obtener_token_usuario(request)
        (request.env['HTTP_USR_TOKEN'] or request.env['USR_TOKEN'])
      end

      def obtener_token_rev(request)
        (request.env['HTTP_REV_TOKEN'] or request.env['REV_TOKEN'])
      end
    end
    helpers ControllerHelper
  end
end
