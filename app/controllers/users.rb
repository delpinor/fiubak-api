WebTemplate::App.controllers :users, :provides => [:json] do
  get :index do
    all_users = user_repo.all
    users_to_json all_users
  end

  get :show, :map => '/users', :with => :id do
    begin
      user_id = params[:id]
      user = user_repo.find(user_id)

      user_to_json user
    rescue ObjectNotFound => e
      status 404
      {error: e.message}.to_json
    end
  end

  put :update, :map => '/users', :with => :id do
    begin
      user = user_repo.find(params[:id])
      user.replace_name_with(user_params[:name])

      updated_user = user_repo.save(user)

      status 200
      user_to_json updated_user
    rescue ObjectNotFound => e
      status 404
      {error: e.message}.to_json
    rescue InvalidUser => e
      status 400
      {error: e.message}.to_json
    end
  end

  post :create, :map => '/users' do
    begin
      new_user = UserCreator.new(user_repo, self).create_user(user_params[:name]) # User.new(user_params[:name])
      status 201
      user_to_json new_user
    rescue InvalidUser => e
      status 400
      {error: e.message}.to_json
    end
  end

  delete :destroy, :map => '/users', :with => :id do
    begin
      user = user_repo.find(params[:id])
      user_repo.delete(user)

      status 200
    rescue ObjectNotFound => e
      status 404
      {error: e.message}.to_json
    end
  end
end
