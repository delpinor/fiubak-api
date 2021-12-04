require 'spec_helper'

describe 'Daño alto de parte de auto' do
  it 'La penalizacion por daño alto debe ser 15% por ciento' do
    pct = DanioAlto.new.penalizacion
    expect(pct).to eq(0.15)
  end
end
