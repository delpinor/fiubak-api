require 'spec_helper'

describe 'Revision de auto' do

  let(:auto){Auto.new('fiat', 'duna', 2015, 'ABC-D')}

  it 'Dado que revisamos 3 componenes entonces recibo estado de los 3' do
    revision = RevisionAuto.new
    resultado = revision.revisar_partes(auto)
    expect(resultado.estado_partes.size).to eq(3)
  end

  xit 'Dado que el auto no tiene fallas entonces las partes no tienen fallas' do
    revision = RevisionAuto.new
    resultado = revision.revisar_partes(auto)
    expect(resultado.estado_partes[0].estado).to eq(SinFalla.new)
    expect(resultado.estado_partes[1].estado).to eq(SinFalla.new)
    expect(resultado.estado_partes[2].estado).to eq(SinFalla.new)
  end

  xit 'Dado que el auto no tiene fallas el precio es de lista' do
    revision = RevisionAuto.new
    valor_lista = RepositorioListaPrecios.new.precio_lista(auto)
    resultado = revision.revisar_partes(auto)
    expect(resultado.valor_cotizacion).to eq(SinFalla.new)
  end
end
