require 'rom'
DATABASE_URL = ENV['DATABASE_URL']
DB = ROM.container(:sql, DATABASE_URL) do |config|
  config.relation(:users) do
    schema(infer: true)
    auto_struct true
  end
end