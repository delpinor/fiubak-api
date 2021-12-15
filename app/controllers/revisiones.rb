WebTemplate::App.controllers :revisiones, :provides => [:json] do
  post :create, :map => '/revisiones' do
    begin
      token = obtener_token_rev(request)
      ValidadorDeToken.new.validar_para_revision(token)
      data = JSON.parse(request.body.read)
      intencion = Repo.recuperar_intencion(data['id_intencion'].to_i)
      cotizacion = parsear_cotizacion(data)
      intencion.set_valor_cotizado(cotizacion.valor_cotizado)
      intencion.revisado_y_cotizado
      Repo.guardar_intencion(intencion)
      EnviadorMails.new.notificar_revision(cotizacion, intencion)
      status 201
      {mensaje: 'Revisión exitosa'}.to_json
    rescue CotizacionFallida
      intencion = Repo.recuperar_intencion(data['id_intencion'].to_i)
      intencion.a_rechazado
      Repo.guardar_intencion(intencion)
      EnviadorMails.new.notificar_revision_desaprobada(intencion)
      status 200
      {mensaje: 'El auto no se encontraba en buen estado y no logró pasar la revisión'}.to_json
    rescue PrecioNegativoError
      status 400
      {mensaje: 'El precio de lista es inválido'}.to_json
    rescue NoAutorizadoError
      status 401
      {mensaje: 'No autorizado'}.to_json
    end
  end
end
