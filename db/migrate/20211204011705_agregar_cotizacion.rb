Sequel.migration do
  up do
    add_column :intenciones_de_venta, :precio_cotizado, Float
  end

  down do
    drop_column :intenciones_de_venta, :precio_cotizado
  end
end
