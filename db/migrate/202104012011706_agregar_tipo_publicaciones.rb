Sequel.migration do
  up do
    add_column :publicaciones, :tipo, String
  end

  down do
    drop_column :publicaciones, :tipo
  end
end
