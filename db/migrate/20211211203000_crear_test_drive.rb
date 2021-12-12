Sequel.migration do
  up do
    create_table(:test_drives) do
      primary_key :id
      foreign_key :id_publicacion, :publicaciones, on_delete: :cascade
      String :fecha
    end
  end

  down do
    drop_table(:test_drives)
  end
end
