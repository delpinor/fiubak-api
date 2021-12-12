WebTemplate::App.controllers :usuarios, :provides => [:json] do
  post :create, :map => '/usuarios' do
    begin

      token = (request.env['HTTP_BOT_TOKEN'] or request.env['BOT_TOKEN'])
      ValidadorDeToken.new.validar_para_bot(token)
      data = JSON.parse(request.body.read)
      nuevo_usuario = CreadorUsuario.new.crear_usuario(data['dni'].to_i, data['nombre'], data['email'], data['id'])
      status 201
      {mensaje: "Registro exitoso bajo id: #{nuevo_usuario.id}"}.to_json
    rescue NoAutorizadoError
      status 401
      {mensaje: 'No autorizado'}.to_json
    rescue MailYaRegistradoError
      status 404
      {mensaje: 'El email ya se encuentra registrado'}.to_json
    rescue Exception => e
      status 400
      {mensaje: "Se produjo un error"}.to_json
    end
  end
end
