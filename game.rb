require 'byebug'
require_relative "board"
require_relative "player"

class Game
  attr_reader :board
  def initialize
    @board = Board.new
    @player = Player.new(@board)
  end

  def take_turn
    pos = @player.move
    selected_piece = @board.get_object_at_pos(pos)
    moves = selected_piece.valid_moves
    new_pos = @player.move
    if moves.include?(new_pos)
      @board.move!(pos, new_pos, selected_piece)
    end
    @player.display.render
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new

  25.times { game.take_turn }

end
