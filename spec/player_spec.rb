require_relative '../lib/player'

RSpec.configure do |config|
  config.after(:example) do
    Player.reset_marks
  end
end

describe Player do
  subject(:player) { Player.new('Player 1', 'Kyle') }
  describe '#get_player_name' do
    context 'while name is valid' do
      it 'returns name' do
        allow_any_instance_of(described_class).to receive(:gets).and_return('Kyle')
        name = player.get_player_name('Player 1')
        expect(name).to eq('Kyle')
      end
    end
    context 'invalid once and then valid' do
      it 'loops two times and returns the valid name' do
        allow_any_instance_of(Object).to receive(:puts)
        allow_any_instance_of(Object).to receive(:gets).and_return('Motörhead', 'Kyle')
        name = player.get_player_name('Player 1')
        expect(name).to eq('Kyle')
      end
    end
    context 'invalid twice and then valid' do
      it 'loops three times' do
        allow_any_instance_of(Object).to receive(:puts)
        allow_any_instance_of(Object).to receive(:gets).and_return('Motörhead', 'Motörhead2', 'Kyle')
        name = player.get_player_name('Player 1')
        expect(name).to eq('Kyle')
      end
    end
  end
  describe '#make_move' do
    context 'when valid' do
      it 'returns selection' do
        allow_any_instance_of(Object).to receive(:gets).and_return("1\n")
        selection = player.make_move(player)
        expect(selection).to eq('1')
      end
      it 'returns if selection does not contain taken' do
        allow_any_instance_of(Object).to receive(:gets).and_return("1\n")
        Player.class_variable_set(:@@taken, [2]) 
        selection = player.make_move(player)
        expect(selection)
      end
      it 'gets new selection if taken' do
        allow_any_instance_of(Object).to receive(:gets).and_return("1\n", "2\n")
        Player.class_variable_set(:@@taken, [1]) 
        selection = player.make_move(player)
        expect(selection)
      end
      it 'adds selection to selections' do
        allow_any_instance_of(Object).to receive(:gets).and_return("4\n")
        selection = player.make_move(player)
        expect(player.instance_variable_get(:@selections)).to eq([4])
      end
      it 'adds selection to taken' do
        allow_any_instance_of(Object).to receive(:gets).and_return("5\n")
        selection = player.make_move(player)
        expect(Player.class_variable_get(:@@taken)).to include(5)
      end
    end
    context 'invalid and then valid' do
      it 'calls make_move(player) again and returns selection' do
        allow_any_instance_of(Object).to receive(:gets).and_return("!\n", "1\n")
        expect(player).to receive(:make_move).at_least(:twice).and_call_original
        selection = player.make_move(player)
        expect(selection)
      end

      it 'returns if selection does not contain taken' do
        allow_any_instance_of(Object).to receive(:gets).and_return("!\n", "1\n")
        expect(player).to receive(:make_move).at_least(:twice).and_call_original
        Player.class_variable_set(:@@taken, [2]) 
        selection = player.make_move(player)
        expect(selection)
      end
      it 'gets new selection if taken' do
        allow_any_instance_of(Object).to receive(:gets).and_return("!\n", "1\n", "2\n")
        expect(player).to receive(:make_move).at_least(:twice).and_call_original
        Player.class_variable_set(:@@taken, [1]) 
        selection = player.make_move(player)
        expect(selection)
      end
      it 'adds selection to selections' do
        allow_any_instance_of(Object).to receive(:gets).and_return("!\n", "4\n")
        expect(player).to receive(:make_move).at_least(:twice).and_call_original
        selection = player.make_move(player)
        expect(player.instance_variable_get(:@selections)).to eq([4])
      end
      it 'adds selection to taken' do
        allow_any_instance_of(Object).to receive(:gets).and_return("!\n", "5\n")
        expect(player).to receive(:make_move).at_least(:twice).and_call_original
        selection = player.make_move(player)
        expect(Player.class_variable_get(:@@taken)).to include(5)
      end
    end
  end
  describe '#computer_move' do
    context 'when called' do
      it 'returns selection' do
        selection = player.computer_move(player)
        expect(selection).to match(/^\d$/)
      end
      it 'selection does not contain taken' do
      end
      it 'adds selection to selections' do
        selection = player.computer_move(player)
        expect(player.instance_variable_get(:@selections)).to include(selection.to_i)
      end
      it 'adds selection to taken' do
        selection = player.computer_move(player)
        expect(Player.class_variable_get(:@@taken)).to include(selection.to_i)
      end
    end
  end
  describe '#reset_marks' do
    context 'when called' do
      it 'marks array reset' do
        Player.class_variable_set(:@@marks, ['◯'])
        Player.reset_marks 
        expect(Player.class_variable_get(:@@marks)).to eq(['◯', '✕'])
      end
      it 'taken array reset' do
        Player.class_variable_set(:@@taken, [1]) 
        Player.reset_marks
        expect(Player.class_variable_get(:@@taken)).to eq([])
      end
    end
  end
end