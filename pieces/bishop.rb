require_relative "pieces"

class Bishop < Piece
  include SlidingMoves

  def initialize(position, board, color)
    super(position, board, color)
    @value = " ♝ "
  end

  def moves
    row, col = @position
    n = @board.grid.length - 1

    diagonal(row, col, n).select do |pos|
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
        if curr_row > potential_row && curr_col > potential_col #SW
          filtered_moves.reject! do |pos|
            pos[0] >= potential_row - offset && pos[1] <= potential_col - offset
          end
        elsif curr_row > potential_row && curr_col < potential_col #NW
          filtered_moves.reject! do |pos|
            pos[0] <= potential_row - offset && pos[1] <= potential_col - offset
          end
        elsif curr_col < potential_col && curr_row > potential_row #SE
          filtered_moves.reject! do |pos|
            pos[0] >= potential_row - offset && pos[1] >= potential_col - offset
          end
        elsif curr_col < potential_col && curr_row < potential_row #NE
          filtered_moves.reject! do |pos|
            pos[0] <= potential_row - offset && pos[1] >= potential_col - offset
          end
        end
      end
    end
    filtered_moves
  end

end
