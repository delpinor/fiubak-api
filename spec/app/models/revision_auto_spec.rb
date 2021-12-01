require 'spec_helper'

describe 'Revision de auto' do

  let(:auto){Auto.new('fiat', 'duna', 2015, 'ABC-D')}
  let(:revision){RevisionAuto.new(auto)}

  it 'Dado que revisamos 3 componenes entonces recibo estado de los 3' do
    resultado = revision.resultado
    expect(resultado.estado_partes.size).to eq(3)
  end

  it 'Dado que el auto no tiene fallas entonces las partes no tienen fallas' do
    resultado = revision.resultado
    partes = resultado.estado_partes
    expect(partes[0].estado).to eq(SinDanio.new)
    expect(partes[1].estado).to eq(SinDanio.new)
    expect(partes[2].estado).to eq(SinDanio.new)
  end

  xit 'Dado que el auto no tiene fallas el precio es de lista' do
    revision = RevisionAuto.new
    valor_lista = RepositorioListaPrecios.new.precio_lista(auto)
    resultado = revision.revisar_partes(auto)
    expect(resultado.valor_cotizacion).to eq(SinFalla.new)
  end
end
