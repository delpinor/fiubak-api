WebTemplate::App.controllers :usuarios, :provides => [:json] do

  post :create, :map => '/usuarios/:id/intenciones_de_venta' do
    begin
      auto = crear_auto(request.body.read)
      id_venta = crear_intencion_de_venta(params[:id], auto)
      status 201
      {mensaje: 'intencion de venta registrada con exito', id: id_venta }.to_json
    end
  end

end
