require 'spec_helper'

describe 'Daño medio de parte de auto' do
  it 'La penalizacion por daño medio debe ser 8% por ciento' do
    pct = DanioMedio.new.penalizacion
    expect(pct).to eq(0.08)
  end
end
