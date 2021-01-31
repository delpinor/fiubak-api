class User
  attr_reader :name
  attr_accessor :id

  def initialize(name, id = nil)
    @name = name
    @id = id
    validate_user!
  end

  def replace_name_with(new_name)
    @name = new_name
    validate_user!
  end

  private

  def validate_user!
    raise InvalidUser, 'name is missing' if name_is_empty?
  end

  def name_is_empty?
    (@name.nil? || @name == '')
  end
end
