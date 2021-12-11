module HttpHelpers
  def header_con_token
    { 'CONTENT_TYPE' => 'application/json',
      'HTTP_BOT_TOKEN' => ENV['HTTP_BOT_TOKEN'],
      'HTTP_REV_TOKEN' => ENV['HTTP_REV_TOKEN'] }
  end

  def header_sin_token
    { 'CONTENT_TYPE' => 'application/json' }
  end
end
