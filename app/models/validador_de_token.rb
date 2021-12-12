require_relative '../../app/models/errors/no_autorizado_error'

class ValidadorDeToken
  def initialize
    @token_bot = ENV['API_TOKEN']
    @token_rev = ENV['REV_TOKEN']
  end

  def validar_para_revision(token)
    raise NoAutorizadoError if @token_rev != token or token == nil
  end

  def validar_para_bot(token)
    raise NoAutorizadoError if @token_bot != token or token == nil
  end
end
