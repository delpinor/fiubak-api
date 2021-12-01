WebTemplate::App.controllers :usuarios, :provides => [:json] do

  post :create, :map => '/usuarios/:id/intenciones_de_venta' do
    begin
      auto = crear_auto(request.body.read)
      id_venta = crear_intencion_de_venta(params[:id], auto)
      status 201
      {mensaje: 'intencion de venta registrada con exito', id: id_venta }.to_json
    end
  end

  get :show, :map => '/intenciones_de_venta/:id' do
    begin
      intencion_de_venta_buscada = recuperar_intencion_de_venta(params[:id])
      status 201
      {mensaje: 'intencion de venta recuperadas con exito', intencion_de_venta: intencion_de_venta_buscada }.to_json
    end
  end

end
