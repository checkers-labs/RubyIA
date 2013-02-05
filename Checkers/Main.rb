load 'Board_Manager.rb'

test = Board_Manager.new(Board.new)

test.real_board.tab_piece[5][2] = Piece.new(false, false)
test.real_board.tab_piece[0][3] = nil
test.real_board.tab_piece[6][1] = Piece.new(true, true) # mettre en king pour plus de resultats
test.move(2, 5, 3, 4)
test.move(2, 1, 3, 0)
test.move(2, 3, 3, 2)
test.move(2, 7, 3, 6)

print test.number_of_moves(true)
test.display(false)
