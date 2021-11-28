WebTemplate::App.controllers :usuarios, :provides => [:json] do

  post :create, :map => '/usuarios' do
    begin
      nuevo_usuario = crear_usuario(request.body.read)
      usuario_con_id = repositorio_de_usuarios.save(nuevo_usuario)
      status 201
      usuario_a_json(usuario_con_id)
    rescue StandardError => e
      status 400
      {error: e.message}.to_json
    end
  end

end
