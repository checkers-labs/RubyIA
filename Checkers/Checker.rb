class Checker
  def initialize(id = "toto")
  @id = id
  end
  def move
    print @id
  end
  attr_accessor :id
end
