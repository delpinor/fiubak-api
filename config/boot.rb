# Defines our constants
RACK_ENV = ENV['RACK_ENV'] ||= 'development' unless defined?(RACK_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

# Load our dependencies
require 'bundler/setup'
Bundler.require(:default, RACK_ENV)

##
# ## Enable devel logging
#
# Padrino::Logger::Config[:development][:log_level]  = :devel
# Padrino::Logger::Config[:development][:log_static] = true

log_level = ENV['LOG_LEVEL'] || 'debug'
log_stream = ENV['LOG_STREAM'] || 'stdout'
log_file = ENV['LOG_FILE'] || '/app/logs/dev.log'

current_env = ENV['RACK_ENV'].to_sym
Padrino::Logger::Config[current_env][:log_level]  = log_level.to_sym
Padrino::Logger::Config[current_env][:stream] = log_stream.to_sym
Padrino::Logger::Config[current_env][:log_path]  = log_file

#
# ## Configure Ruby to allow requiring features from your lib folder
#
# $LOAD_PATH.unshift Padrino.root('lib')
#
# ## Enable logging of source location
#
# Padrino::Logger::Config[:development][:source_location] = true
#
# ## Configure your I18n
#
# I18n.default_locale = :en
# I18n.enforce_available_locales = false
#
# ## Configure your HTML5 data helpers
#
# Padrino::Helpers::TagHelpers::DATA_ATTRIBUTES.push(:dialog)
# text_field :foo, :dialog => true
# Generates: <input type="text" data-dialog="true" name="foo" />
#
# ## Add helpers to mailer
#
# Mail::Message.class_eval do
#   include Padrino::Helpers::NumberHelpers
#   include Padrino::Helpers::TranslationHelpers
# end

##
# Require initializers before all other dependencies.
# Dependencies from 'config' folder are NOT re-required on reload.
#
Padrino.dependency_paths.unshift Padrino.root('config/initializers/*.rb')

##
# Add your before (RE)load hooks here
# These hooks are run before any dependencies are required.
#
Padrino.before_load do
  Padrino.dependency_paths << Padrino.root('app/persistence/**/*.rb')
  Padrino.dependency_paths << Padrino.root('app/errors/**/*.rb')
end

##
# Add your after (RE)load hooks here
#
Padrino.after_load do
end

Padrino.load!
