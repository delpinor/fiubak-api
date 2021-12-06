Sequel.migration do
    up do
      add_column :ofertas, :estado, String
    end
  
    down do
      drop_column :ofertas, :estado
    end
  end  