class Player
  attr_accessor :name, :player_mark, :selections
  @@marks = ["◯", "✕"]
  def initialize(name)
    @name = name
    @player_mark = @@marks.pop
    @selections = []
    @@taken = []
  end

  def self.reset_marks
      @@marks = ["◯", "✕"]
  end

  def make_move(player)
    puts "#{player.name}, make your selection:"
    selection = gets.chomp
    if /[0-9]/.match(selection) && (@@taken.include?(selection.to_i) == false)
      @selections << selection.to_i
      @@taken << selection.to_i
      selection
    else 
      print "Please choose again. "
      make_move(player)
    end
  end
end