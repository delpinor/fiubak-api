require 'spec_helper'

describe 'Crear publicacion' do
  context 'Se crea con datos válidos' do
    before(:each)  do
      @auto = Auto.new("Fiat", "uno", 1940, "MFL200", 1)
      @usuario = Usuario.new(33234543, 'Nicolas', 'nicoperez@gmail.com', 665)
      @publicacion = Publicacion.new(@usuario, @auto, 75000, "Fiubak",1)
    end
    it 'Se crea con usuario' do
      expect(@publicacion.usuario.nombre).to eq "Nicolas"
    end

    it 'Se crea con auto' do
      expect(@publicacion.auto.id).to eq 1
    end

    it 'Se crea con precio' do
      expect(@publicacion.precio).to eq 75000
    end

    it 'Se crea con tipo Fiubak' do
      expect(@publicacion.tipo).to eq "Fiubak"
    end

  end
end


describe 'Crear publicacion invalida' do
  context 'Se crea con datos válidos' do
    before(:each)  do
      @auto = Auto.new("Fiat", "uno", 1940, "MFL200", 1)
      @usuario = Usuario.new(33234543, 'Nicolas', 'nicoperez@gmail.com', 665)
    end
    it 'Publicacion de tipo invalida levanta error de tipo' do
      expect{Publicacion.new(@usuario, @auto, 75000, "caca",1)}.to raise_error TipoInvalidoError
    end

    it 'Publicacion con precio negativo levanta error' do
      expect{Publicacion.new(@usuario, @auto, -75000, "Fiubak",1)}.to raise_error PrecioNegativoError
    end
  end
end
