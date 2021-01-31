WebTemplate::App.controllers :tasks do
  get :show, :map => '/tasks', :with => :id do
    begin
      task_id = params[:id]
      task = task_repo.find(task_id)

      task_to_json task
    rescue TaskNotFound => e
      status 404
      {error: e.message}.to_json
    end
  end

  post :create, :map => '/tasks' do
    begin
      user = user_repo.find(task_params[:user_id])
      task = Task.new(user, task_params[:title])
      new_task = task_repo.create_task(task)

      status 201
      task_to_json new_task
    rescue InvalidTask => e
      status 400
      {error: e.message}.to_json
    end
  end
end
