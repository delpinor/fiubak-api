WebTemplate::App.controllers :usuarios, :provides => [:json] do

  post :create, :map => '/usuarios/:id/ventas' do
    begin
      status 201
      {mensaje: 'intencion de venta registrada con exito'}.to_json
    end
  end

end
