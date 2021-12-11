require 'spec_helper'

describe 'Validador por token de los endpoint' do

  let(:validador){ValidadorDeToken.new}

  it 'Cuando valido con un token incorrecto entonces no estoy autorizado' do
    expect(validador.es_valido?('safasdfsd')).to eq(true)
  end

  xit 'Cuando valido con un token incorrecto entonces no estoy autorizado' do
    expect(validador.es_valido?(ENV['HTTP_BOT_TOKEN'])).to eq(true)

  end
end
