require 'spec_helper'

describe 'Revision de auto' do

  let(:auto){Auto.new('fiat', 'duna', 2015, 'ABC-D')}
  let(:cotizacion){CotizacionAuto.new(auto, 200)}

  it 'Dado que el auto no tiene fallas el precio es de lista' do
    cotizacion.agregar_parte(ParteNeumaticos.new(SinDanio.new))
    cotizacion.agregar_parte(ParteMotor.new(SinDanio.new))
    cotizacion.agregar_parte(ParteEstetica.new(SinDanio.new))
    expect(cotizacion.valor_cotizado).to eq(200)
  end

end
