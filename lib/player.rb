class Player
  attr_reader :name, :player_mark, :selections

  @@marks = ['◯', '✕']
  @@taken = []

  def initialize(player_number, name = nil)
    @name = get_player_name(player_number, name)
    @player_mark = @@marks.pop
    @selections = []
  end

  def get_player_name(player_number, name = nil)
    while name == nil
      puts "#{player_number}, what is your name?"
      name = gets.chomp
      unless name =~ /^[a-zA-Z]+$/
        puts 'Invalid name, please enter a valid name:'
        name = nil
      end
    end
    @name = name
  end

  def make_move(player)
    puts "#{player.name}, make your selection:"
    selection = gets.chomp
    if /[0-9]/.match(selection) && (@@taken.include?(selection.to_i) == false)
      @selections << selection.to_i
      @@taken << selection.to_i
      selection
    else
      print 'Please choose again. '
      make_move(player)
    end
  end

  def computer_move(_player)
    selection = ([1, 2, 3, 4, 5, 6, 7, 8] - @@taken).sample.to_s
    @selections << selection.to_i
    @@taken << selection.to_i
    puts selection
    selection
  end

  def self.reset_marks
    @@marks = ['◯', '✕']
    @@taken = []
  end
end
