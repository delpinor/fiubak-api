require 'spec_helper'

describe 'Revision de auto' do

  let(:auto){Auto.new('fiat', 'duna', 2015, 'ABC-D')}
  let(:cotizacion){CotizacionAuto.new(auto, 200000)}

  it 'Dado que el auto no tiene fallas el precio es de lista' do
    cotizacion.agregar_parte(ParteNeumaticos.new(SinDanio.new))
    cotizacion.agregar_parte(ParteMotor.new(SinDanio.new))
    cotizacion.agregar_parte(ParteEstetica.new(SinDanio.new))
    expect(cotizacion.valor_cotizado).to eq(200000)
  end

  it 'Dado que el auto tiene una falla de neumaticos baja, entonces se le descuenta 3%' do
    cotizacion.agregar_parte(ParteNeumaticos.new(DanioBajo.new))
    cotizacion.agregar_parte(ParteMotor.new(SinDanio.new))
    cotizacion.agregar_parte(ParteEstetica.new(SinDanio.new))
    expect(cotizacion.valor_cotizado).to eq(194000)
  end

end
