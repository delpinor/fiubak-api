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

  post :create, :map => '/publicaciones/:id/ofertas' do
    data = oferta_params

    usuario = repositorio_de_usuarios.find(data[:id_usuario])
    oferta = Oferta.new(usuario, data[:valor], nil, params[:id])
    nueva_oferta = repositorio_de_ofertas.save(oferta)

    status 201
    nueva_oferta_a_json nueva_oferta
  end

  post :create, :map => '/tasks' do
    begin
      user = user_repo.find(task_params[:user_id])
      task = Task.new(user, task_params[:title])
      new_task = task_repo.save(task)

      status 201
      task_to_json new_task
    rescue InvalidTask => e
      status 400
      {error: e.message}.to_json
    end
  end
end
