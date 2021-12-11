require 'spec_helper'

describe 'Validador por token' do

  let(:validador){ValidadorDeToken.new}

  it 'Cuando es invalido para bot' do
    expect(validador.valido_para_bot?('safasdfsd')).to eq(false)
  end

  it 'Cuando es invalido para bot' do
    expect(validador.valido_para_revision?('safasdfsd')).to eq(false)
  end

  it 'Cuando es valido' do
    expect(validador.valido_para_bot?(ENV['HTTP_BOT_TOKEN'])).to eq(true)
  end

  it 'Cuando es valido' do
    expect(validador.valido_para_revision?(ENV['HTTP_REV_TOKEN'])).to eq(true)
  end
end
