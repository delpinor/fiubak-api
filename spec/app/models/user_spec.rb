require 'spec_helper'

describe User do
  context 'when is created' do
    it 'should be invalid when name is missing' do
      expect { described_class.new(nil) }.to raise_error(InvalidUser, 'name is missing')
    end

    it 'should be invalid when name is blank' do
      expect { described_class.new('') }.to raise_error(InvalidUser, 'name is missing')
    end
  end

  context 'when is changed' do
    let(:user) { described_class.new({name: 'John'}) }

    it 'should be invalid when name is missing' do
      expect { user.replace_name_with(nil) }.to raise_error(InvalidUser, 'name is missing')
    end

    it 'should be invalid when name is blank' do
      expect { user.replace_name_with('') }.to raise_error(InvalidUser, 'name is missing')
    end

    it 'should change name' do
      user.replace_name_with('Paul')
      expect(user.name).to eq('Paul')
    end
  end
end
