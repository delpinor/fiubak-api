class ProveedorDeClima
  def initialize()
    @clima = obtener_clima_desde_api()
  end

  def obtener_clima_desde_api
    require 'byebug'
    api_key = ENV['CLIMA_API_KEY']
    url = ENV['CLIMA_API_URL']
    response = Faraday.get(url + api_key)
    raise ClimaApiError if response.status != 200
    data = JSON.parse(response.body)
    climas_del_dia = data['weather'].map {|x| x['main']}.compact
    existe_lluvia = climas_del_dia.include? 'Rain'
    clima = existe_lluvia ? 'lluvioso' : "no lluvioso"
    return clima
  end

  def obtener_clima
    @clima
  end

  def fijar_clima(clima)
    @clima = clima
  end
end
