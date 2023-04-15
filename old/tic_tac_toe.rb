#Leaving for posterity. Please check out current version at Tic-Tac-Toe/lib/

require 'pry-byebug'
class Player1

  def initialize 
    puts "Hello Player 1, what is your name?"
    @player = gets.chomp
  end

  def player
    @player
  end

  def self.player_choice
    @player_choice
  end

  def self.get_player_choice
    @player_choice = gets.chomp
    while @player_choice.to_i < 1 || @player_choice.to_i > 9
      puts "Invalid input"
      self.get_player_choice
    end
      @player_choice
  end

  def self.symbol
    @symbol = "✕"
  end


end


class Player2

  def initialize 
    puts "\nHello Player 2, what is your name?"   
    @player = gets.chomp 
  end

  def player
    @player
  end

  def self.player_choice
    @player_choice
  end

  def self.get_player_choice
    @player_choice = gets.chomp
    while @player_choice.to_i < 1 || @player_choice.to_i > 9
      puts "Invalid input"
      self.get_player_choice
    end
      @player_choice
  end

  def self.symbol
    @symbol = "◯"
  end

end


class Grid
  attr_accessor :player1_grid

  @@grid_array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  @@player1_grid = Array.new(0)
  @@player2_grid = Array.new(0)

    def initialize 
      @grid =  "
    ╭    ╮╭    ╮╭    ╮
    | 1  || 2  || 3  |
    ╰    ╯╰    ╯╰    ╯
    ╭    ╮╭    ╮╭    ╮
    | 4  || 5  || 6  |
    ╰    ╯╰    ╯╰    ╯
    ╭    ╮╭    ╮╭    ╮
    | 7  || 8  || 9  |
    ╰    ╯╰    ╯╰    ╯

    "
    @current = @grid
    end

    def display_grid 
      grid = @grid
      puts "\e[2J"
      puts @current
    end

    def update_grid(current_player)
      @current = @current.gsub(current_player.player_choice.to_s, current_player.symbol)
      if current_player == Player1
      @@player1_grid.push(current_player.player_choice.to_i)
      elsif current_player == Player2
      @@player2_grid.push(current_player.player_choice.to_i)
      end
    end
     def self.Player1_grid
        @@player1_grid
      end

      def self.Player2_grid
        @@player2_grid
      end

     def self.grid_array
      @@grid_array
    end

end



module WinningConditions
  @gameover = false

  def self.is_win(current_player)
    
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
 
  WinningConditions.is_draw
   
    if
        winning_conditions.each do
          |key, value|
          if (Grid.send("#{current_player}_grid")) & value == value ? true : false 
          @gameover = true
          return true
          break 
          end
        end
    end
  end

  def self.is_draw
    if ((Grid.Player1_grid | Grid.Player2_grid).sort == Grid.grid_array) ? true : false 
    @gameover = true
    puts "It's a draw!"
    return true
    end
  end

  def self.game_over
    @gameover
end
end

player1 = Player1.new #pass in name variable here
player2 = Player2.new #pass in name variable here

playing_grid = Grid.new 
playing_grid.display_grid
until WinningConditions.game_over == true
puts "Player 1 turn"
current_player = Player1
current_player.get_player_choice
playing_grid.update_grid(current_player)
playing_grid.display_grid
if WinningConditions.is_win(current_player) == true ? (puts "#{player1.player} wins!") : 0
end
if WinningConditions.game_over == false
puts "Player 2 turn"
current_player = Player2
current_player.get_player_choice
playing_grid.update_grid(current_player)
playing_grid.display_grid
if WinningConditions.is_win(current_player) == true ? (puts "#{player2.player} wins!") : 0 
end
end
end

