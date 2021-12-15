class CreadorAuto
  def initialize
    @repo = Persistence::Repositories::RepositorioDeAutos.new
  end

  def crear_auto(marca, modelo, anio, patente, id=nil)
    auto = Auto.new(marca, modelo, anio, patente, id)
    validar_auto(auto)
    auto_con_id = @repo.save(auto)
    auto_con_id
  end

  def validar_auto(auto)
    raise PatenteYaRegistradaError.new if @repo.check_by_patente(auto.patente)
  end
end