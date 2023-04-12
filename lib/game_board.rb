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