require_relative 'game_board'
require_relative 'player'

class Game
  attr_reader :player1, :player2, :winner, :game_won, :tie

  def initialize
    clear_screen
    @player1 = Player.new(get_player_name("Player 1"))
    clear_screen
    @player2 = Player.new(get_player_name("Player 2"))
    clear_screen
    Player.reset_marks
    @game_won = false
    @gameboard = GameBoard.new
    play
  end 

  private

  def logo
    puts "
                                                                 

     _______ _        _______           _______         
    |__   __(_)      |__   __|         |__   __|        
       | |   _  ___     | | __ _  ___     | | ___   ___ 
       | |  | |/ __|    | |/ _  |/ __|    | |/ _ \\ / _  \\
       | |  | | (__     | | (_| | (__     | | (_) |  __/
       |_|  |_|\\___|    |_|\\____|\\___|    |_|\\___/ \\___|                                                            
   "    
  end

  def clear_screen
    system("clear") || system("cls")
    logo
  end

  def get_player_name(player_number)
    loop do
      puts "#{player_number}, what is your name?"
      name = gets.chomp
      return name if name =~ /^[a-zA-Z]+$/
      puts "Invalid name, please enter a valid name:"
    end
  end

  def make_player_move(player)
    total_moves = 0
    selection = player.make_move(player)
    @gameboard.place_mark(selection, player.player_mark)
    total_moves += 1
    system("clear") || system("cls")
    logo
    @gameboard.display
    game_over?(total_moves)
  end


def play
  @gameboard.display
  loop do
    break if make_player_move(player1)
    break if make_player_move(player2)
  end
end

  def game_over?(total_moves)
    if winner?(player1) || winner?(player2)
      puts "#{@winner.name} wins!"
      play_again?
      return true
    elsif tie?(total_moves)
      puts "It's a tie!"
      play_again?
      return true
    end
    false
  end

  def play_again?
    puts "Play again? (yes/no)"
    response = gets.chomp.downcase
    if response == "yes" || response == "y"
      Game.new
      return true
    else
      exit
    end
  end

  def winner?(player)

    @gameboard.winning_conditions.each do |key, value|
      if 
        value & player.selections == value
        @winner = player
        @game_won = true
        return true
      end
    end
    false
  end

  def tie?(total_moves)
    total_moves == 8 && !@game_won
  end


end