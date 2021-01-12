WebTemplate::App.controllers :users, :provides => [:json] do
  get :index, :provides => [:js] do
    all_users = user_repo.all
    users_to_json all_users
  end

  get :show, :map => '/users', :with => :id, :provides => [:js] do
    handle_errors do
      user_id = params[:id]
      user = user_repo.find(user_id)
      user_to_json user
    end
  end

  put :update, :map => '/users', :with => :id, :provides => [:js] do
    handle_errors do
      user_id = params[:id]
      user = user_repo.update_user(user_id, user_params)

      status 200
      user_to_json user
    end
  end

  post :create, :map => '/users', :provides => [:js] do
    handle_errors do
      user = user_repo.create_user(user_params)

      status 201

      user_to_json user
    end
  end

  delete :destroy, :map => '/users', :with => :id, :provides => [:js] do
    handle_errors do
      user_id = params[:id]
      user_repo.delete_user(user_id)

      status 200
    end
  end
end
