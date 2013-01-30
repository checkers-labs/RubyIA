=begin
Problemes : 
test.move(2, 1, 3, 3)
=end
  
load 'Pion.rb'
load 'Tools.rb'

class Plateau
  def initialize(tab_pion = Tools.create_first_board)
    @p_tab_pion = tab_pion
  end 
  
  attr_accessor :p_tab_pion
  
  # Moves a piece.
  def move(xOrig, yOrig, xDest, yDest)
    if is_possible_move(xOrig, yOrig, xDest, yDest) == true
      xDist = (xDest - xOrig).abs
      yDist = (yDest - yOrig).abs
      
      if xDist == 2 && yDist == 2 # If the move imply to eat a piece.  
        @p_tab_pion[(xOrig + xDest) / 2][(yOrig + yDest) / 2] = 0
      end 
      
      @p_tab_pion[xDest][yDest] = @p_tab_pion[xOrig][yOrig]
      @p_tab_pion[xOrig][yOrig] = nil
    end
  end
  # End of moving a piece.
  
  
  
  # Check if a move is allowed.
  def is_possible_move(xOrig, yOrig, xDest, yDest)
    if @p_tab_pion[xOrig][yOrig] == nil # We check that there is a piece to move.      print "c\n"
      return false
    end
    
    xDist = (xDest - xOrig).abs
    yDist = (yDest - yOrig).abs
    
    if xOrig < 0 || xOrig > 7 || yOrig < 0 || yOrig > 7 # The piece should be into the board.      print "a\n"
      return false
    end
    
    if xDest < 0 || xDest > 7 || yDest < 0 || yDest > 7 # The piece should not go out of the board.      print "b\n"
      return false
    end
    
    if (xDist != 1 && xDist != 2) || (yDist != 1 && yDist != 2) # We check if the move is authorized.
      return false
    end
    
    if !@p_tab_pion[xDest][yDest] == nil # We check that the destination case is free.      print "e\n"
      return false
    end
    
    if xDist == 2 && yDist == 2 # If the move implied to eat another.    
      moved_piece = @p_tab_pion[xOrig][yOrig]
      skipped_piece = @p_tab_pion[(xOrig + xDest) / 2][(yOrig + yDest) / 2]
      
      if skipped_piece == nil # We forbid the player to jump over an empty case.
        return false
      end
      
      if skipped_piece.p_is_white == moved_piece.p_is_white # We forbid the player to eat his own pieces.
        return false
      end
    end
    
    # At this point, the move is totally allowed.
    
    return true
    
  end
  # End checking if a move is allowed.

  
  
  # List all the possible moves for a piece.
  def search_moves_list(xOrig, yOrig)
    if @p_tab_pion[xOrig][yOrig] == nil
      print "Empty case"
      return nil
    end
      
    moves_list = Array.new
    
    for x in [-2, -1, 1, 2] # Only those cases can be reached.
      for y in [-2, -1, 1, 2]
        if @p_tab_pion[xOrig][yOrig].p_is_white && x > 0 # The white pieces must just go top.
          next
        end
        
        if !@p_tab_pion[xOrig][yOrig].p_is_white && x < 0 # The black pieces must just go down.
          next
        end
        
        if x.abs != y.abs # We just check the diagonals.
          next
        end
        
        if is_possible_move(xOrig, yOrig, xOrig + x, yOrig + y) == true
          print xOrig + x, " ", yOrig + y, ";" # A virer.
          move = [xOrig + x, yOrig + y]
          moves_list << move
        end
        
        y += 2 # One case out of 2 is empty.
      end
      
      x += 2 # One case out of 2 is empty.
    end
    
    return moves_list
  end
  # End of the listing of all the possible moves for a piece.
  
end