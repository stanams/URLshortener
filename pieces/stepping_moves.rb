module SteppingMoves
  def filtered_steps(moves, original_obj)
    filtered_moves = []
    moves.each do |pos|
      row, col = pos[0], pos[1]
      obj = original_obj.board.grid[row][col]
      if obj.color.nil? || obj.color != original_obj.color
        filtered_moves << pos
      end
    end
    filtered_moves
  end
end
