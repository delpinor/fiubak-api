Given('User {string} is already registered') do |user_name|
  @request = {name: user_name}.to_json
  @response = Faraday.post(create_user_url, @request, header)
  expect(@response.status).to eq(201)

  user = JSON.parse(@response.body)
  @user_id = user['id']
end

When('I get the last user created') do
  @request ||= {}
  @response = Faraday.get(find_user_url(@user_id))
end

Then('I should get user {string}') do |user_name|
  expect(@response.status).to eq(200)
  expected_user = JSON.parse(@response.body)
  expected_name = expected_user['name']
  expect(expected_name).to eq(user_name)
end

When('I get all the users') do
  @request ||= {}
  @response = Faraday.get(find_all_users_url)
end

Then('I should get user {string} and {string}') do |name_one, name_two|
  expect(@response.status).to eq(200)
  all_users = JSON.parse(@response.body)
  expect(all_users.size).to eq(2)
  all_users.each { |u| expect([name_one, name_two]).to include(u['name']) }
end

When('I delete the user') do
  @request = {}
  @response = Faraday.delete(delete_user_url(@user_id), @request, header)
  expect(@response.status).to eq(200)
end

Then('I should not get user {string}') do |_name|
  @request = {}
  @response = Faraday.get(find_user_url(@user_id))
  expect(@response.status).to eq(404)
end

When('I create the user with name {string}') do |user_name|
  step "User '#{user_name}' is already registered"
end

When('I change the user name to {string}') do |user_name|
  @request = {name: user_name}.to_json
  @response = Faraday.put(update_user_url(@user_id), @request, header)
  expect(@response.status).to eq(200)
end

When('I remove the user name') do
  @request = {name: ''}.to_json
  @response = Faraday.put(update_user_url(@user_id), @request, header)

  expect(@response.status).to eq(400)

  parsed_response = JSON.parse(@response.body)
  @error = parsed_response['error']
end

When('I get the last user updated') do
  step 'I get the last user created'
end

When('I change an invalid user name to {string}') do |user_name|
  @request = {name: user_name}.to_json
  @response = Faraday.put(update_user_url(-1), @request, header)
  expect(@response.status).to eq(404)
end

When('I create the user without a name') do
  @request = {name: ''}.to_json
  @response = Faraday.post(create_user_url, @request, header)
  expect(@response.status).to eq(400)

  parsed_response = JSON.parse(@response.body)
  @error = parsed_response['error']
end

Then('I get should get an error message') do
  expect(@error).to eq('name is missing')
end

Then('I should not get any user') do
  expect(@response.status).to eq(200)
  all_users = JSON.parse(@response.body)
  expect(all_users.empty?).to be_truthy
end
