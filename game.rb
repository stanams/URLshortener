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
    @other_player = @player_b
  end

  def take_turn
    @pos = pick_a_spot
    piece = select_a_piece(@pos)
    moves = piece.valid_moves
    @curr_player.highlight_poss(moves)

    set_the_piece(moves, piece)

    @curr_player.unhighlight_poss
    new_board = dup_board
    if board_in_check?(new_board, @other_player.color)
      if checkmate?(new_board, @other_player.color)
        notify_mate
      end
      notify_check
    end
    player_switch
  end

  def notify_mate
    puts "CHECKMATE"
    sleep(5)
    exit
  end

  def checkmate?(board, color)
    king = board.grid.flatten.select do |piece|
      piece.color == color && piece.class == King
    end
    debugger
    king[0].valid_moves.all? do |move|
      new_board = dup_board
      new_board.move!(@pos, move, king[0])
      board_in_check?(new_board, king[0].color)
    end
  end


  def notify_check
    puts "CHECK, MOFUCKAAAHHH"
    sleep(2)
  end

  def dup_board
    new_board = Board.new(false)
    new_board.grid.map!.with_index do |row, i|
      row.map.with_index do |pos, j|
        pos = @board.grid[i][j].class.new([i,j], new_board, @board.grid[i][j].color)
      end
    end
    new_board
  end

  def board_in_check?(board, color)
    all_pieces = board.grid.flatten.select { |piece| piece.color != color && piece.color != nil }
    king = board.grid.flatten.select do |piece|
      piece.color == color && piece.class == King
    end
    all_moves = []
    all_pieces.each { |piece| all_moves += piece.valid_moves }
    all_moves.include?(king.first.position)

  end

  def pick_a_spot
    @curr_player.move
  end

  def select_a_piece(pos)
    selected_piece = @board.get_object_at_pos(pos)
    until @curr_player.color == selected_piece.color
      puts "Please select your own player."
      sleep(1)
      @pos = pick_a_spot
      selected_piece = @board.get_object_at_pos(@pos)
    end
    selected_piece
  end

  def set_the_piece(moves, selected_piece)
    new_pos = @curr_player.move
    if moves.include?(new_pos)
      row, col = new_pos
      if selected_piece.class == King
        new_board = dup_board
        new_board.move!(@pos, new_pos, selected_piece)
        if board_in_check?(new_board, @curr_player.color)
          puts "That would put you in check. Think againnnn!"
          sleep(2)
        else
          @board.move!(@pos, new_pos, selected_piece)
        end
      else
        @board.move!(@pos, new_pos, selected_piece)
      end
    end
    @curr_player.display.render
  end

  def player_switch
    @curr_player = @curr_player == @player_w ? @player_b : @player_w
    @other_player = @other_player == @player_w ? @player_b : @player_w
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new

  25.times { game.take_turn }

end
