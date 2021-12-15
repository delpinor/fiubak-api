WebTemplate::App.controllers :usuarios, :provides => [:json] do
  post :create, :map => '/usuarios/:id/intenciones_de_venta' do
    begin
      token = obtener_token_api(request)
      ValidadorDeToken.new.validar_para_bot(token)
      id_usuario = obtener_token_usuario(request)
      ValidadorDePropiedad.new.validar_usuario(id_usuario, params[:id])
      usuario = Repo.recuperar_usuario(params[:id])
      auto = parsear_auto(JSON.parse(request.body.read))
      Repo.guardar_auto(auto)
      intencion = IntencionDeVenta.crear_en_revision(auto, usuario)
      intencion_con_id = Repo.guardar_intencion(intencion)
      status 201
      {mensaje: "Intención de venta registrada bajo el nro. #{intencion_con_id.id}", id: intencion_con_id.id }.to_json
    rescue PatenteYaRegistradaError
      status 409
      {mensaje: 'La patente ya se encuentra registrada en FIUBAK'}.to_json
    rescue UsuarioInvalidoError
      status 404
      {mensaje: 'No hay dicha intencion de venta para su usuario'}.to_json
    rescue UsuarioNoEncontradoError
      status 404
      {mensaje: 'Para realizar esta operacion debe registrarse'}.to_json
    rescue NoAutorizadoError
      status 401
      {mensaje: 'No autorizado'}.to_json
    end
  end

  get :show, :map => '/intenciones_de_venta/:id' do
    begin
      token = obtener_token_api(request)
      ValidadorDeToken.new.validar_para_bot(token)
      id_usuario = obtener_token_usuario(request)
      ValidadorDePropiedad.new.validar_intencion_de_venta(id_usuario, params[:id])
      intencion = Repo.recuperar_intencion(params[:id])
      intencion_hash = intencion_a_hash(intencion)
      status 200
      {mensaje: 'intencion de venta recuperadas con exito', valor: intencion_hash}.to_json
    rescue UsuarioInvalidoError
      status 404
      {mensaje: 'No existe intención de venta asociada a su usuario'}.to_json
    rescue ObjectNotFound => e
      status 404
      {mensaje: 'Intención de venta inexistente.'}.to_json
    rescue NoAutorizadoError
      status 401
      {mensaje: 'No autorizado'}.to_json
    end
  end
end
