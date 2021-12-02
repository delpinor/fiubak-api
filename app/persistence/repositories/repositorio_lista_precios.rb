class RepositorioListaPrecios
  def initialize
    @precios = []
    lista_inicial
  end

  def precio_de_lista(auto)
    @precios.each do |precio|
      return precio[:precio] if auto == precio[:auto]
    end
    0
  end

  private

  def lista_inicial
    @precios << {:auto => Auto.new('fiat', 'uno', 1988, 'ayd-455'), :precio => 50000}
    @precios << {:auto => Auto.new('fiat', 'uno', 1989, 'add-447'), :precio => 50000}
    @precios << {:auto => Auto.new('fiat', 'uno', 1990, 'ard-457'), :precio => 60000}
    @precios << {:auto => Auto.new('fiat', 'duna', 2015, 'ABC-342'), :precio => 60000}
  end
end
