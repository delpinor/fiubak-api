WebTemplate::App.controllers :users do
  get :index do
    all_users = user_repo.all
    users_to_json all_users
  end

  get :show, :map => '/users', :with => :id do
    begin
      user_id = params[:id]
      user = user_repo.find(user_id)

      user_to_json user
    rescue UserNotFound => e
      status 404
      {error: e.message}.to_json
    end
  end

  put :update, :map => '/users', :with => :id do
    begin
      user_id = params[:id]
      user = user_repo.update_user(user_id, user_params)

      status 200
      user_to_json user
    rescue UserNotFound => e
      status 404
      {error: e.message}.to_json
    rescue InvalidUser => e
      status 400
      {error: e.message}.to_json
    end
  end

  post :create, :map => '/users' do
    begin
      user = user_repo.create_user(user_params)

      status 201
      user_to_json user
    rescue InvalidUser => e
      status 400
      {error: e.message}.to_json
    end
  end

  delete :destroy, :map => '/users', :with => :id do
    begin
      user_id = params[:id]
      user_repo.delete_user(user_id)

      status 200
    rescue UserNotFound => e
      status 404
      {error: e.message}.to_json
    end
  end
end
