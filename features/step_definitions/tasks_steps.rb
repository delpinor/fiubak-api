When('I assign a task with title {string} to the last user created') do |task_title|
  @request = {title: task_title, user_id: @user_id}.to_json
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

Given('a task with title {string} is already assigned to the last user created') do |title|
  step "I assign a task with title '#{title}' to the last user created"
end

When('I assign a tag with name {string} to the last task created') do |tag_name|
  @request = {tag_name: tag_name}.to_json
  @response = Faraday.post(add_tag_to_task_url(@task_id), @request, header)
  expect(@response.status).to eq(201)

  task = JSON.parse(@response.body)
  @task_id = task['id']
end

Then('the task should have a tag assigned {string}') do |tag_name|
  task = JSON.parse(@response.body)
  tags = task['tags']

  tag = tags.select { |t| t[:tag_name] == tag_name }
  expect(tag).not_to be_nil
end

Given('a tag already exists with name {string}') do |tag_name|
  @request = {tag_name: tag_name}.to_json
  @response = Faraday.post(create_tag_url, @request, header)
  expect(@response.status).to eq(201)

  tag = JSON.parse(@response.body)
  @tag_id = tag['id']
end
