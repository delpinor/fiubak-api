WebTemplate::App.controllers :publicaciones, :provides => [:json] do
  get :show, :map => '/publicaciones' do
    publicaciones = repositorio_de_publicaciones.all
    status 200
    publicaciones_a_json publicaciones
  end

  get :show, :map => '/publicaciones/:id' do
    begin
      id_publicacion = params[:id].to_i
      publicacion = repositorio_de_publicaciones.find(id_publicacion)
      status 200
      publicacion_a_json publicacion
    rescue ObjectNotFound => e
      status 404
      {mensaje: 'La publicacion no existe'}.to_json
    end
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
    begin
      data = oferta_params

      usuario = repositorio_de_usuarios.find(data[:id_usuario])
      publicacion = repositorio_de_publicaciones.find(params[:id])
      oferta = Oferta.new(usuario, data[:valor], nil, params[:id])
      #TODO Validar que el usuario no oferto mas de una vez a la misma publicacion
      nueva_oferta = repositorio_de_ofertas.save(oferta)
      EnviadorMails.new.notificar_oferta(publicacion, oferta, usuario)

      status 201
      nueva_oferta_a_json nueva_oferta
    rescue ObjectNotFound => e
      status 404
      {mensaje: 'Usted debe registrarse y buscar una publiación valida!'}.to_json
    end
  end

  post :create, :map => '/ofertas/:id_oferta/rechazar' do
    repo_ofertas = Persistence::Repositories::RepositorioDeOfertas.new
    oferta = repo_ofertas.find(params[:id_oferta].to_i)

    repo_ofertas.destroy(oferta)
    repo_publicaciones = Persistence::Repositories::RepositorioDePublicaciones.new
    publicacion = repo_publicaciones.find(oferta.id_publicacion)
    EnviadorMails.new.notificar_rechazo(oferta.id, publicacion.auto, oferta.valor, oferta.usuario)
    status 201
    {mensaje: 'oferta rechazada con exito'}.to_json
  end

  post :create, :map => '/ofertas/:id_oferta/aceptar' do
    status 201
    {mensaje: 'oferta aceptada con exito'}.to_json
  end
end
