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
      @board.place_piece(new_pos, selected_piece)
      selected_piece.position = new_pos #LOOK AT THIS BUG!!!
      @board.place_piece(pos, NullPiece.new(pos, @board, nil))
    end
    @player.display.render
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new

  4.times { game.take_turn }

end
