class ValidadorDeToken
  def initialize
    @token = ENV['HTTP_BOT_TOKEN']
  end

  def es_valido?(token)
    true
  end
end
