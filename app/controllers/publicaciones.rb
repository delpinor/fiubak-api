WebTemplate::App.controllers :publicaciones, :provides => [:json] do

  @@clima = ''

  get :show, :map => '/publicaciones' do
    begin
      token = obtener_token_api(request)
      ValidadorDeToken.new.validar_para_bot(token)
      publicaciones = repositorio_de_publicaciones.all
      status 200
      publicaciones_a_json publicaciones
    rescue NoAutorizadoError
      status 401
      {mensaje: 'No autorizado'}.to_json
    end
  end

  get :show, :map => '/publicaciones/:id' do
    begin
      token = obtener_token_api(request)
      ValidadorDeToken.new.validar_para_bot(token)
      id_publicacion = params[:id].to_i
      publicacion = repositorio_de_publicaciones.find(id_publicacion)
      status 200
      publicacion_a_json publicacion
    rescue NoAutorizadoError
      status 401
      {mensaje: 'No autorizado'}.to_json
    rescue ObjectNotFound => e
      status 404
      {mensaje: 'La publicacion no existe'}.to_json
    end
  end

  post :create, :map => '/publicaciones' do
    begin
      token = obtener_token_api(request)
      ValidadorDeToken.new.validar_para_bot(token)
      publicacion = publicar_p2p(request.body.read)
      status 201
      {
        mensaje: "Registro exitoso de publicacion con id: #{publicacion[:id_publicacion]}",
        valor: publicacion
      }.to_json
    rescue NoAutorizadoError
      status 401
      {mensaje: 'No autorizado'}.to_json
    rescue Exception => e
      status 400
      {mensaje: 'se produjo un error'}.to_json
    end
  end

  post :create, :map => '/publicaciones/:id/ofertas' do
    begin
      token = obtener_token_api(request)
      ValidadorDeToken.new.validar_para_bot(token)
      data = oferta_params
      publicacion = repositorio_de_publicaciones.find(params[:id])
      usuario = repositorio_de_usuarios.find(data[:id_usuario])
      oferta = Oferta.new(usuario, data[:valor], nil, params[:id])
      #TODO Validar que el usuario no oferto mas de una vez a la misma publicacion
      nueva_oferta = repositorio_de_ofertas.save(oferta)
      EnviadorMails.new.notificar_oferta(publicacion, oferta, usuario)

      status 201
      nueva_oferta_a_json nueva_oferta
    rescue NoAutorizadoError
      status 401
      {mensaje: 'No autorizado'}.to_json
    rescue UsuarioNoEncontradoError => e
      status 404
      {mensaje: 'Para realizar esta operacion debe registrarse'}.to_json
    rescue PublicacionNoEncontradaError => e
      status 404
      {mensaje: 'La publicacion no existe'}.to_json
    end
  end

  post :create, :map => '/ofertas/:id_oferta/rechazar' do
    begin
      token = obtener_token_api(request)
      ValidadorDeToken.new.validar_para_bot(token)
      id_usuario = obtener_token_usuario(request)
      ValidadorDePropiedad.new.validar_oferta(id_usuario, params[:id_oferta])
      repo_ofertas = Persistence::Repositories::RepositorioDeOfertas.new
      oferta = repo_ofertas.find(params[:id_oferta].to_i)
      repo_ofertas.destroy(oferta)
      repo_publicaciones = Persistence::Repositories::RepositorioDePublicaciones.new
      publicacion = repo_publicaciones.find(oferta.id_publicacion)
      EnviadorMails.new.notificar_rechazo(oferta.id, publicacion.auto, oferta.valor, oferta.usuario)
      status 201
      {mensaje: 'oferta rechazada con exito'}.to_json
    rescue UsuarioInvalidoError
      status 404
      {mensaje: 'No existe oferta asociada a una publicación vigente para su usuario'}.to_json
    rescue NoAutorizadoError
      status 401
      {mensaje: 'No autorizado'}.to_json
    end
  end

  post :create, :map => '/ofertas/:id_oferta/aceptar' do
    begin
      token = obtener_token_api(request)
      ValidadorDeToken.new.validar_para_bot(token)
      id_usuario = obtener_token_usuario(request)
      ValidadorDePropiedad.new.validar_oferta(id_usuario, params[:id_oferta])
      repo_ofertas = Persistence::Repositories::RepositorioDeOfertas.new
      oferta = repo_ofertas.find(params[:id_oferta].to_i)
      repo_ofertas.destroy(oferta)
      repo_publicaciones = Persistence::Repositories::RepositorioDePublicaciones.new
      publicacion = repo_publicaciones.find(oferta.id_publicacion)
      intencion_de_venta = repositorio_de_intencion_de_ventas.find_by_id_auto(publicacion.auto.id)
      intencion_de_venta.a_vendido()
      repositorio_de_intencion_de_ventas.save(intencion_de_venta)
      EnviadorMails.new.notificar_aceptacion(oferta.id, publicacion.auto, oferta.valor, oferta.usuario)
      repo_publicaciones.destroy(publicacion)
      status 201
      {mensaje: 'oferta aceptada con exito'}.to_json
    rescue UsuarioInvalidoError
      status 404
      {mensaje: 'No existe oferta asociada a una publicación vigente para su usuario'}.to_json
    rescue NoAutorizadoError
      status 401
      {mensaje: 'No autorizado'}.to_json
    rescue ObjectNotFound => e
      status 404
      {mensaje: 'oferta no encontrada'}.to_json
    end
  end
end
