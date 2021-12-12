class ProveedorDeClima

  CLIMA_API_URL = "https://api.openweathermap.org/data/2.5/weather?q=Buenos%20Aires&appid="

  def initialize(clima="")
    if clima.empty?
      @clima = obtener_clima_desde_api()
    else
      @clima = clima
    end
  end

  def obtener_clima_desde_api
    api_key = ENV['CLIMA_API_KEY']
    response = Faraday.get(CLIMA_API_URL + api_key)
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
