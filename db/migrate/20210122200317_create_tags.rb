ROM::SQL.migration do
  change do
    create_table :tags do
      primary_key :id
      column :tag_name, String, null: false
    end
  end
end
