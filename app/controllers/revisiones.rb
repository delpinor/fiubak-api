WebTemplate::App.controllers :revisiones, :provides => [:json] do
  post :create, :map => '/revisiones' do
    begin
      token = obtener_token_rev(request)
      ValidadorDeToken.new.validar_para_revision(token)
      data = JSON.parse(request.body.read)
      procesar_revision(data)
      status 201
      {mensaje: 'Revisión exitosa'}.to_json
    rescue CotizacionFallida
      intencion = repositorio_de_intencion_de_ventas.find(data['id_intencion'].to_i)
      intencion.a_rechazado
      repositorio_de_intencion_de_ventas.save(intencion)
      status 200
      {mensaje: 'El auto no se encontraba en buen estado y no logró pasar la revisión'}.to_json
    rescue NoAutorizadoError
      status 401
      {mensaje: 'No autorizado'}.to_json
    rescue Exception => e
      status 400
      {mensaje: e.message}.to_json
    end
  end
end
