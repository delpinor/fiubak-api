require 'spec_helper'

describe 'Crear auto' do
  context 'Se crea con datos válidos' do
    before(:each)  do
      @usuario = Auto.new("Fiat", "uno", 1940, "MFL200")
    end
    it 'Se crea con marca' do
      expect(@usuario.marca).to eq "Fiat"
    end

    it 'Se crea con modelo' do
      expect(@usuario.modelo).to eq 'uno'
    end

    it 'Se crea con anio' do
      expect(@usuario.anio).to eq 1940
    end

    it 'Se crea con patente' do
      expect(@usuario.patente).to eq 'MFL200'
    end
  end
end
