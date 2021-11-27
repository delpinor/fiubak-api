WebTemplate::App.controllers :usuarios, :provides => [:json] do

  post :create, :map => '/usuarios' do
    begin
      status 201
      {:test => 'OK'}.to_json
    rescue StandardError => e
      status 400
      {error: e.message}.to_json
    end
  end

end
