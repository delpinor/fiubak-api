require 'spec_helper'

describe 'Validador por token' do

  let(:validador){ValidadorDeToken.new}

  xit 'Cuando es invalido para bot' do
    expect{validador.validar_para_bot('safasdfsd')}.to raise_error(NoAutorizadoError)
  end

  xit 'Cuando es invalido para revision' do
    expect{validador.validar_para_revision('safasdfsd')}.to raise_error(NoAutorizadoError)
  end

  it 'Cuando es valido para bot' do
    expect{validador.validar_para_bot(ENV['BOT_TOKEN'])}.not_to raise_error(NoAutorizadoError)

  end

  it 'Cuando es valido para revision' do
    expect{validador.validar_para_revision(ENV['REV_TOKEN'])}.not_to raise_error(NoAutorizadoError)
  end
end
