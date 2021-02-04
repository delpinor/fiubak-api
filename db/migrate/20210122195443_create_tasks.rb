ROM::SQL.migration do
  change do
    create_table :tasks do
      primary_key :id
      column :title, String, null: false
      foreign_key :user_id, :users
    end
  end
end
