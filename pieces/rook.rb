require_relative "pieces"
require 'byebug'

class Rook < Piece
  include SlidingMoves

  def initialize(position, board, color)
    super(position, board, color)
    @value = " ♜ "
  end

  def moves
    row, col = @position
    n = @board.grid.length - 1

    lateral(row, col, n).select do |pos|
      @board.in_bounds?(pos) && pos != @position
    end
  end

  def valid_moves
    filtered_lateral(moves, self)
  end

end
