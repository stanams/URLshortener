require_relative "pieces"

class Knight < Piece
  include SteppingMoves


  def initialize(position, board, color)
    super(position, board, color)
    @value = " ♞ "
  end

  def moves

    row, col = @position
    n = @board.grid.length - 1
    possible_moves = []
    [-1, -2, 1, 2].each do |delta_row|
      [-1, -2, 1, 2].each do |delta_col|
        unless delta_row.abs == delta_col.abs
          possible_moves << [row + delta_row, col + delta_col]
        end
      end
    end

    possible_moves.select do |pos|
      @board.in_bounds?(pos) && pos != @position
    end

  end

  def valid_moves
    filtered_steps(moves, self)
  end

end
