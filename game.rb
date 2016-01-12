require 'byebug'
require_relative "board"
require_relative "player"

class Game
  attr_reader :board
  def initialize
    @board = Board.new
    @player_w = Player.new(@board, :white)
    @player_b = Player.new(@board, :black)
    @curr_player = @player_w
  end

  def take_turn
    pos = @curr_player.move
    selected_piece = @board.get_object_at_pos(pos)
    until @curr_player.color == selected_piece.color
      puts "Please select your own player."
      sleep(1)
      pos = @curr_player.move
      selected_piece = @board.get_object_at_pos(pos)
    end
    moves = selected_piece.valid_moves

    @curr_player.highlight_poss(moves)

    new_pos = @curr_player.move
    if moves.include?(new_pos)
      @board.move!(pos, new_pos, selected_piece)
    end
    @curr_player.display.render
    @curr_player.unhighlight_poss
    player_switch
  end

  def player_switch
    @curr_player = @curr_player == @player_w ? @player_b : @player_w
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new

  25.times { game.take_turn }

end
