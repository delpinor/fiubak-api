WebTemplate::App.controllers :usuarios, :provides => [:json] do
  post :create, :map => '/usuarios' do
    begin

      token = obtener_token_api(request)
      ValidadorDeToken.new.validar_para_bot(token)
      data = JSON.parse(request.body.read)
      nuevo_usuario = CreadorUsuario.new.crear_usuario(data['dni'].to_i, data['nombre'], data['email'], data['id'])
      status 201
      {mensaje: "Registro exitoso bajo id: #{nuevo_usuario.id}"}.to_json
    rescue NoAutorizadoError
      status 401
      {mensaje: 'No autorizado'}.to_json
    rescue DniInvalidoError
      status 404
      {mensaje: 'El número de DNI ya está registrado.'}.to_json
    rescue MailYaRegistradoError
      status 404
      {mensaje: 'El email ya se encuentra registrado'}.to_json
    end
  end
end
