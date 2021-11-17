Sequel.migration do
  up do
    create_table(:tags_tasks) do
      primary_key :id
      Integer :tag_id
      Integer :task_id
    end
  end

  down do
    drop_table(:tags_tasks)
  end
end


