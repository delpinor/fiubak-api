WebTemplate::App.controllers :revisiones, :provides => [:json] do

  post :create, :map => '/revisiones' do
    begin
      data = JSON.parse(request.body.read)
      procesar_cotizacion(data)
      status 201
      {mensaje: 'revisión exitosa'}.to_json
    rescue Exception => e
      status 400
      {mensaje: e.message}.to_json
    end
  end

end
