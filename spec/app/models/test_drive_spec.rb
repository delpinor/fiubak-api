require 'spec_helper'

describe 'Crear test-drive' do
  context 'Se crea con datos válidos' do
    before(:each)  do
      @auto = Auto.new("Fiat", "uno", 1940, "MFL200", 1)
      @usuario_vendedor = Usuario.new(332345431, 'Nicolas2', 'nicopere2z@gmail.com', 6635)
      @publicacion = Publicacion.new(@usuario_vendedor, @auto, 1000, "Fiubak",1)
      @test_drive_lluvioso = TestDrive.new(@publicacion, '2020-05-05')
      @test_drive_no_lluvioso = TestDrive.new(@publicacion, '2020-05-05')
    end
    
    it 'Se crea con publicacion' do
      expect(@test_drive_lluvioso.publicacion.precio).to eq 1000
    end
    
    it 'Se crea con fecha' do
      expect(@test_drive_lluvioso.fecha).to eq '2020-05-05'
    end

    it 'Con dia lluvioso el precio del test-drive es del 0.008%' do
      proveedor_de_clima_lluvioso = double('ProveedorDeClima', :obtener_clima => "lluvioso")
      expect(@test_drive_lluvioso.obtener_costo(proveedor_de_clima_lluvioso)).to eq 8
    end

    it 'Con dia no lluvioso el precio del test-drive es del 0.01%' do
      proveedor_de_clima_no_lluvioso = proveedor_de_clima = double('ProveedorDeClima', :obtener_clima => "soleado")
      expect(@test_drive_no_lluvioso.obtener_costo(proveedor_de_clima_no_lluvioso)).to eq 10
    end

  end
end
