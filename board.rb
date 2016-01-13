require 'byebug'
require "colorize"
require_relative "./pieces/pieces"
require_relative "display"
class Board
  attr_accessor :grid

  def initialize(pop = true)
    @grid = Array.new(8) { Array.new(8) { nil } }
    populate if pop
  end

  def back_row(i, j, color)
    [
      Rook.new([i,j], self, color),
      Knight.new([i,j], self, color),
      Bishop.new([i,j], self, color),
      Queen.new([i,j], self, color),
      King.new([i,j], self, color),
      Bishop.new([i,j], self, color),
      Knight.new([i,j], self, color),
      Rook.new([i,j], self, color)
      ]
  end

  def populate
    @grid.map!.with_index do |row, i|
      row.map.with_index do |space, j|
        case i
        when 0
          piece = back_row(i, j, :black)[j]
        when 7
          piece = back_row(i,j, :white).reverse[j]
        when 1
          piece = Pawn.new([i, j], self, :black)
        when 6
          piece = Pawn.new([i, j], self, :white)
        else
          piece = NullPiece.new([i, j], self, nil)
        end
      end
    end
  end

  def get_object_at_pos(pos)
    row, col = pos
    @grid[row][col]
  end

  def place_piece(pos, piece)
    row, col = pos
    @grid[row][col] = piece
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, @grid.length - 1) }
  end

  def rows
    @grid
  end

  def move()

  end

  def move!(old_pos, new_pos, selected_piece)
    place_piece(new_pos, selected_piece)
    selected_piece.position = new_pos
    place_piece(old_pos, NullPiece.new(old_pos, @board, nil))
  end

end

# if __FILE__ == $PROGRAM_NAME
#   board = Board.new
#   board.populate
#   board.grid[4][4] = Rook.new([4,4], board)
#   display = Display.new(board)
#   display.render
#
# end
