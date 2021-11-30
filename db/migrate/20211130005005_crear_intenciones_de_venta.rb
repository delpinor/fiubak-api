Sequel.migration do
    up do
      create_table(:intenciones_de_venta) do
        primary_key :id
        foreign_key :id_usuario, :usuarios
        foreign_key :id_auto, :autos
        String :estado
      end
    end
  
    down do
      drop_table(:intenciones_de_venta)
    end
  end