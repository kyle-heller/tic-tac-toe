
require 'pry-byebug'

class GameBoard
  attr_accessor :gameboard
  DEFAULT_BOARD = "  
    ╭─────┬─────┬─────╮
    │  1  │  2  │  3  │
    ├─────┼─────┼─────┤
    │  4  │  5  │  6  │
    ├─────┼─────┼─────┤
    │  7  │  8  │  9  │
    ╰─────┴─────┴─────╯"

  def initialize
    @gameboard = DEFAULT_BOARD
  end

  def display
    puts @gameboard
  end

  def place_mark(selection, mark)
    @gameboard.sub!(selection, mark)
  end
end

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

class Game
  attr_accessor :player1, :player2, :winner, :tie

  def initialize
    puts "Player 1, what is your name?"
    name = ''
    loop do
      name = gets.chomp
      break if name =~ /^[a-zA-Z]+$/
      puts "Invalid name, please enter a valid name:"
    end
    @player1 = Player.new(name)
    puts "Player 2, what is your name?"
    name = ''
    loop do
      name = gets.chomp
      break if name =~ /^[a-zA-Z]+$/
      puts "Invalid name, please enter a valid name:"
    end
    @player2 = Player.new(name)
    Player.reset_marks
    @winner = false
    @gameboard = GameBoard.new
    @gameboard.display
    play
  end 

  def play
    total_moves = 0
    loop do
      selection = player1.make_move(player1)
      @gameboard.place_mark(selection, player1.player_mark)
      @gameboard.display
      total_moves += 1
      break if game_over?(total_moves)
      selection = player2.make_move(player2)
      @gameboard.place_mark(selection, player2.player_mark)
      @gameboard.display
      total_moves += 1
      break if game_over?(total_moves)
    end
  end

  def game_over?(total_moves)
    if winner?(player1) || winner?(player2)
      puts "You win!"
      return true
    elsif tie?(total_moves)
      puts "It's a tie!"
      return true
    end
    false
  end


  def winner?(player)

    winning_conditions = {
      :arr1 => [1, 2, 3],
      :arr2 => [4, 5, 6],
      :arr3 => [7, 8, 9],
      :arr4 => [1, 4, 7],
      :arr5 => [2, 5, 8],
      :arr6 => [3, 6, 9],
      :arr7 => [1, 5, 9],
      :arr8 => [3, 5, 7]
    }
   
    winning_conditions.each do |key, value|
      if 
        player.selections & value == value
        @winner = true
        return true
      end
    end
    false
  end

  def tie?(total_moves)
    total_moves == 9 && !@winner
  end


end

Game.new

