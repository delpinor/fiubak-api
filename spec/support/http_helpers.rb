module HttpHelpers
  def header_con_token
    { 'CONTENT_TYPE' => 'application/json',
      'BOT_TOKEN' => ENV['BOT_TOKEN'],
      'REV_TOKEN' => ENV['REV_TOKEN'] }
  end

  def header_sin_token
    { 'CONTENT_TYPE' => 'application/json' }
  end
end
