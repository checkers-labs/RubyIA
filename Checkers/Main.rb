load 'Board_Manager.rb'

test = Board_Manager.new(Board.new)

test.calculation_board.tab_piece[5][2] = Piece.new(false, false)
test.calculation_board.tab_piece[0][3] = nil
test.calculation_board.tab_piece[6][1] = Piece.new(true, true) # mettre en king pour plus de resultats
test.move(2, 5, 3, 4)
test.move(2, 1, 3, 0)
test.move(2, 3, 3, 2)
test.move(2, 7, 3, 6)

test.display(false)

print test.number_of_moves()
test.play_selected_move(2)
test.display(false)

test.number_of_moves()
test.play_selected_move(0)
test.display(false)


plateau = Board_Manager.new(Board.new)


def next_best_shoot(plateau)

  moves = plateau.search_player_moves()

  print moves[0]!=false
  max=0
  coup=0
  moves.to_enum.with_index(1).each do |elem, i|
       if max<elem.count-1
        max= elem.count-1
        coup= i
      end    
    end      
    
    if max == 1 
     random_number= Random.new().rand(0..moves.length)
    end
    #plateau.play_selected_move(coup)  
    return moves[coup]
  
end

coup=next_best_shoot(plateau)
print coup


#plateau.display(false)

print "finit"
 
