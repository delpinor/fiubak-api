Sequel.migration do
  up do
    create_table(:tasks) do
      primary_key :id
      String :title
      Integer :user_id
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:tasks)
  end
end

