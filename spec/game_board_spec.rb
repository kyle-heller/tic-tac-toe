require_relative '../lib/game_board.rb'

describe GameBoard do
subject(:board) { described_class.new }

  describe '#place_mark' do
    context 'when selection is 1' do
      it  'doesnt include 1' do
        board.place_mark("1", "X")
        expect(board.gameboard).not_to include("1")
      end
    end

    context 'when selection is 2' do
      it 'doesnt include 1' do
        board.place_mark("2", "X")
        expect(board.gameboard).not_to include("2")
      end
    end

    context 'when selection is 3' do
      it 'doesnt include 3' do
        board.place_mark("3", "X")
        expect(board.gameboard).not_to include("3")
      end
    end

  end
end

