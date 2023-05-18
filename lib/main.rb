# require_relative 'game_board'
# require_relative 'player'
# require_relative 'game'

%w[game_board player game].each { |lib| require_relative lib }

new_game = Game.new
new_game.play