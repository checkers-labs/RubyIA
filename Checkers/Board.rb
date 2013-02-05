load 'Piece.rb'
load 'Tools.rb'

class Board
  def initialize(tab_piece = Tools.create_first_board, w_is_playing = false)
    @tab_piece = tab_piece
    @white_is_playing = w_is_playing
  end 
  
  attr_accessor :tab_piece
  attr_accessor :white_is_playing
end