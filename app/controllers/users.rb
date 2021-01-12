WebTemplate::App.controllers :users, :provides => [:json] do
  get :index, :provides => [:js] do
    users_to_json user_repo.all
  end

  get :show, :map => '/users', :with => :id, :provides => [:js] do
    handle_errors do
      user = user_repo.find(params[:id])
      user_to_json user
    end
  end

  put :update, :map => '/users', :with => :id, :provides => [:js] do
    handle_errors do
      user = user_repo.find(params[:id])
      user_repo.update(user.id, user_params)

      status 200
    end
  end

  post :create, :map => '/users', :provides => [:js] do
    handle_errors do
      user = user_repo.create(User.new(user_params).attributes)

      status 201

      user_to_json user
    end
  end

  delete :destroy, :map => '/users', :with => :id, :provides => [:js] do
    handle_errors do
      user = user_repo.find(params[:id])
      user_repo.delete(user.id)

      status 200
    end
  end
end
