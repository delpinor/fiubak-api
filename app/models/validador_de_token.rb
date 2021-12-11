require_relative '../../app/models/errors/no_autorizado_error'

class ValidadorDeToken
  def initialize
    @token_bot = ENV['HTTP_BOT_TOKEN']
    @token_rev = ENV['HTTP_REV_TOKEN']
    validar_que_existan
  end

  def validar_para_revision(token)
    raise NoAutorizadoError if @token_rev != token
  end

  def validar_para_bot(token)
    raise NoAutorizadoError if @token_bot != token
  end

  private

  def validar_que_existan
    raise VariablesNoDefinidasError if @token_rev == nil or @token_bot == nil
  end
end
