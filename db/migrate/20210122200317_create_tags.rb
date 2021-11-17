Sequel.migration do
  up do
    create_table(:tags) do
      primary_key :id
      String :tag_name
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:tags)
  end
end

