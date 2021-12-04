require 'spec_helper'

describe 'Crear intencion de venta' do
  context 'Se crea con datos válidos' do
    before(:each)  do
      @auto = Auto.new("Fiat", "uno", 1940, "MFL200", 1)
      @usuario = Usuario.new(33234543, 'Nicolas', 'nicoperez@gmail.com', 665)
      @intencion_de_venta = IntencionDeVenta.new(@auto, @usuario, "en revision", 1)
    end
    it 'Se crea con estado' do
      expect(@intencion_de_venta.estado).to eq "en revision"
    end

    it 'Se crea con auto' do
      expect(@intencion_de_venta.auto.id).to eq 1
    end

    it 'Se crea con usuario' do
      expect(@intencion_de_venta.usuario.id).to eq 665
    end

    it 'Al concretar una intencion de venta su estado cambia a vendido y obtengo una publicacion con precio' do
      publicacion = @intencion_de_venta.concretar_por_fiubak
      expect(publicacion.precio).to be_present
    end

    it 'Al concretar una intencion de venta su estado cambia a vendido y obtengo una publicacion de tipo Fiubak' do
      publicacion = @intencion_de_venta.concretar_por_fiubak
      expect(publicacion.tipo).to eq("Fiubak")
    end

  end
end
