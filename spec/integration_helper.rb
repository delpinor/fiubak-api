# rubocop:disable all
require 'spec_helper'
require_relative './support/http_helpers'

RSpec.configure do |config|
  config.include HttpHelpers

  config.after :each do
    #Persistence::Repositories::RepositorioDeIntencionesDeVenta.new.delete_all
    Persistence::Repositories::RepositorioDePublicaciones.new.delete_all
    Persistence::Repositories::RepositorioDeAutos.new.delete_all
    Persistence::Repositories::RepositorioDeUsuarios.new.delete_all
  end
end
