class GameBoard
  attr_reader :gameboard, :winning_conditions

  DEFAULT_BOARD = "  
    ╭─────┬─────┬─────╮
    │  1  │  2  │  3  │
    ├─────┼─────┼─────┤
    │  4  │  5  │  6  │
    ├─────┼─────┼─────┤
    │  7  │  8  │  9  │
    ╰─────┴─────┴─────╯".freeze

    WINNING_CONDITIONS = {
      arr1: [1, 2, 3],
      arr2: [4, 5, 6],
      arr3: [7, 8, 9],
      arr4: [1, 4, 7],
      arr5: [2, 5, 8],
      arr6: [3, 6, 9],
      arr7: [1, 5, 9],
      arr8: [3, 5, 7]
    }.freeze

  def initialize
    @gameboard = DEFAULT_BOARD.dup
    @winning_conditions = WINNING_CONDITIONS
  end

  def display
    puts @gameboard
  end

  def place_mark(selection, mark)
    @gameboard.sub!(selection, mark)
  end

end