

def header
  {'Content-Type' => 'application/json',
   'BOT_TOKEN' => ENV['HTTP_BOT_TOKEN'],
   'REV_TOKEN' => ENV['HTTP_REV_TOKEN']}
end
