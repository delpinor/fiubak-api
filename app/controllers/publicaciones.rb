WebTemplate::App.controllers :publicaciones, :provides => [:json] do

  get :show, :map => '/publicaciones' do
    begin
      publicaciones = repositorio_de_publicaciones.all
      status 200
      publicaciones_a_json publicaciones
    end
  end

end
