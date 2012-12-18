class Pion
  
  def initialize(is_white, is_dame, line, column)
  @p_is_white = is_white
  @p_is_dame = is_dame
  @p_line = line
  @p_column = column
  end
  
  def test
    print @p_line
    print @p_column
  end
  
  attr_accessor :p_is_white
  attr_accessor :p_is_dame
  attr_accessor :p_line
  attr_accessor :p_column
  
end