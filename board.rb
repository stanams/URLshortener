require_relative "pieces"

class Board
  attr_reader :grid
  def initialize
    @grid = Array.new(8) { Array.new(8) {nil} }
  end

  def populate
    @grid.map!.with_index do |row, i|
      row.map.with_index do |space, j|
        space = NullPiece.new([i, j])
      end
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  board.populate
  p board.grid
end
