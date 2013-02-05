class Piece
  
  def initialize(is_white, is_king)
  @p_is_white = is_white
  @p_is_king = is_king
  end
  
  def test
    print @p_line
    print @p_column
  end
  
  def ==(another_piece)
    is_the_same = false
    if another_piece != nil
      if self.p_is_white == another_piece.p_is_white and self.p_is_king == another_piece.p_is_king
        is_the_same = true
      end
    end
    
    return is_the_same
    
  end
  
  attr_accessor :p_is_white
  attr_accessor :p_is_king
  
end