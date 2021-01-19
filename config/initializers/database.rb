# ReplaceME with RomRb Config?
#
# Sequel::Model.raise_on_save_failure = false # Do not throw exceptions on failure
#

case ENV['RACK_ENV'].to_sym
when :test
  DATABASE_URL = ENV['TEST_DB_URL'] || 'postgres://postgres:postgres@localhost/webapi_template_test'
when :development
  DATABASE_URL = ENV['DEV_DB_URL'] || 'postgres://postgres:postgres@localhost/webapi_template_development'
else
  DATABASE_URL = ENV['DATABASE_URL']
end

#
# DB = Sequel.connect(database_url, loggers: [logger])
# DB.loggers << Logger.new($stdout)
