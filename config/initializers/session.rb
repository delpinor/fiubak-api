case ENV['RACK_ENV'].to_sym
when :production
  SESSION_SECRET = ENV['SESSION_SECRET']
else
  SESSION_SECRET = 'e572ab3f74bca54f24f9e9068a39ef34c54ed9ed701d2f7fe7b6ceb57764ac02'
end

raise 'Session secret not configured' if SESSION_SECRET.nil?
