require 'spec_helper'

describe 'Crear usuario' do
  context 'Se crea con datos válidos' do
    before(:each)  do
      @usuario = Usuario.new(33234543, 'Nicolas', 'nicoperez@gmail.com')
    end
    xit 'Se crea con DNI' do
      expected(@usuario.dni).to eq 33234543
    end

    xit 'Se crea con nombre' do
      expected(@usuario.nombre).to eq 'Nicolas'
    end

    xit 'Se crea con email' do
      expected(@usuario.mail).to eq 'nicoperez@gmail.com'
    end
  end

  context 'Se crea con datos inválidos' do
    xit 'Lanza un error cuando el DNI no es un numero' do
      expect {Usuario.new('asd', 'Nicolas', 'nicoperez@gmail.com')
      }.to raise_error(DniInvalidoError)
    end
  end
end
