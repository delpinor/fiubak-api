require 'spec_helper'

describe 'Repositori de lista de precios' do

  let(:auto){Auto.new('fiat', 'duna', 2015, 'ABC-D')}

  it 'Al consutlar el precio de un auto entonces me devuelve un valor positivo' do
    valor_auto = RepositorioListaPrecios.new.precio_de_lista(auto)
    expect(valor_auto > 0).to eq(true)
  end

end
