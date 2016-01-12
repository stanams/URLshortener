module SlidingMoves
  def lateral(row, col, n)
    possible_moves = []
    (-n..n).each do |delta_row|
      possible_moves << [row + delta_row, col]
    end
    (-n..n).each do |delta_col|
      possible_moves << [row, col + delta_col]
    end
    possible_moves
  end

  def diagonal(row, col, n)
    possible_moves = []
    (-n..n).each do |delta_right_diag|
      possible_moves << [row + delta_right_diag, col + delta_right_diag]
    end
    (-n..n).each do |delta_left_diag|
      possible_moves << [row - delta_left_diag, col + delta_left_diag]
    end
    possible_moves
  end

  def filter_lateral(moves, original_obj)
    filtered_moves = moves
    curr_row, curr_col = original_obj.position
    moves.each do |pos|
      potential_row, potential_col = pos
      potential_obj = original_obj.board.grid[potential_row][potential_col]
      offset = (potential_obj.color == original_obj.color) ? 0 : 1

      if !potential_obj.color.nil?
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
    filtered_moves
  end

end
