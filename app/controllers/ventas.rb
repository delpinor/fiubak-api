WebTemplate::App.controllers :usuarios, :provides => [:json] do

  post :create, :map => '/usuarios/:id/intenciones_de_venta' do
    begin
      status 201
      {mensaje: 'intencion de venta registrada con exito', id: 1}.to_json
    end
  end

end
