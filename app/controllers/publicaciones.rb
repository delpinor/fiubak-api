WebTemplate::App.controllers :publicaciones, :provides => [:json] do

  @@clima = ''

  get :show, :map => '/publicaciones' do
    begin
      token = obtener_token_api(request)
      ValidadorDeToken.new.validar_para_bot(token)
      publicaciones = Repo.recuperar_publicaciones
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
      id_usuario = obtener_token_usuario(request)
      ValidadorDePropiedad.new.validar_publicacion(id_usuario, id_publicacion)
      publicacion = Repo.recuperar_publicacion(id_publicacion)
      status 200
      publicacion_a_json publicacion
    rescue UsuarioInvalidoError
      status 404
      {mensaje: 'No existe publicación asociada a su usuario'}.to_json
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
      data = JSON.parse(request.body.read)
      id_usuario = obtener_token_usuario(request)
      precio_publicacion = data['precio']
      id_intencion = data['id_intencion_de_venta']
      ValidadorDePropiedad.new.validar_intencion_de_venta(id_usuario, id_intencion)

      intencion = Repo.recuperar_intencion(id_intencion)
      publicacion = intencion.concretar_por_p2p(precio_publicacion)
      Repo.guardar_intencion(intencion)
      publicacion_con_id = Repo.guardar_publicacion(publicacion)
      pub_hash = publicacion_a_hash(publicacion_con_id, intencion.id)

      status 201
      {
        mensaje: "Registro exitoso de publicacion con id: #{publicacion_con_id.id}",
        valor: pub_hash
      }.to_json
    rescue PrecioNegativoError
      status 400
      {mensaje: 'El precio publicado es inválido'}.to_json
    rescue PrecioDePublicacionInvalido
      status 409
      {mensaje: 'El precio de publicación debe ser mayor al de cotización'}.to_json
    rescue TransicionEstadoAutoInvalida
      status 409
      {mensaje: 'El auto no esta en condiciones de ser publicado'}.to_json
    rescue UsuarioInvalidoError
      status 404
      {mensaje: 'No existe intención de venta asociada a su usuario'}.to_json
    rescue NoAutorizadoError
      status 401
      {mensaje: 'No autorizado'}.to_json
    end
  end

  post :create, :map => '/publicaciones/:id/ofertas' do
    begin
      token = obtener_token_api(request)
      ValidadorDeToken.new.validar_para_bot(token)
      data = oferta_params
      publicacion = Repo.recuperar_publicacion(params[:id])
      valor_oferta = data[:valor]
      ValidadorOfertaFiubak.new.validar_oferta_a_fiubak(valor_oferta, publicacion)
      usuario = Repo.recuperar_usuario(data[:id_usuario])
      oferta = Oferta.new(usuario, data[:valor], nil, params[:id])
      oferta_con_id = Repo.guardar_oferta(oferta)
      EnviadorMails.new.notificar_oferta(publicacion, oferta, usuario)
      status 201
      if publicacion.es_fiubak?
        Repo.eliminar_publicacion(publicacion)
        {mensaje: 'Compraste el auto'}.to_json
      else
        nueva_oferta_a_json oferta_con_id
      end
    rescue PrecioNegativoError
      status 400
      {mensaje: 'El valor de la oferta es inválido'}.to_json
    rescue NoAutorizadoError
      status 401
      {mensaje: 'No autorizado'}.to_json
    rescue MontoDistintoError
      status 404
      {mensaje: 'El monto debe ser igual al de la publicacion'}.to_json
    rescue UsuarioNoEncontradoError => e
      status 400
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
      oferta = Repo.recuperar_oferta(params[:id_oferta].to_i)
      Repo.eliminar_oferta(oferta)
      publicacion = Repo.recuperar_publicacion(oferta.id_publicacion)
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
      oferta = Repo.recuperar_oferta(params[:id_oferta].to_i)
      Repo.eliminar_oferta(oferta)
      publicacion = Repo.recuperar_publicacion(oferta.id_publicacion)
      intencion = Repo.recuperar_intencion_por_auto(publicacion.auto.id)
      intencion.a_vendido
      Repo.guardar_intencion(intencion)
      Repo.eliminar_publicacion(publicacion)
      EnviadorMails.new.notificar_aceptacion(oferta.id, publicacion.auto, oferta.valor, oferta.usuario)
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
