load 'Piece.rb'
load 'Tools.rb'
load 'Board.rb'

class Board_Manager 
  
  def initialize(board)
    @real_board = board
    @calculation_board = Board.new
    @calculation_board.copy(@real_board)
  end
  
  attr_accessor :real_board
  attr_accessor :calculation_board
  attr_accessor :p_moves_list
  attr_accessor :p_must_eat
  
  
  
  # Display a board.
  def display(is_real_board = true)
    selected_board = @real_board
    
    if is_real_board == false
      selected_board = @calculation_board
    end
    
    print "\n"
    selected_board.tab_piece.each{
      |ligne|
      ligne.each{
        |piece|
        if piece == nil
          print 0
        elsif piece == Piece.new(false, false)
          print 1
        elsif piece == Piece.new(true, false)
          print 2
        elsif piece == Piece.new(false, true)
          print 3
        elsif piece == Piece.new(true, true)
          print 4
        end   
        
        print " "
      }
      print "\n"
    }
  end
  
  
  
  # Moves a piece on the real board.
  def move_real(xOrig, yOrig, xDest, yDest)
    
    if is_possible_move(xOrig, yOrig, xDest, yDest) == true
      xDist = (xDest - xOrig).abs
      yDist = (yDest - yOrig).abs
      
      if xDist == 2 && yDist == 2 # If the move imply to eat a piece.  
        @real_board.tab_piece[(xOrig + xDest) / 2][(yOrig + yDest) / 2] = nil
      end 
      
      @real_board.tab_piece[xDest][yDest] = @real_board.tab_piece[xOrig][yOrig]
      @real_board.tab_piece[xOrig][yOrig] = nil
         
      if @real_board.tab_piece[xDest][yDest].p_is_king == false # We may simplify this condition.
        if (xDest == 0 && @real_board.tab_piece[xDest][yDest].p_is_white) || (xDest == 7 && !@real_board.tab_piece[xDest][yDest].p_is_white) # Crown a piece.
          @real_board.tab_piece[xDest][yDest].p_is_king = true
        end
      end

      @calculation_board.copy(@real_board)
    end
    
  end
  
  
  
  # Moves a piece.
  def move(xOrig, yOrig, xDest, yDest)
    
    if is_possible_move(xOrig, yOrig, xDest, yDest) == true
      xDist = (xDest - xOrig).abs
      yDist = (yDest - yOrig).abs
      
      if xDist == 2 && yDist == 2 # If the move imply to eat a piece.  
        @calculation_board.tab_piece[(xOrig + xDest) / 2][(yOrig + yDest) / 2] = nil
      end 
      
      @calculation_board.tab_piece[xDest][yDest] = @calculation_board.tab_piece[xOrig][yOrig]
      @calculation_board.tab_piece[xOrig][yOrig] = nil
          
      if @calculation_board.tab_piece[xDest][yDest].p_is_king == false # We may simplify this condition.
        if (xDest == 0 && @calculation_board.tab_piece[xDest][yDest].p_is_white) || (xDest == 7 && !@calculation_board.tab_piece[xDest][yDest].p_is_white) # Crown a piece.
          @calculation_board.tab_piece[xDest][yDest].p_is_king = true
        end
      end
    end
  end
  
  
  
  # Moves a piece for the recursivity search.
  def recursive_move(xOrig, yOrig, xDest, yDest)
    @calculation_board.tab_piece[(xOrig + xDest) / 2][(yOrig + yDest) / 2] = nil
    @calculation_board.tab_piece[xDest][yDest] = @calculation_board.tab_piece[xOrig][yOrig]
    @calculation_board.tab_piece[xOrig][yOrig] = nil
  end



  # Check if a move is allowed.
  def is_possible_move(xOrig, yOrig, xDest, yDest)
    if @calculation_board.tab_piece[xOrig][yOrig] == nil # We check that there is a piece to move.
      return false
    end
    
    xDist = (xDest - xOrig).abs
    yDist = (yDest - yOrig).abs
    dist = xDist + yDist
    
    if xOrig < 0 || xOrig > 7 || yOrig < 0 || yOrig > 7 # The piece should be into the board.
      return false
    end
    
    if xDest < 0 || xDest > 7 || yDest < 0 || yDest > 7 # The piece should not go out of the board.
      return false
    end
    
    if !@calculation_board.tab_piece[xOrig][yOrig].p_is_king # We check that the piece is going the right way.
      if @calculation_board.tab_piece[xOrig][yOrig].p_is_white && xDest > xOrig # White pieces must go top.       
        return false
      end
      
      if !@calculation_board.tab_piece[xOrig][yOrig].p_is_white && xDest < xOrig # Black pieces must go down.
        return false
      end
    end
        
    if dist % 2 != 0 || dist > 4 # We check if the move is authorized.
      return false
    end
    
    if @calculation_board.tab_piece[xDest][yDest] != nil # We check that the destination case is free.
      return false
    end
    
    if dist == 4 # If the move implied to eat another.    
      moved_piece = @calculation_board.tab_piece[xOrig][yOrig]
      skipped_piece = @calculation_board.tab_piece[(xOrig + xDest) / 2][(yOrig + yDest) / 2]
      
      if skipped_piece == nil # We forbid the player to jump over an empty case.
        return false
      end
      
      if (skipped_piece.p_is_white == true && moved_piece.p_is_white == true) || (skipped_piece.p_is_white == false && moved_piece.p_is_white == false) # We forbid the player to eat his own pieces.
        return false
      end
    end
    
    # At this point, the move is totally allowed.
    
    return true
    
  end


  
  # Return the number of moves.
  def number_of_moves()
    return search_player_moves().length
  end

  
  
  # List all the possible moves for a piece.
  def search_piece_moves(xOrig, yOrig, recursivity_level, moves_chain_param)
    
    if @calculation_board.tab_piece[xOrig][yOrig] == nil
      return nil
    end
      
    move = nil
    
    moves_chain = moves_chain_param.dup
    moves_chain << [xOrig, yOrig]
    
    for x in [-2, -1, 1, 2] # Only those cases can be reached.
      for y in [-2, -1, 1, 2]
        if !@calculation_board.tab_piece[xOrig][yOrig].p_is_king
          if @calculation_board.tab_piece[xOrig][yOrig].p_is_white && x > 0 # The white pieces must just go top.
            next
          end
          
          if !@calculation_board.tab_piece[xOrig][yOrig].p_is_white && x < 0 # The black pieces must just go down.
            next
          end
        end
        
        if x.abs != y.abs # We just check the diagonals.
          next
        end
        
        if is_possible_move(xOrig, yOrig, xOrig + x, yOrig + y)
          if x.abs + y.abs == 4 && !@p_must_eat # If the move is authorized and we eat a piece.
            @p_must_eat = true
            @p_moves_list.clear
          end
          
          if x.abs + y.abs == 4 # Chain capturing
            # We make a temporary move.
            source = @calculation_board.tab_piece[xOrig][yOrig]
            captured = @calculation_board.tab_piece[(xOrig + xOrig + x) / 2][(yOrig + yOrig + y) / 2]
            self.recursive_move(xOrig, yOrig, xOrig + x, yOrig + y)
            
            # Recursivity
            self.search_piece_moves(xOrig + x, yOrig + y, 2, moves_chain)
            recursivity_level -= 1
            
            # We rollback the move (can't use the "move" method cause standard pieces can't move backward).
            @calculation_board.tab_piece[xOrig][yOrig] = source
            @calculation_board.tab_piece[(xOrig + xOrig + x) / 2][(yOrig + yOrig + y) / 2] = captured
            @calculation_board.tab_piece[xOrig + x][yOrig + y] = nil
          end
          
          if !@p_must_eat && recursivity_level <= 0 # A corriger ...
            move = [xOrig + x, yOrig + y]
            moves_chain << move
            @p_moves_list << moves_chain
          end
        end
        
        y += 2 # One case out of 2 is empty.
      end
      
      x += 2 # One case out of 2 is empty.
    end
    
    if recursivity_level >= 2 && move == nil # Record the move at the end of the capturing chain.
      move = [xOrig, yOrig]
      #moves_chain << move
      @p_moves_list << moves_chain
    end
  end


  
  # List all the possible moves for a player.
  def search_player_moves()
 
    @p_must_eat = false
    @p_moves_list = Array.new
    
    for i in 0..7
      for j in 0..7
        if @calculation_board.tab_piece[i][j] == nil
          next
        end
        
        if @calculation_board.tab_piece[i][j].p_is_white == @calculation_board.white_is_playing
          self.search_piece_moves(i, j, 0, Array.new)
        end
      end
    end
    
    # Display the results (for debug only)
    @p_moves_list.each{
      |coup|
      print coup
    }
    
    return @p_moves_list
  end  


  
  # Play the selected move from the previous moves list.
  def play_selected_move(id)
    for i in 1..@p_moves_list[id].length-1
      src = @p_moves_list[id][i-1]
      dest = @p_moves_list[id][i]
      self.move(src.x, src.y, dest.x, dest.y)
    end
    
    @calculation_board.white_is_playing = !@calculation_board.white_is_playing
    @p_moves_list.clear 
  end
  
end