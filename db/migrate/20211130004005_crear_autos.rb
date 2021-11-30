Sequel.migration do
  up do
    create_table(:autos) do
      primary_key :id
      String :marca
      String :modelo
      Integer :anio
      String :patente
    end
  end

  down do
    drop_table(:autos)
  end
end
