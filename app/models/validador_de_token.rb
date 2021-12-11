class ValidadorDeToken
  def initialize
    @token_bot = ENV['HTTP_BOT_TOKEN']
    @token_rev = ENV['HTTP_REV_TOKEN']
  end

  def valido_para_revision?(token)
    @token_rev == token
  end

  def valido_para_bot?(token)
    @token_bot == token
  end
end
