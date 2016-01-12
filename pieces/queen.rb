require_relative "pieces"
require "colorize"

class Queen < Piece
  include SlidingMoves

  def initialize(position, board, color)
    super(position, board, color)
    @value = " ♛ "
  end

  def moves
    possible_moves = []
    row, col = @position
    n = @board.grid.length - 1
    possible_moves << lateral(row, col, n)
    possible_moves << diagonal(row, col, n)
    possible_moves.map do |arr|
      arr.select do |pos|
        @board.in_bounds?(pos) && pos != @position
      end
    end
  end

  def valid_moves
    all_filtered = []
    all_filtered.concat(filtered_lateral(moves[0], self))
    all_filtered.concat(filtered_diagonal(moves[1],self))
    all_filtered
  end
end
