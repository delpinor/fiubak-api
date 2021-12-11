class ProveedorDeClima
  def initialize()
    @climas = obtener_climas_desde_api()
  end

  def obtener_climas_desde_api
    require 'byebug'
    api_key = ENV['CLIMA_API_KEY']
    url = ENV['CLIMA_API_URL']
    response = Faraday.get(url + api_key)
    raise ClimaApiError if response.status != 200
    data = JSON.parse(response.body)
    climas_del_dia = data['weather'].map {|x| x['main']}.compact
    # existe_lluvia = climas_del_dia.include? 'Rain'
    # clima = existe_lluvia ? 'lluvioso' : "no lluvioso"
    return climas_del_dia
  end

  def obtener_climas
    @climas
  end

  def fijar_climas(climas)
    @climas = climas
  end
end
