require_relative "pieces"

class Pawn < Piece

  def initialize(position, board, color)
    super(position, board, color)
    @value = " ♟ "
    @initial_row = position[0]
    @first_move = true
  end

  def moves

    row, col = @position
    n = @board.grid.length - 1
    possible_moves = []
    if @initial_row == 1
      possible_moves.concat([
      [row + 1, col],
      [row + 1, col + 1],
      [row + 1, col - 1]
      ])
    elsif @initial_row == 6
      possible_moves.concat([
      [row - 1, col],
      [row - 1, col + 1],
      [row - 1, col - 1]
      ])
    end
    possible_moves.select do |pos|
      @board.in_bounds?(pos) && pos != @position
    end

  end

  def valid_moves
    curr_row, curr_col = @position
    filtered_moves = []
    first_step = @initial_row == 1 ? 2 : -2
    #first move
    if @first_move == true
      two_up_pos = [curr_row + first_step, curr_col]
      if @board.grid[two_up_pos[0]][two_up_pos[1]].color.nil?
        filtered_moves << two_up_pos
      end
    end
    #kill moves
    filtered_moves.concat(moves.drop(1).select do |pos|
      row, col = pos
      piece_color = @board.grid[row][col].color
      !piece_color.nil? && piece_color != @color
    end)
    #standard move
    if @board.grid[moves.first[0]][moves.first[1]].color.nil?
      filtered_moves << moves.first
    end

    @first_move = false

    filtered_moves

  end




end
