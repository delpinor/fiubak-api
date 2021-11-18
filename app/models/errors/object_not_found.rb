class ObjectNotFound < StandardError
  def initialize(model, id)
    @model = model
    @id = id
  end
end
