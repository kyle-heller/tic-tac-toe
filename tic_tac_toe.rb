class Player1

  def initialize(player) 
    @player = player     
  end

  def self.get_player_guess
    @player_guess = gets.chomp
  end

end


class Player2
  attr_accessor :player_guess

  def initialize(player) 
    @player = player     
  end

  def self.get_player_guess
    @player_guess = gets.chomp
  end
  
end


class Grid

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
    end

    def display_grid 
      grid = @grid
      if @current_grid == nil
        puts @grid
      else  
        puts @current_grid
      end
    end

    def update_grid
      @grid = @grid.gsub(Player1.get_player_guess.to_s, "X")
    end

end


player1 = Player1.new(gets)

playing_grid = Grid.new 
playing_grid.display_grid
until 1 < 0
playing_grid.update_grid
playing_grid.display_grid
end