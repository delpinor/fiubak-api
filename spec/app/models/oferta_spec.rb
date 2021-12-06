require 'spec_helper'

describe 'Crear oferta' do
  context 'Se crea con datos válidos' do
    before(:each)  do
      @auto = Auto.new("Fiat", "uno", 1940, "MFL200", 1)
      @usuario_comprador = Usuario.new(33234543, 'Nicolas', 'nicoperez@gmail.com', 665)
      @usuario_vendedor = Usuario.new(332345431, 'Nicolas2', 'nicopere2z@gmail.com', 6635)
      @publicacion = Publicacion.new(@usuario_vendedor, @auto, 75000, "Fiubak",1)
      @oferta = Oferta.new(@usuario_comprador, 75000, "Creada")
    end
    it 'Se crea con usuario comprador' do
      expect(@oferta.usuario.nombre).to eq "Nicolas"
    end

    it 'Se crea con valor' do
      expect(@oferta.valor).to eq 75000
    end

    it 'Se crea con estado' do
      expect(@oferta.estado).to eq 'Creada'
    end

  end

end
