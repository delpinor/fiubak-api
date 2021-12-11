WebTemplate::App.controllers :usuarios, :provides => [:json] do
  post :create, :map => '/usuarios/:id/intenciones_de_venta' do
    ValidadorDeToken.new.validar_para_bot(request.env['HTTP_BOT_TOKEN'])
    id_venta = crear_intencion_de_venta(params[:id], request.body.read)
    status 201
    {mensaje: "Intención de venta registrada bajo el nro. #{id_venta}", id: id_venta }.to_json
  rescue ObjectNotFound
    status 404
    {mensaje: 'Para realizar esta operacion debe registrarse'}.to_json
  rescue NoAutorizadoError
    status 401
    {mensaje: 'No autorizado'}.to_json
  end

  get :show, :map => '/intenciones_de_venta/:id' do
    ValidadorDeToken.new.validar_para_bot(request.env['HTTP_BOT_TOKEN'])
    intencion_de_venta_buscada = recuperar_intencion_de_venta(params[:id])
    status 200
    {mensaje: 'intencion de venta recuperadas con exito', valor: intencion_de_venta_buscada }.to_json
  rescue ObjectNotFound => e
    status 404
    {mensaje: 'Intención de venta inexistente.'}.to_json
  rescue NoAutorizadoError
    status 401
    {mensaje: 'No autorizado'}.to_json
  end
end
