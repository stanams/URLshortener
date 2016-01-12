require "byebug"
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

  def filtered_lateral(moves, original_obj)
    filtered_moves = moves.dup
    curr_row, curr_col = original_obj.position
    moves.each do |pos|
      potential_row, potential_col = pos
      potential_obj = original_obj.board.grid[potential_row][potential_col]
      overtake_enemy = (potential_obj.color == original_obj.color) ? 0 : 1
      if !potential_obj.color.nil?
        if curr_row == potential_row && potential_col < curr_col
          filtered_moves.reject! do |pos|
            pos[0] == potential_row &&
            pos[1] <= potential_col - overtake_enemy
          end
        elsif curr_row == potential_row && potential_col > curr_col
          filtered_moves.reject! do |pos|
            pos[0] == potential_row &&
            pos[1] >= potential_col + overtake_enemy
          end
        elsif curr_col == potential_col && potential_row < curr_row
          filtered_moves.reject! do |pos|
            pos[0] <= potential_row - overtake_enemy &&
            pos[1] == potential_col
          end
        elsif curr_col == potential_col && potential_row > curr_row
          filtered_moves.reject! do |pos|
            pos[0] >= potential_row + overtake_enemy &&
            pos[1] == potential_col
          end
        end
      end

    end
    p filtered_moves
    filtered_moves
  end

  def filtered_diagonal(moves, original_obj)
    filtered_moves = moves.dup
    curr_row, curr_col = original_obj.position
    moves.each do |pos|
      potential_row, potential_col = pos
      potential_obj = original_obj.board.grid[potential_row][potential_col]
      overtake_enemy = (potential_obj.color == original_obj.color) ? 0 : 1
      if !potential_obj.color.nil?
        if potential_row < curr_row &&  potential_col < curr_col #NW
          filtered_moves.reject! do |pos|
            pos[0] <= potential_row - overtake_enemy && pos[1] <= potential_col - overtake_enemy
          end
        elsif potential_row < curr_row &&  potential_col > curr_col #NE
          filtered_moves.reject! do |pos|
            pos[0] <= potential_row - overtake_enemy && pos[1] >= potential_col + overtake_enemy
          end
        elsif potential_row > curr_row && potential_col > curr_col #SE
          filtered_moves.reject! do |pos|
            pos[0] >= potential_row + overtake_enemy && pos[1] >= potential_col + overtake_enemy
          end
        elsif potential_row > curr_row && potential_col < curr_col #SW
          filtered_moves.reject! do |pos|
            pos[0] >= potential_row + overtake_enemy && pos[1] <= potential_col - overtake_enemy
          end
        end
      end
    end
    p filtered_moves
    filtered_moves
  end

end
