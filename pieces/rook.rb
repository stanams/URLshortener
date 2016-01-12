require_relative "pieces"

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
    filtered_moves = moves
    curr_row, curr_col = @position
    moves.each do |pos|
      potential_row, potential_col = pos
      obj = @board.grid[potential_row][potential_col]

      offset = (obj.color == @color) ? 0 : 1

      if !obj.color.nil?
        if curr_row == potential_row && curr_col > potential_col
          filtered_moves.reject! { |pos| pos[1] <= potential_col - offset }
        elsif curr_row == potential_row && curr_col < potential_col
          filtered_moves.reject! { |pos| pos[1] >= potential_col + offset }
        elsif curr_col == potential_col && curr_row > potential_row
          filtered_moves.reject! { |pos| pos[0] <= potential_row - offset }
        elsif curr_col == potential_col && curr_row < potential_row
          filtered_moves.reject! { |pos| pos[0] >= potential_row + offset }
        end
      end
    end
    p filtered_moves
    filtered_moves
  end

end
