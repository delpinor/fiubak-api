require 'spec_helper'

describe Tag do
  it 'should be invalid when tag name is missing' do
    expect { described_class.new(nil) }.to raise_error(InvalidTag, 'tag name is missing')
  end

  it 'should be invalid when tag name is blank' do
    expect { described_class.new('') }.to raise_error(InvalidTag, 'tag name is missing')
  end
end
