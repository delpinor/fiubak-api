WebTemplate::App.controllers :usuarios, :provides => [:json] do
  post :create, :map => '/usuarios/:id/intenciones_de_venta' do
    auto = crear_auto(request.body.read)
    id_venta = crear_intencion_de_venta(params[:id], auto)
    status 201
    {mensaje: 'intencion de venta registrada con exito', id: id_venta }.to_json
  rescue ObjectNotFound
    status 404
    {mensaje: 'Para realizar esta operación debe registrarse'}.to_json
  end

  get :show, :map => '/intenciones_de_venta/:id' do
    intencion_de_venta_buscada = recuperar_intencion_de_venta(params[:id])
    status 200
    {mensaje: 'intencion de venta recuperadas con exito', valor: intencion_de_venta_buscada }.to_json
  end
end
rcr
