WebTemplate::App.controllers :cotizaciones, :provides => [:json] do

  put :update, :map => '/aceptar_cotizacion' do
    begin
      {mensaje: 'La intención de venta fue concretada con éxito'}.to_json
    end
  end


end
