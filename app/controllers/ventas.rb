WebTemplate::App.controllers :usuarios, :provides => [:json] do

  post :create, :map => '/usuarios/:id/intenciones_de_venta' do
    begin
      auto = crear_auto(request.body.read)
      id_venta = crear_intencion_de_venta(params[:id], auto)
      status 201
      {mensaje: 'intencion de venta registrada con exito', id: id_venta }.to_json
    end
  end

  get :show, :map => '/usuarios/:id/intenciones_de_venta' do
    begin
      puts "xd"
      puts params[:id]
      intenciones_de_venta_buscadas = recuperar_intenciones_de_venta(params[:id])
      status 201
      {mensaje: 'intenciones de venta recuperadas con exito', intenciones_de_venta: intenciones_de_venta_buscadas }.to_json
    end
  end

end
