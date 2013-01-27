load 'Pion.rb'
load 'Tools.rb'

class Plateau
  def initialize(tab_pion = Tools.create_first_board)
    @p_tab_pion = tab_pion
  end 

  def looking_for_possibilities

  end
  
  attr_accessor :p_tab_pion
  
  private
  
  def is_possible_move(xOrig, yOrig, xDest, yDest)
    xDist = (xDest - xOrig).abs
    yDist = (yDest - yOrig).abs
    
    if xOrig < 0 || xOrig > 7 || yOrig < 0 || yOrig > 7 # The piece should be into the board.
      return false
    end
    
    if xDest < 0 || xDest > 7 || yDest < 0 || yDest > 7 # The piece should not go out of the board.
      return false
    end
    
    if $damier[xOrig][yOrig] == 0 # We check that there is a piece to move.
      return false
    end
    
    if (xDist != 1 && xDist != 2) || (yDist != 1 && yDist != 2) # We check if the move is authorized.
      return false
    end
    
    if $damier[xDest][yDest] != 0 # We check that the destination case is free.
      return false
    end
    
    if xDist == 2 && yDist == 2 # If the move implied to eat another.    
    moved_piece = $damier[xOrig][yOrig]
    skipped_piece = $damier[(xOrig + xDest) / 2][(yOrig + yDest) / 2]
    
    if skipped_piece == 0 # We forbid the player to jump over an empty case.
      return false
    end
    
    if (skipped_piece + moved_piece) % 2 == 0 # We forbid the player to eat his own pieces.
      return false
    end
    
    # At this point, the move is totally allowed.
    return true
    
  end
  
end


