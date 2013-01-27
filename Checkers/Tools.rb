load 'Pion.rb'

class Tools
  def Tools.create_first_board
    
  # Initializing the board.
  
    damier = Array.new
    for i in 0..7
      damier[i] = Array.new
      for j in 0..7
        if (i + j) % 2 == 1 # If it's not an empty case.
          if i < 3
            damier[i][j] = Pion.new(false, false)
          elsif i > 4
            damier[i][j] = Pion.new(true, false)
          else
            damier[i][j] = nil
          end
        else
            damier[i][j] = nil
        end
      end
    end
    
    return damier
  
  # End initializing the board.
    
    
    #return [[nil, Pion.new(false, false), nil, Pion.new(false, false), nil, Pion.new(false, false), nil, Pion.new(false, false)],[Pion.new(false, false), nil, Pion.new(false, false), nil, Pion.new(false, false), nil, Pion.new(false, false), nil],[nil, Pion.new(false, false), nil, Pion.new(false, false), nil, Pion.new(false, false), nil, Pion.new(false, false)],[nil, nil, nil, nil, nil,nil, nil, nil],[nil, nil, nil, nil, nil,nil, nil, nil],[Pion.new(true, false), nil, Pion.new(true, false), nil, Pion.new(true, false), nil, Pion.new(true, false), nil],[nil, Pion.new(true, false), nil, Pion.new(true, false), nil, Pion.new(true, false), nil, Pion.new(true, false)],[Pion.new(true, false), nil, Pion.new(true, false), nil, Pion.new(true, false), nil, Pion.new(true, false), nil]]
  end
end