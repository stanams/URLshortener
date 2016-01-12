require_relative "pieces"

class Bishop < Piece
  include SlidingMoves

  def initialize(position, board, color)
    super(position, board, color)
    @value = " ♝ "
  end

  def valid_moves
    row, col = @position
    n = @board.grid.length - 1

    diagonal(row, col, n).select do |pos|
      @board.in_bounds?(pos) && pos != @position
    end

  end


end
