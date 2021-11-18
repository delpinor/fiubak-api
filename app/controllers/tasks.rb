WebTemplate::App.controllers :tasks, :provides => [:json] do
  get :show, :map => '/tasks', :with => :id do
    begin
      task_id = params[:id]
      task = task_repo.find(task_id)

      task_to_json task
    rescue ObjectNotFound => e
      status 404
      {error: e.message}.to_json
    end
  end

  post :create, :map => '/tasks' do
    begin
      user = user_repo.find(task_params[:user_id])
      task = Task.new(user, task_params[:title])
      new_task = task_repo.save(task)

      status 201
      task_to_json new_task
    rescue InvalidTask => e
      status 400
      {error: e.message}.to_json
    end
  end

  post :add_tag, :map => '/tasks/add_tag', :with => :id do
    begin
      task_id = params[:id]
      task = task_repo.find(task_id)

      tag_name = tag_params[:tag_name]
      tag = tag_repo.find_by_tag_name(tag_name) do
        tag = Tag.new(tag_name)
        tag_repo.save(tag)
      end

      task.add_tag(tag)
      task_repo.save(task)

      status 201
      task_to_json task
    rescue ObjectNotFound => e
      status 404
      {error: e.message}.to_json
    rescue InvalidTag => e
      status 400
      {error: e.message}.to_json
    end
  end
end
