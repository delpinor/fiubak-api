require 'spec_helper'

describe 'Crear usuario' do
  context 'Se crea con datos válidos' do
    before(:each)  do
      @usuario = Usuario.new(33234543, 'Nicolas', 'nicoperez@gmail.com', 665)
    end
    it 'Se crea con DNI' do
      expect(@usuario.dni).to eq 33234543
    end

    it 'Se crea con nombre' do
      expect(@usuario.nombre).to eq 'Nicolas'
    end

    it 'Se crea con email' do
      expect(@usuario.email).to eq 'nicoperez@gmail.com'
    end
  end

  context 'Se crea con datos inválidos' do
    it 'Lanza un error cuando el DNI es negativo' do
      expect {Usuario.new(-21, 'Nicolas', 'nicoperez@gmail.com', 878)
      }.to raise_error(DniInvalidoError)
    end
  end
end
