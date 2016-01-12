require "colorize"

class Piece
  attr_accessor :position
  attr_reader :value, :color

  def initialize(position, board, color)
    @position = position
    @board = board
    @color = color #0 is black, 1 is white
  end

end
