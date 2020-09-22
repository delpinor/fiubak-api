Sequel::Model.raise_on_save_failure = false # Do not throw exceptions on failure

database_url = ENV['DATABASE_URL']
unless database_url
  raise 'Check database.rb, you must set env variable DATABSE_URL!'
end

DB = Sequel.connect(database_url, loggers: [logger])
DB.loggers << Logger.new($stdout)
