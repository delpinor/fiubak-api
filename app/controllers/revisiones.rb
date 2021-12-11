WebTemplate::App.controllers :revisiones, :provides => [:json] do
  post :create, :map => '/revisiones' do
    begin
      ValidadorDeToken.new.validar_para_revision(request.env['HTTP_REV_TOKEN'])
      data = JSON.parse(request.body.read)
      procesar_revision(data)
      status 201
      {mensaje: 'Revisión exitosa'}.to_json
    rescue NoAutorizadoError
      status 401
      {mensaje: 'No autorizado'}.to_json
    rescue Exception => e
      status 400
      {mensaje: 'se produjo un error'}.to_json
    end
  end
end
