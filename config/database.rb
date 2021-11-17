# ReplaceME with RomRb Config?
#
# Sequel::Model.raise_on_save_failure = false # Do not throw exceptions on failure
#
Sequel::Model.raise_on_save_failure = true # Do not throw exceptions on failure

DB = 
  case ENV['RACK_ENV'].to_sym
  when :test
    #DATABASE_URL = ENV['TEST_DB_URL'] || 'postgres://postgres:postgres@localhost/webapi_template_test'
    test_db_url = ENV['TEST_DB_URL'] || 'postgres://postgres:postgres@localhost/webapi_template_test'
    Sequel.connect(test_db_url, loggers: [logger])
  when :development
    dev_db_url = ENV['DEV_DB_URL'] || 'postgres://postgres:postgres@localhost/webapi_template_development'
    Sequel.connect(dev_db_url, loggers: [logger])
  else
    Sequel.connect(ENV['DATABASE_URL'], loggers: [logger])
  end

#
# DB = Sequel.connect(database_url, loggers: [logger])
# DB.loggers << Logger.new($stdout)