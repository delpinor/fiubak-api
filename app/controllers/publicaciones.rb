WebTemplate::App.controllers :publicaciones, :provides => [:json] do

  get :show, :map => '/publicaciones' do
    begin
      status 201
      [].to_json
    end
  end

end
