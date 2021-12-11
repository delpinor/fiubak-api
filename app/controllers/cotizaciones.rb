WebTemplate::App.controllers :cotizaciones, :provides => [:json] do
  put :update, :map => '/aceptar_cotizacion' do
    begin
      ValidadorDeToken.new.validar_para_bot(request.env['HTTP_BOT_TOKEN'])
      data = JSON.parse(request.body.read)
      cambiar_a_vendido(data['id_intencion'])
      {mensaje: 'La intención de venta fue concretada con éxito'}.to_json
    rescue NoAutorizadoError
      status 401
      {mensaje: 'No autorizado'}.to_json
    rescue ObjectNotFound => e
      status 404
      {mensaje: 'Cotizacion de auto inexistente.'}.to_json
    rescue Exception => e
      status 400
      {mensaje: 'se produjo un error'}.to_json
    end
  end
end
