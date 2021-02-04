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
        many_to_many :tags, through: :tags_tasks
      end
    end
  end

  config.relation(:tags) do
    auto_struct true
    schema(infer: true) do
      associations do
        many_to_many :tasks, through: :tags_tasks
      end
    end
  end

  config.relation(:tags_tasks) do
    auto_struct true
    schema(infer: true) do
      associations do
        belongs_to :tag
        belongs_to :task
      end
    end
  end

end