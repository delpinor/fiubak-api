require 'spec_helper'

describe 'Crear intencion de venta' do
  context 'Se crea con datos válidos' do
    before(:each)  do
      @auto = Auto.new("Fiat", "uno", 1940, "MFL200", 1)
      @usuario = Usuario.new(33234543, 'Nicolas', 'nicoperez@gmail.com', 665)
      @intencion_de_venta = IntencionDeVenta.new(@auto, @usuario, "revisado y cotizado", 1)
      @intencion_de_venta.set_valor_cotizado(30000)
    end

    it 'El precio de cotizacion no puede ser negativo' do
      expect { @intencion_de_venta.set_valor_cotizado(-1) }.to raise_error(PrecioNegativoError)
    end

    it 'Se crea con estado' do
      expect(@intencion_de_venta.estado).to eq "revisado y cotizado"
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

    it 'Al concretar una intencion de venta su estado cambia a vendido y obtengo una publicacion de tipo p2p' do
      publicacion = @intencion_de_venta.concretar_por_p2p(45000)
      expect(publicacion.tipo).to eq("p2p")
    end

    it 'Al concretar una intencion de venta su estado cambia a vendido y obtengo una publicacion de 45000 pesos' do
      publicacion = @intencion_de_venta.concretar_por_p2p(45000)
      expect(publicacion.precio).to eq(45000)
    end

    it 'Al concretar una intencion de venta con un precio menor o igual al de cotizacion obtengo un error' do
      expect{@intencion_de_venta.concretar_por_p2p(28000)}.to raise_error(PrecioDePublicacionInvalido)
      expect{@intencion_de_venta.concretar_por_p2p(30000)}.to raise_error(PrecioDePublicacionInvalido)
    end

    it 'Al querer pasar de estado publicado a rechazado obtengo un error' do
      @intencion_de_venta.a_publicado
      expect{@intencion_de_venta.a_rechazado}.to raise_error(TransicionEstadoAutoInvalida)
      expect{@intencion_de_venta.revisado_y_cotizado}.to raise_error(TransicionEstadoAutoInvalida)
    end

    it 'Al querer pasar de estado vendido a rechazado o publicado o revisado y cotizado obtengo un error' do
      @intencion_de_venta.concretar_por_fiubak
      expect{@intencion_de_venta.a_rechazado}.to raise_error(TransicionEstadoAutoInvalida)
      expect{@intencion_de_venta.a_publicado}.to raise_error(TransicionEstadoAutoInvalida)
      expect{@intencion_de_venta.revisado_y_cotizado}.to raise_error(TransicionEstadoAutoInvalida)
    end

  end
end
