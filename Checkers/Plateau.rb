load 'Pion.rb'

class Plateau
  def initialize(tab_pion = [Pion.new(false, false, 1, 2), Pion.new(false, false, 1, 4), Pion.new(false, false, 1, 6), Pion.new(false, false, 1, 8), Pion.new(false, false, 2, 1), Pion.new(false, false, 2, 3), Pion.new(false, false, 2, 5), Pion.new(false, false, 2, 7), Pion.new(false, false, 3, 2), Pion.new(false, false, 3, 4), Pion.new(false, false, 3, 6), Pion.new(false, false, 3, 8), Pion.new(true, false, 6, 1), Pion.new(true, false, 6, 3), Pion.new(true, false, 6, 5), Pion.new(true, false, 6, 7), Pion.new(true, false, 7, 2), Pion.new(true, false, 7, 4), Pion.new(true, false, 7, 6), Pion.new(true, false, 7, 8), Pion.new(true, false, 8, 1), Pion.new(true, false, 8, 3), Pion.new(true, false, 8, 5), Pion.new(true, false, 8, 7)])
    @p_tab_pion = tab_pion
  end
  
  def move(old_line, old_column, new_line, new_column)
    @p_tab_pion.each{
      |pion|
      if pion.p_line == old_line and pion.p_column == old_column
        if old_line - new_line == 1.abs
          pion.p_line = new_line
          pion.p_column = new_column
        else
          pion.p_line = new_line
          pion.p_column = new_column
          
          $killed_pion_line = 0
          $killed_pion_column = 0
          
          if old_line > new_line
              $killed_pion_line = old_line - 1
          else
            $killed_pion_line = new_line - 1
          end
          
          if old_column > new_column
              $killed_pion_column = old_column - 1
          else
            $killed_pion_column = new_column - 1
          end
          
          @p_tab_pion.each{
            |killed_pion|
            if killed_pion.p_line == $killed_pion_line and killed_pion.p_column == $killed_pion_column
              @p_tab_pion.delete(killed_pion)
              break
            end
          }
        end
        break
      end
    }
    
  end
  
  def test
    @p_tab_pion[8].test
  end
  
  attr_accessor :p_tab_pion
  
end


