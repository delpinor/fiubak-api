module HttpHelpers
  def header_con_token(usuario_id)
    { 'CONTENT_TYPE' => 'application/json',
      'API_TOKEN' => ENV['API_TOKEN'],
      'REV_TOKEN' => ENV['REV_TOKEN'],
      'USR_TOKEN' => usuario_id.to_s
    }
  end

  def header_sin_token(usuario_id)
    { 'CONTENT_TYPE' => 'application/json',
      'USR_TOKEN' => usuario_id.to_s}
  end
end
