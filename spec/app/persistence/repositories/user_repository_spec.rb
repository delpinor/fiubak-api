require 'integration_helper'

describe Persistence::Repositories::UserRepository do
  let(:user_repo) { Persistence::Repositories::UserRepository.new }
  let(:a_user) { User.new('John') }

  it 'should save a new user' do
    user_repo.save(a_user)
    expect(user_repo.all.count).to eq(1)
  end

  it 'should assign an id to a new user' do
    new_user = user_repo.save(a_user)
    expect(new_user.id).to be_present
  end

  context 'when a user exists' do
    before :each do
      @new_user = user_repo.save(a_user)
      @user_id = @new_user.id
    end

    it 'should update a user name' do
      @new_user.replace_name_with 'Paul'

      user_repo.save(@new_user)

      expect(user_repo.find(@user_id).name).to eq('Paul')
    end

    it 'should not create a new user' do
      @new_user.replace_name_with 'Paul'

      user_repo.save(@new_user)

      expect(user_repo.all.count).to eq(1)
    end

    it 'should delete the user' do
      user_repo.delete(@new_user)

      expect(user_repo.all.count).to eq(0)
    end

    it 'should delete all users' do
      user_repo.delete_all

      expect(user_repo.all.count).to eq(0)
    end

    it 'should find the user by id' do
      user = user_repo.find(@user_id)

      expect(user.name).to eq(@new_user.name)
    end
  end

  it 'should raise an error when attempts to find a non-existing user' do
    expect do
      user_repo.find(99_999)
    end.to raise_error(UserNotFound)
  end
end
