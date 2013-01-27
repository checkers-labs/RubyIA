load 'Checker.rb'
load 'Pion.rb'
load 'Plateau.rb'
load 'Tools.rb'

$i = 1

test = Plateau.new

test.p_tab_pion.each{
  |ligne|
  ligne.each{
    |pion|
    if pion == nil
      print 0
    elsif pion == Pion.new(false, false)
      print 1
    elsif pion == Pion.new(true, false)
      print 2
    end   
    
    print " "
  }
  print "\n"
}



=begin
arr = [[1, 2, 3],[4, nil, 6]]

print arr[1][1]

=begin
plateau = Plateau.new
$i = 1

tab = plateau.p_tab_pion

tab.each{
  |pion|
  print "Pion " 
  i++
  


=begin
plateau.test
plateau.move(3, 2, 4, 3)
plateau.test
checker = Checker.new("tati")
checker.id = "tato"
print checker.id
+ $i + ": is_white = "pion.p_is_white + " is_dame = " + pion.p_is_dame + " lighe = " + p_line + " column = " + p_column + "\n"
=end
