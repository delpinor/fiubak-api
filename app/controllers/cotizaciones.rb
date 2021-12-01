WebTemplate::App.controllers :cotizaciones, :provides => [:json] do

  put :update, :map => '/aceptar_cotizacion' do
    begin
      data = JSON.parse(request.body.read)
      cambiar_a_vendido(data['id_intencion'])
      {mensaje: 'La intención de venta fue concretada con éxito'}.to_json
    rescue Exception => e
      status 400
      {mensaje: 'se produjo un error'}.to_json
    end
  end
end
