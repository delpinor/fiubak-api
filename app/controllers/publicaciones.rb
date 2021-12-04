WebTemplate::App.controllers :publicaciones, :provides => [:json] do
  get :show, :map => '/publicaciones' do
    publicaciones = repositorio_de_publicaciones.all
    status 200
    publicaciones_a_json publicaciones
  end

  post :create, :map => '/publicaciones' do
    begin
      publicacion = publicar_p2p(request.body.read)
      status 201
      {
        mensaje: "Registro exitoso de publicacion con id: #{publicacion[:id_publicacion]}",
        valor: publicacion
      }.to_json
    rescue Exception => e
      logger.error e.message
      status 400
      {mensaje: 'se produjo un error'}.to_json
    end
  end
end
