require_relative '../../app/models/errors/no_autorizado_error'
require_relative '../../app/models/errors/variables_no_definidas_error'

class ValidadorDeToken
  def initialize
    @token_bot = ENV['HTTP_BOT_TOKEN']
    @token_rev = ENV['HTTP_REV_TOKEN']
  end

  def validar_para_revision(token)
    raise VariablesNoDefinidasError if token == nil
    raise NoAutorizadoError if @token_rev != token
  end

  def validar_para_bot(token)
    raise VariablesNoDefinidasError if token == nil
    raise NoAutorizadoError if @token_bot != token
  end
end
