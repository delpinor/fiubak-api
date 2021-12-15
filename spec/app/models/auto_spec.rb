require 'spec_helper'

describe 'Crear auto' do
  context 'Se crea con datos válidos' do
    before(:each)  do
      @auto = Auto.new("Fiat", "uno", 1940, "MFL200")
    end
    it 'Se crea con marca' do
      expect(@auto.marca).to eq "Fiat"
    end

    it 'Se crea con modelo' do
      expect(@auto.modelo).to eq 'uno'
    end

    it 'Se crea con anio' do
      expect(@auto.anio).to eq 1940
    end

    it 'Se crea con patente' do
      expect(@auto.patente).to eq 'MFL200'
    end

    it 'al crear dos autos con mismos datos, son iguales' do
      auto1 = Auto.new("Fiat", "uno", 1940, "MFL200")
      auto2 = Auto.new("Fiat", "uno", 1940, "MFL200")
      expect(auto1 == auto2).to eq(true)
    end

    it 'al crear dos autos con distintos datos, son diferentes' do
      auto1 = Auto.new("Fiat", "uno", 1940, "MFL200")
      auto2 = Auto.new("Fiat", "uno", 1950, "MFL200")
      expect(auto1 == auto2).to eq(false)
    end

    it 'El auto debe contener Marca, Modelo y año sino se lanza un error' do
      expect { Auto.new('ford', 'focus', nil, nil) }.to raise_error(AutoInvalidoError)
    end
  end
end
