require 'spec_helper'

describe Task do
  let(:user) { User.new({name: 'John'}) }

  it 'should be invalid when title is missing' do
    expect { described_class.new(user, nil) }.to raise_error(InvalidTask, 'title is missing')
  end

  it 'should be invalid when title is blank' do
    expect { described_class.new(user, '') }.to raise_error(InvalidTask, 'title is missing')
  end

  it 'should be invalid when user is missing' do
    expect { described_class.new(nil, 'Clean room') }.to raise_error(InvalidTask, 'user is missing')
  end
end
