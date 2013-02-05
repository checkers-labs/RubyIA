load 'Board_Manager.rb'

test = Board_Manager.new(Board.new)

test.calculation_board.tab_piece[5][2] = Piece.new(false, false)
test.calculation_board.tab_piece[0][3] = nil
test.calculation_board.tab_piece[6][1] = Piece.new(true, false) # mettre en king pour plus de resultats
test.move(2, 5, 3, 4)
test.move(2, 1, 3, 0)
test.move(2, 3, 3, 2)
test.move(2, 7, 3, 6)

Tools.display(test.calculation_board.tab_piece)

print test.number_of_moves()
test.play_selected_move(2)
Tools.display(test.calculation_board.tab_piece)

test.number_of_moves()
test.play_selected_move(0)
Tools.display(test.calculation_board.tab_piece)