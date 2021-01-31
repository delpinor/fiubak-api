When('I assign a task with title {string} to the last user created') do |task_title|
  @request = {task: {title: task_title, user_id: @user_id}}.to_json
  @response = Faraday.post(create_task_url, @request, header)
  expect(@response.status).to eq(201)

  task = JSON.parse(@response.body)
  @task_id = task['id']
end

When('I get the last task created') do
  @request ||= {}
  @response = Faraday.get(find_task_url(@task_id))
end

Then('I should get task {string}') do |task_title|
  expect(@response.status).to eq(200)
  expected_task = JSON.parse(@response.body)

  expected_title = expected_task['title']
  expect(expected_title).to eq(task_title)

  expected_id = expected_task['id']
  expect(expected_id).to eq(@task_id)

  expected_user_id = expected_task['user_id']
  expect(expected_user_id).to eq(@user_id)
end
