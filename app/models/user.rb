class User
  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
    raise InvalidUser.new('name is missing') if attributes[:name] == ''
  end

  def [](name)
    attributes[name]
  end

  def id
    @attributes[:id]
  end
end
