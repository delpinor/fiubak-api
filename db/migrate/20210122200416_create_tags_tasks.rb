Sequel.migration do
  up do
    create_join_table(tag_id: :tags, task_id: :tasks)
  end

  down do
    drop_table(:tags_tasks)
  end
end
