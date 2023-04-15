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
                                                                 

    ████████╗██╗ ██████╗    ████████╗ █████╗  ██████╗    ████████╗ ██████╗ ███████╗
    ╚══██╔══╝██║██╔════╝    ╚══██╔══╝██╔══██╗██╔════╝    ╚══██╔══╝██╔═══██╗██╔════╝
       ██║   ██║██║            ██║   ███████║██║            ██║   ██║   ██║█████╗
       ██║   ██║██║            ██║   ██╔══██║██║            ██║   ██║   ██║██╔══╝
       ██║   ██║╚██████╗       ██║   ██║  ██║╚██████╗       ██║   ╚██████╔╝███████╗
       ╚═╝   ╚═╝ ╚═════╝       ╚═╝   ╚═╝  ╚═╝ ╚═════╝       ╚═╝    ╚═════╝ ╚══════╝
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
    system("clear") || system("cls")
    logo
    @gameboard.display
    total_moves += 1
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
        @winner = player
        @game_won = true
        return true
      end
    end
    false
  end

  def tie?(total_moves)
    total_moves == 9 && !@game_won
  end


end