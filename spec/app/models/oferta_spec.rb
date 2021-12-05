require 'spec_helper'

describe 'Crear oferta' do
  context 'Se crea con datos válidos' do
    before(:each)  do
      @usuario_comprador = Usuario.new(33234543, 'Nicolas', 'nicoperez@gmail.com', 665)
      @oferta = Oferta.new(@usuario_comprador, 45000)
    end
    it 'Se crea con usuario comprador' do
      expect(@oferta.usuario.nombre).to eq "Nicolas"
    end

    it 'Se crea con valor' do
      expect(@oferta.valor).to eq 45000
    end

  end

end
