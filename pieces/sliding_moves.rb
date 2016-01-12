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

end
