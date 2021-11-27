Sequel.migration do
  up do
    create_table(:usuarios) do
      primary_key :id
      Integer :dni, unique: true
      String :nombre
      String :email
    end
  end

  down do
    drop_table(:usuarios)
  end
end
