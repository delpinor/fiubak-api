module HttpHelpers
  def header_con_token
    { 'CONTENT_TYPE' => 'application/json',
      'API_TOKEN' => ENV['API_TOKEN'],
      'REV_TOKEN' => ENV['REV_TOKEN'] }
  end

  def header_sin_token
    { 'CONTENT_TYPE' => 'application/json' }
  end
end
