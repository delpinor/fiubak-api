WebTemplate::App.controllers :usuarios, :provides => [:json] do

  post :create, :map => '/usuarios' do
    begin
      nuevo_usuario = crear_usuario(request.body.read)
      usuario_con_id = repositorio_de_usuarios.save(nuevo_usuario)
      status 201
      {mensaje: "Registro exitoso bajo id: #{usuario_con_id.id}"}.to_json
    rescue Exception => e
      status 400
      {mensaje: 'se produjo un error'}.to_json
    end
  end

end
