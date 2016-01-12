require_relative "pieces"
require "colorize"


class Queen < Piece
  include SlidingMoves

  def initialize(position, board, color)
    super(position, board, color)
    @value = " ♛ "
  end

  def valid_moves
    possible_moves = []
    row, col = @position
    n = @board.grid.length - 1
    possible_moves.concat(lateral(row, col, n))
    possible_moves.concat(diagonal(row, col, n))

    possible_moves.select do |pos|
      @board.in_bounds?(pos) && pos != @position
    end

  end


end
