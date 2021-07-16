class UserCreator
  def initialize(user_repo, observer)
    @repo = user_repo
    @observer = observer
  end

  def create_user(name)
    user = User.new(name)
    user = @repo.save(user)
    @observer.notify(self)
    user
  end
end
