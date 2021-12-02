Sequel.migration do
  up do
    create_table(:publicaciones) do
      primary_key :id
      foreign_key :id_usuario, :usuarios, on_delete: :cascade
      foreign_key :id_auto, :autos, on_delete: :cascade
      Integer :precio
    end
  end

  down do
    drop_table(:publicaciones)
  end
end
