ROM::SQL.migration do
  change do
    create_table :tags_tasks do
      primary_key :id
      foreign_key :tag_id, :tags
      foreign_key :task_id, :tasks
    end
  end
end
