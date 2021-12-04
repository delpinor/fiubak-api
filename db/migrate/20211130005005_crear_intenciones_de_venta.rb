Sequel.migration do
  up do
    create_table(:intenciones_de_venta) do
      primary_key :id
      foreign_key :id_usuario, :usuarios, on_delete: :cascade
      foreign_key :id_auto, :autos, on_delete: :cascade
      String :estado
    end
  end

  down do
    drop_table(:intenciones_de_venta)
  end
end
