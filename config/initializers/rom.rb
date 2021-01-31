require 'rom'
require_relative 'database'

DB = ROM.container(:sql, DATABASE_URL) do |config|

  config.relation(:users) do
    auto_struct true
    schema(infer: true) do
      associations do
        has_many :tasks
      end
    end
  end

  config.relation(:tasks) do
    auto_struct true
    schema(infer: true) do
      associations do
        belongs_to :user
        has_many :tags
      end
    end
  end

  config.relation(:tags) do
    auto_struct true
    schema(infer: true) do
      associations do
        has_many :tasks
      end
    end
  end

end