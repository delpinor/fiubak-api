# rubocop:disable all
ENV['RACK_ENV'] = 'test'
ENV['ENABLE_RESET'] = 'true'

require File.expand_path("#{File.dirname(__FILE__)}/../../config/boot")

require 'rspec/expectations'

if ENV['BASE_URL']
  BASE_URL = ENV['BASE_URL']
else
  BASE_URL = 'http://localhost:3000'.freeze
  include Rack::Test::Methods
  def app
    Padrino.application
  end
end

def header(id_usuario)
  { 'CONTENT_TYPE' => 'application/json',
    'API_TOKEN' => ENV['API_TOKEN'],
    'REV_TOKEN' => ENV['REV_TOKEN'],
    'USR_TOKEN' => id_usuario.to_s}
end

def find_user_url(user_id)
  "#{BASE_URL}/users/#{user_id}"
end

def find_task_url(task_id)
  "#{BASE_URL}/tasks/#{task_id}"
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

def create_task_url
  "#{BASE_URL}/tasks"
end

def create_tag_url
  "#{BASE_URL}/tags"
end

def add_tag_to_task_url(task_id)
  "#{BASE_URL}/tasks/add_tag/#{task_id}"
end

def delete_user_url(user_id)
  "#{BASE_URL}/users/#{user_id}"
end

def reset_url
  "#{BASE_URL}/reset"
end

def registrar_usuario_url
  "#{BASE_URL}/usuarios"
end

def registrar_nueva_venta(id_usuario)
  "#{BASE_URL}/usuarios/#{id_usuario}/intenciones_de_venta"
end

def consultar_intenciones_de_venta(id_intencion_de_venta)
  "#{BASE_URL}/intenciones_de_venta/#{id_intencion_de_venta}"
end

def obtener_publicaciones
  "#{BASE_URL}/publicaciones"
end

def crear_publicaciones
  "#{BASE_URL}/publicaciones"
end

def rechazar_oferta(id_oferta)
  "#{BASE_URL}/ofertas/#{id_oferta}/rechazar"
end

def aceptar_oferta(id_oferta)
  "#{BASE_URL}/ofertas/#{id_oferta}/aceptar"
end

def aceptar_cotizacion_url
  "#{BASE_URL}/aceptar_cotizacion"
end

def revisiones_url
  "#{BASE_URL}/revisiones"
end

def registrar_nueva_oferta(id_publicacion)
  "#{BASE_URL}/publicaciones/#{id_publicacion}/ofertas"
end

def consultar_detalle_publicacion(id_publicacion)
  "#{BASE_URL}/publicaciones/#{id_publicacion}"
end

def solicitar_test_drive(id_publicacion)
  "#{BASE_URL}/publicaciones/#{id_publicacion}/test_drives"
end

def fijar_clima
  "#{BASE_URL}/clima"
end

After do |_scenario|
  Faraday.post(reset_url)
end
