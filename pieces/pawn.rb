require_relative "pieces"
require "byebug"
class Pawn < Piece
  attr_accessor :first_move, :initial_row

  def initialize(position, board, color)
    super(position, board, color)
    @value = " ♟ "
    @initial_row = position[0]
    @first_move = true
  end

  def moves
    row, col = @position
    n = @board.grid.length - 1
    if @initial_row == 1
      possible_moves = {
        first_move: [row + 2, col],
        standard_move: [row + 1, col],
        right_kill: [row + 1, col + 1],
        left_kill: [row + 1, col - 1]
      }
    elsif @initial_row == 6
      possible_moves = {
        first_move: [row - 2, col],
        standard_move: [row - 1, col],
        right_kill: [row - 1, col + 1],
        left_kill: [row - 1, col - 1]
      }
    end
    possible_moves.select do |key, pos|
      @board.in_bounds?(pos) && pos != @position
    end
  end

  def valid_moves
    curr_row, curr_col = @position
    filtered_moves = []
    #first move
    if @first_move
      first_move_pos = moves[:first_move]
      if @board.grid[first_move_pos[0]][first_move_pos[1]].color.nil?
        filtered_moves << first_move_pos
      end
    end
    #kill moves
    kill_moves = [moves[:right_kill], moves[:left_kill]]
    filtered_moves.concat(kill_moves.select do |pos|
      unless pos.nil?
        row, col = pos
        piece_color = @board.grid[row][col].color
        !piece_color.nil? && piece_color != @color
      end
      end)
    #standard move
    if @board.grid[moves[:standard_move][0]][moves[:standard_move][1]].color.nil?
      filtered_moves << moves[:standard_move]
    end

    @first_move = false

    filtered_moves

  end




end
