Sequel.migration do
  up do
    create_table(:ofertas) do
      primary_key :id
      foreign_key :id_usuario, :usuarios, on_delete: :cascade
      foreign_key :id_publicacion, :publicaciones, on_delete: :cascade
      Integer :valor
    end
  end

  down do
    drop_table(:ofertas)
  end
end
