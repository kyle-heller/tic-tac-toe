require_relative '../lib/game'
describe Game do

  before do
    # Disable output synchronization
    allow_any_instance_of(Object).to receive(:system).and_return(nil)
    allow_any_instance_of(Game).to receive(:logo).and_return(nil)

  end

  let(:gameboard) { instance_double("GameBoard") }
  let(:player) { instance_double("Player") }
  let(:game) { Game.new }

  describe '#winner?' do
    context 'when there is a winning condition' do
      it 'returns true' do
        allow(gameboard).to receive(:winning_conditions).and_return({
          arr1: [1, 2, 3]  
        })

        allow(player).to receive(:selections).and_return([1, 2, 3])

        expect(game.winner?(player)).to eq(true)
        expect(game.instance_variable_get(:@winner)).to eq(player)
        expect(game.instance_variable_get(:@game_won)).to eq(true)
      end
    end
    context 'when there isnt a winning condition' do
      it 'returns true' do
        allow(gameboard).to receive(:winning_conditions).and_return({
          arr1: [1, 2, 3]  
        })

        allow(player).to receive(:selections).and_return([1, 2, 4])

        expect(game.winner?(player)).to eq(false)
        expect(game.instance_variable_get(:@winner)).to eq(nil)
        expect(game.instance_variable_get(:@game_won)).to eq(false)
      end
    end
  end

  describe '#choose_opponent_type' do
    let(:gameboard) { instance_double("GameBoard") }
    let(:player) { instance_double("Player") }
    let(:game) { Game.new }


    context 'when mode is invalid' do

      before do
        allow_any_instance_of(described_class).to receive(:gets).and_return("3\n", "2\n")
      end

      it 'calls choose_opponent_type' do
        expect(game).to receive(:choose_opponent_type).at_least(:twice).and_call_original
        game.choose_opponent_type
      end

    end
    context 'when mode is 1' do

      before do
        allow_any_instance_of(described_class).to receive(:gets).and_return("1\n")
      end

      it 'changes the mode and player2 instance variables' do
        expect {
          game.choose_opponent_type
        }.to change { game.instance_variable_get(:@mode) }.from(nil).to(1)
          .and change { game.instance_variable_get(:@player2) }.from(nil).to(an_instance_of(Player))
      end
    end
    context 'when mode is 2' do

      before do
        allow_any_instance_of(described_class).to receive(:gets).and_return("2\n")
      end

      it 'returns true' do
        expect {
          game.choose_opponent_type
        }.to change { game.instance_variable_get(:@mode) }.from(nil).to(2)
          .and change { game.instance_variable_get(:@player2) }.from(nil).to(an_instance_of(Player))
      end
    end
  end

  describe '#make_player_move' do
    let(:gameboard) { instance_double("GameBoard") }
    let(:player) { instance_double("Player") }
    let(:game) { Game.new }
  
    before do
      game.instance_variable_set(:@gameboard, gameboard)
      allow(player).to receive(:player_mark).and_return('✕')
      allow(gameboard).to receive(:place_mark)
      allow(game).to receive(:game_over?).and_return(false)
    end

    context 'when mode = 1 and player.name = !Computer' do
      before do
        game.instance_variable_set(:@mode, 1) 
        allow(player).to receive(:name).and_return('!Computer')
        allow(player).to receive(:computer_move).and_return(3)
      end
      it 'sends #computer_move to player' do
        expect(player).to receive(:computer_move)
        game.make_player_move(player)
      end
      it 'sends #place_mark to gameboard' do
        expect(gameboard).to receive(:place_mark)
        game.make_player_move(player)
      end
    end
    context 'when mode = 1 and player.name = Kyle' do
      before do
        game.instance_variable_set(:@mode, 1) 
        allow(player).to receive(:name).and_return('Kyle')
        allow(player).to receive(:make_move).and_return(4)
      end
      it 'sends #make_move to player' do
        expect(player).to receive(:make_move)
        game.make_player_move(player)
      end
      it 'sends #place_mark to gameboard' do
        expect(gameboard).to receive(:place_mark)
        game.make_player_move(player)
      end
    end
    context 'when mode = 2 and player.name = Samantha' do
      before do
        game.instance_variable_set(:@mode, 2) 
        allow(player).to receive(:name).and_return('Samantha')
        allow(player).to receive(:make_move).and_return(5)
      end
      it 'sends #make_move to player' do
        expect(player).to receive(:make_move)
        game.make_player_move(player)
      end
      it 'sends #place_mark to gameboard' do
        expect(gameboard).to receive(:place_mark)
        game.make_player_move(player)
      end
    end
  end

  describe '#tie?' do
    context 'when total moves is 8 and @game_won is false' do
      it 'returns true' do
        game.instance_variable_set(:@game_won, false)
        expect(game.tie?(8)).to be true
      end
    end
    
    context 'when total moves is 8 and @game_won is true' do
      it 'returns false' do
        game.instance_variable_set(:@game_won, true)
        result = game.tie?(8)
        expect(result).to be false
      end
    end
    
    context 'when total moves is not 8' do
      it 'returns false' do
        game.instance_variable_set(:@game_won, false)
        result = game.tie?(5)
        expect(result).to be false
      end
    end
  end
  describe '#play_again?' do
    let(:game) { Game.new }
    before do
      allow(Game).to receive(:new).and_return(game)
      allow(game).to receive(:play)
    end
    context 'response yes' do
      it 'true when yes' do
        allow_any_instance_of(described_class).to receive(:gets).and_return("yes\n")
        expect(Game).to receive(:new)
        expect(subject.play_again?).to be true
        game.play_again?
      end
      it 'true when y' do
        allow_any_instance_of(described_class).to receive(:gets).and_return("yes\n")
        expect(Game).to receive(:new)
        expect(subject.play_again?).to be true
        game.play_again?
      end
    end
    context 'response no' do
      before do
        allow_any_instance_of(Kernel).to receive(:gets).and_return('no')
        allow(Kernel).to receive(:exit)
      end
      it 'exits when no' do
        expect(Kernel).to receive(:exit)
        expect(subject.play_again?).to be false
        game.play_again?
      end
      it 'exits when n' do
        expect(Kernel).to receive(:exit)
        expect(subject.play_again?).to be false
        game.play_again?
      end
    end
  end
end
  

