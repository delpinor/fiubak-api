require 'rom'
require_relative 'database'

DB = ROM.container(:sql, DATABASE_URL) do |config|
  config.relation(:users) do
    schema(infer: true)
    auto_struct true
  end

end