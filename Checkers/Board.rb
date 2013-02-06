load 'Piece.rb'
load 'Tools.rb'

class Board
  def initialize(tab_piece = Tools.create_first_board, w_is_playing = true)
    @tab_piece = tab_piece
    @white_is_playing = w_is_playing
  end 
  
  attr_accessor :tab_piece
  attr_accessor :white_is_playing
  
  def copy(other_board)
    @white_is_playing = other_board.white_is_playing
    
    @tab_piece.clear()
    @tab_piece = Array.new
    for i in 0..7
      @tab_piece[i] = Array.new
      for j in 0..7
        @tab_piece[i][j] = other_board.tab_piece[i][j]
      end
    end
  end
  
end