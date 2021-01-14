ENV['RACK_ENV'] = 'test'

require File.expand_path("#{File.dirname(__FILE__)}/../../config/boot")

require 'rspec/expectations'

BASE_URL = ENV['BASE_URL'] || 'http://localhost:3000'

def header
  {'Content-Type' => 'application/json'}
end

def find_user_url(user_id)
  "#{BASE_URL}/users/#{user_id}"
end

def update_user_url(user_id)
  "#{BASE_URL}/users/#{user_id}"
end

def find_all_users_url
  "#{BASE_URL}/users"
end

def create_user_url
  "#{BASE_URL}/users"
end

def delete_user_url(user_id)
  "#{BASE_URL}/users/#{user_id}"
end

def reset_url
  "#{BASE_URL}/reset"
end

After do |_scenario|
  Faraday.post(reset_url)
end