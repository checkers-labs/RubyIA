load 'Piece.rb'
load 'Tools.rb'
load 'Board.rb'

class Core 
  
  def initialize(board)
    @board = board
  end
  
  attr_accessor :board
  attr_accessor :p_moves_list
  attr_accessor :p_must_eat
  
  
  def display()
    print "\n"
    @board.tab_piece.each{
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
  
  # Moves a piece.
  def move(xOrig, yOrig, xDest, yDest)
    if is_possible_move(xOrig, yOrig, xDest, yDest) == true
      xDist = (xDest - xOrig).abs
      yDist = (yDest - yOrig).abs
      
      if xDist == 2 && yDist == 2 # If the move imply to eat a piece.  
        @board.tab_piece[(xOrig + xDest) / 2][(yOrig + yDest) / 2] = nil
      end 
      
      @board.tab_piece[xDest][yDest] = board.tab_piece[xOrig][yOrig]
      @board.tab_piece[xOrig][yOrig] = nil
    end
  end
  # End of moving a piece.


# Check if a move is allowed.
  def is_possible_move(xOrig, yOrig, xDest, yDest)
    if @board.tab_piece[xOrig][yOrig] == nil # We check that there is a piece to move.
      print "No piece to move"
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
    
    if !@board.tab_piece[xOrig][yOrig].p_is_king # We check that the piece is going the right way.
      if @board.tab_piece[xOrig][yOrig].p_is_white && xDest > xOrig # White pieces must go top.       
        return false
      end
      
      if !@board.tab_piece[xOrig][yOrig].p_is_white && xDest < xOrig # Black pieces must go down.
        print "Error b\n"
        return false
      end
    end
        
    if dist % 2 != 0 || dist > 4 # We check if the move is authorized.
      return false
    end
    
    if @board.tab_piece[xDest][yDest] != nil # We check that the destination case is free.
      return false
    end
    
    if dist == 4 # If the move implied to eat another.    
      moved_piece = @board.tab_piece[xOrig][yOrig]
      skipped_piece = @board.tab_piece[(xOrig + xDest) / 2][(yOrig + yDest) / 2]
      
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
  # End checking if a move is allowed.
  
  def number_of_move()
    @tab_moves = search_player_moves(board.white_is_playing)
    @number_moves = @tab_moves.size
    return @number_moves
  end

  
  
# List all the possible moves for a piece.
  def search_piece_moves(xOrig, yOrig, recursivity_level)
    
    if @board.tab_piece[xOrig][yOrig] == nil
      print "Empty case"
      return nil
    end
      
    move = nil
    
    for x in [-2, -1, 1, 2] # Only those cases can be reached.
      for y in [-2, -1, 1, 2]
        if !@board.tab_piece[xOrig][yOrig].p_is_king
          if @board.tab_piece[xOrig][yOrig].p_is_white && x > 0 # The white pieces must just go top.
            next
          end
          
          if !@board.tab_piece[xOrig][yOrig].p_is_white && x < 0 # The black pieces must just go down.
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
            source = @board.tab_piece[xOrig][yOrig]
            captured = @board.tab_piece[(xOrig + xOrig + x) / 2][(yOrig + yOrig + y) / 2]
            self.move(xOrig, yOrig, xOrig + x, yOrig + y)
            
            # Recursivity
            self.search_piece_moves(xOrig + x, yOrig + y, 2)
            recursivity_level -= 1
            
            # We rollback the move (can't use the "move" method cause standard pieces can't move backward).
            @board.tab_piece[xOrig][yOrig] = source
            @board.tab_piece[(xOrig + xOrig + x) / 2][(yOrig + yOrig + y) / 2] = captured
            @board.tab_piece[xOrig + x][yOrig + y] = nil
          end
          
          if !@p_must_eat && recursivity_level <= 0
            move = [xOrig + x, yOrig + y]
            @p_moves_list << move
          end
        end
        
        y += 2 # One case out of 2 is empty.
      end
      
      x += 2 # One case out of 2 is empty.
    end
    
    if recursivity_level >= 2 && move == nil
      move = [xOrig, yOrig]
      @p_moves_list << move
    end
  end
  # End of the listing of all the possible moves for a piece.
  
  # List all the possible moves for a player.
  def search_player_moves(is_white_player)
 
    @p_must_eat = false
    @p_moves_list = Array.new
    
    for i in 0..7
      for j in 0..7
        if @board.tab_piece[i][j] == nil
          next
        end
        
        if @board.tab_piece[i][j].p_is_white == is_white_player
          self.search_piece_moves(i, j, 0)
        end
      end
    end
    
    @p_moves_list.each{
      |coup|
      print coup
    }
    
    return @p_moves_list
  end
  # End listing of all the possible moves for a player.
  
  
end