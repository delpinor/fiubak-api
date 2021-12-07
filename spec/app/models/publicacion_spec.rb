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

  context 'Ofertas de la publicacion' do
    before(:each)  do
      @auto = Auto.new("Fiat", "uno", 1940, "MFL200", 1)
      @usuario_vendedor = Usuario.new(33234543, 'Nicolas', 'nicoperez@gmail.com', 665)
      @publicacion = Publicacion.new(@usuario_vendedor, @auto, 75000, "Fiubak",1)
      @usuario_comprador = Usuario.new(33234542, 'Juuan', 'juan@gmail.com', 666)
      @oferta = Oferta.new(@usuario_comprador, 45000, 'pendiente')
    end

    it 'Al consultar las ofertas de una publicacion obtengo vacio' do
      ofertas = @publicacion.obtener_ofertas
      expect(ofertas.length).to eq(0)
    end

    it 'Al agregar una oferta luego la cantidad de ofertas es uno' do
      oferta = @publicacion.agregar_oferta(@oferta)
      ofertas = @publicacion.obtener_ofertas
      expect(ofertas.length).to eq(1)
    end

    it 'Al agregar una oferta y luego obtener las ofertas puedo ver sus datos' do
      oferta = @publicacion.agregar_oferta(@oferta)
      todas_las_ofertas = @publicacion.obtener_ofertas()
      expect(todas_las_ofertas.length).to eq(1)
      expect(todas_las_ofertas[0].usuario).to be_present
      expect(todas_las_ofertas[0].usuario.id).to be_present
      expect(todas_las_ofertas[0].valor).to be_present
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
