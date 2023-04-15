class Player
  attr_reader :name, :player_mark, :selections

  @@marks = ["◯", "✕"]
  @@taken = []

  def initialize(name)
    @name = name
    @player_mark = @@marks.pop
    @selections = []
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
  
  private

  def self.reset_marks
      @@marks = ["◯", "✕"]
      @@taken = []
  end

end
