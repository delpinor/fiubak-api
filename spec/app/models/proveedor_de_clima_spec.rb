require 'spec_helper'
require 'webmock'
require 'webmock/rspec'

describe 'Crear ProveedorDeClima' do
  context 'Se crea con datos válidos' do
    
    it 'Se crea con clima' do
      api_key = ENV['CLIMA_API_KEY']
      url = "https://api.openweathermap.org/data/2.5/weather?q=Buenos%20Aires&appid="
      stub = stub_request(:get, url + api_key)
        .to_return(body: {"weather": [{"main": "Cold"}, {"main": "Hot"}]}.to_json)
      proveedor = ProveedorDeClima.new
      expect(proveedor.obtener_clima).to eq("no lluvioso")
    end

  end
end
