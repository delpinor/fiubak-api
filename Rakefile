require 'bundler/setup'
require 'padrino-core/cli/rake'
require 'English'

RACK_ENV = ENV['RACK_ENV'] ||= ENV['RACK_ENV'] ||= 'test' unless defined?(RACK_ENV)

PadrinoTasks.use(:database)
PadrinoTasks.use(:sequel)
PadrinoTasks.init
