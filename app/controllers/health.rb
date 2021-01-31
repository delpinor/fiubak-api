WebTemplate::App.controllers :health, :provides => [:json] do
  get :index do
    status 200
    logger.info 'status:ok'
    {
      :status => 'ok',
      :version => Version.current
    }.to_json
  end

  get :version do
    status 200
    { :version => Version.current}.to_json
  end
end
