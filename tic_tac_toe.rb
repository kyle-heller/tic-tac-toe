
# Will need to make some sort of array that holds status of grid
# Also need to make player arrays that hold guesses
# Have win logic if win/lose
# Have draw logic if tie

#Let player choose play with friend or computer
#Have running score for best of three

require 'pry-byebug'
class Player1

  def initialize(player) 
    @player = player     
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

end


class Player2

  def initialize(player) 
    @player = player     
  end

  def self.player_choice
    @player_choice
  end

  def self.get_player_choice(gets)
    @player_choice = gets.chomp
  end

  
end


class Grid
  attr_accessor :player1_grid

  @grid_array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
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
      puts @current
    end

    def update_grid
      @current = @current.gsub(Player1.player_choice.to_s, "X")
      @@player1_grid.push(Player1.player_choice.to_i)
      end

     def self.player1_grid
        @@player1_grid
      end
end



module WinningConditions

  def self.is_win
    
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
    
    if
        winning_conditions.each do
          |key, value|
          if (Grid.player1_grid & value == value) ? true : false 
          return true
          break 
          end
        end
    end
  end
end

player1 = Player1.new(gets)

playing_grid = Grid.new 
playing_grid.display_grid
until 1 < 0
Player1.get_player_choice
playing_grid.update_grid
playing_grid.display_grid
if WinningConditions.is_win == true ? (puts "You win!") : (puts "You lose!")
end
end