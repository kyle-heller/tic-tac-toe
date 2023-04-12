require_relative 'game_board'
require_relative 'player'

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