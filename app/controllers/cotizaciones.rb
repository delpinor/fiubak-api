WebTemplate::App.controllers :cotizaciones, :provides => [:json] do
  put :update, :map => '/aceptar_cotizacion' do
    begin
      token = obtener_token_api(request)
      ValidadorDeToken.new.validar_para_bot(token)
      id_usuario = obtener_token_usuario(request)
      data = JSON.parse(request.body.read)
      ValidadorDePropiedad.new.validar_intencion_de_venta(id_usuario, data['id_intencion'])
      intencion = Repo.recuperar_intencion(data['id_intencion'])
      publicacion = intencion.concretar_por_fiubak
      Repo.guardar_publicacion(publicacion)
      Repo.guardar_intencion(intencion)
      EnviadorMails.new.notificar_venta_exitosa(intencion)

      {mensaje: 'La intención de venta fue concretada con éxito'}.to_json
    rescue TransicionEstadoAutoInvalida
      status 409
      {mensaje: 'El auto no esta en condiciones de ser publicado'}.to_json
    rescue UsuarioInvalidoError
      status 404
      {mensaje: 'No existe intención de venta asociada a su usuario'}.to_json
    rescue NoAutorizadoError
      status 401
      {mensaje: 'No autorizado'}.to_json
    rescue ObjectNotFound => e
      status 404
      {mensaje: 'Cotizacion de auto inexistente.'}.to_json
    end
  end
end
