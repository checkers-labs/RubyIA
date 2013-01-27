class Pion
  
  def initialize(is_white, is_dame)
  @p_is_white = is_white
  @p_is_dame = is_dame
  end
  
  def test
    print @p_line
    print @p_column
  end
  
  def ==(another_pion)
    is_the_same = false
    if another_pion != nil
      if self.p_is_white == another_pion.p_is_white and self.p_is_dame == another_pion.p_is_dame
        is_the_same = true
      end
    end
    
    return is_the_same
    
  end
  
  attr_accessor :p_is_white
  attr_accessor :p_is_dame
  
end