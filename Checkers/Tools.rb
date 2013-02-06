load 'Piece.rb'

class Tools
  def Tools.create_first_board
    
  # Initializing the board.
  
    damier = Array.new
    for i in 0..7
      damier[i] = Array.new
      for j in 0..7
        if (i + j) % 2 == 1 # If it's not an empty case.
          if i < 3
            damier[i][j] = Piece.new(false, false)
          elsif i > 4
            damier[i][j] = Piece.new(true, false)
          else
            damier[i][j] = nil
          end
        else
            damier[i][j] = nil
        end
      end
    end
    
    return damier
    
  end
  
  
  
  # Display a board.
  def Tools.display(tab)
    print "\n"
    
    tab.each{
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
  
end