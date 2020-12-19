# ReplaceME with RomRb Config?
#
# Sequel::Model.raise_on_save_failure = false # Do not throw exceptions on failure
#
# database_url = ENV['DATABASE_URL']
# case Padrino.env
# when :development
#   database_url = ENV['DATABASE_URL'] || 'postgres://postgres:postgres@localhost/jobvacancy_development'
# when :test
#   database_url = ENV['DATABASE_URL'] || 'postgres://postgres:postgres@localhost/jobvacancy_test'
# end
#
# unless database_url
#   raise 'Check database.rb, you must set env variable DATABASE_URL!'
# end
#
# DB = Sequel.connect(database_url, loggers: [logger])
# DB.loggers << Logger.new($stdout)
