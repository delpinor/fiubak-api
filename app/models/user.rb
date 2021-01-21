class User
  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
    raise InvalidUser, 'name is missing' if name_is_empty?
  end

  def [](name)
    attributes[name]
  end

  def id
    @attributes[:id]
  end

  private

  def name_is_empty?
    (@attributes[:name].nil? || @attributes[:name] == '')
  end
end
