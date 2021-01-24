source 'https://rubygems.org'

# Padrino supports Ruby version 2.2.2 and later
# ruby '2.6.3'

# Distribute your app as a gem
# gemspec

# Server requirements
# gem 'thin' # or mongrel
# gem 'trinidad', :platform => 'jruby'

# Optional JSON codec (faster performance)
# gem 'oj'

# Project requirements
gem 'rake'

# Component requirements
gem 'activemodel', require: 'active_model'
gem 'pg'
gem 'rack-parser', :require => 'rack/parser'
gem 'rom'
gem 'rom-sql'
# gem 'sequel'

# Test requirements

# Padrino Stable Gem
gem 'padrino', '0.15.0'

# Or Padrino Edge
# gem 'padrino', :github => 'padrino/padrino-framework'

# Or Individual Gems
# %w(core support gen helpers cache mailer admin).each do |g|
#   gem 'padrino-' + g, '0.15.0'
# end

group :development, :test do
  gem 'byebug'
  gem 'cucumber'
  gem 'faraday'
  gem 'rack-test', require: 'rack/test'
  gem 'rspec'
  gem 'rspec-core'
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
  gem 'simplecov'
end
