require 'spec_helper'

describe 'Ventas helper' do
  context 'Se crea con datos válidos' do
    before(:each)  do
      @auto = Auto.new("Fiat", "uno", 1940, "MFL200", 450)
      @usuario = Usuario.new(33234543, 'Nicolas', 'nicoperez@gmail.com', 665)
    end
    it 'Se crea la intencion de venta con un autoI' do
      intencion_venta = crear_intencion_de_venta(@usuario, @auto)
      expect(intencion_venta.auto.id).to eq 450
    end
  end
end

