require 'spec_helper'

describe 'Revision de auto' do

  let(:auto){Auto.new('fiat', 'duna', 2015, 'ABC-D')}
  let(:cotizacion){CotizacionAuto.new(auto)}

  it 'Dado que el auto no tiene fallas el precio es de lista' do
    cotizacion.agregar_parte(ParteNeumaticos.new(SinDanio.new))
    cotizacion.agregar_parte(ParteNeumaticos.new(SinDanio.new))
    cotizacion.agregar_parte(ParteNeumaticos.new(SinDanio.new))
    valor_lista = RepositorioListaPrecios.new.precio_de_lista(auto)
    expect(cotizacion.valor_cotizado).to eq(valor_lista)
  end

end
