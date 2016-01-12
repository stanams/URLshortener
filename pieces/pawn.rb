require_relative "pieces"

class Pawn < Piece

  def initialize(position, board, color)
    super(position, board, color)
    @value = " ♟ "
    @initial_row = position[0]
  end

  def valid_moves

    row, col = @position
    n = @board.grid.length - 1
    possible_moves = []
    if @initial_row == 1
      possible_moves << [row + 1, col]
    elsif @initial_row == 6
      possible_moves << [row - 1, col]
    end

    possible_moves.select do |pos|
      @board.in_bounds?(pos) && pos != @position
    end

  end


end
