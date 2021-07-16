require 'spec_helper'

describe 'UserCreator' do
  it 'should create save and notify observer' do
    name = 'john'
    user = instance_double(User)
    repo = instance_double(Persistence::Repositories::UserRepository)
    observer = double('observer')
    expect(User).to receive(:new).with(name).and_return(user)
    expect(repo).to receive(:save).with(user).and_return(user)
    expect(observer).to receive(:notify)
    UserCreator.new(repo, observer).create_user('john')
  end
end
