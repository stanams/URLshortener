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
  begin
    @pos = pick_a_spot
    piece = select_a_piece(@pos)
    almost_valid = piece.valid_moves
    moves = almost_valid.reject { |pos| pos == (get_king(@board, @other_player.color)[0].position) }

    @curr_player.highlight_poss(moves)

    set_the_piece(moves, piece)

    @curr_player.unhighlight_poss
    check_move(dup_board)
  rescue
    puts "CHECK, MOFUCKAH"
    sleep(2)
  end
    player_switch
  end

  def check_move(board)
    if board_in_check?(board, @other_player.color)
      if checkmate?(board, @other_player.color)
        notify_mate
      else
        raise "CHECK, MOFUCKAH!"
      end
    end
  end

  def notify_mate
    puts "CHECKMATE"
    sleep(5)
    exit
  end

  def get_king(board, color)
    board.grid.flatten.select do |piece|
      piece.color == color && piece.class == King
    end
  end


  def kings_valid_moves(king)
    return king.valid_moves.all? do |move|
      new_board = dup_board
      new_board.move!(king.position, move, king)
      board_in_check?(new_board, king.color)
    end
  end

  def checkmate?(board, color)
    king = get_king(board, color)
    check = kings_valid_moves(king[0])
    if check
      get_out_of_check_moves = escape_routes(board, color, king[0])
    end
    get_out_of_check_moves.length == 0
  end

  def escape_routes(board, color, king)
    get_out_of_check_moves = []
    all_pieces = board.grid.flatten.select { |piece| piece.color == color }
    all_pieces.each do |piece|
      piece.valid_moves.each do |move|
        new_board = dup_board
        new_board.move!(piece.position, move, piece)
        unless board_in_check?(new_board, king.color)
          get_out_of_check_moves << move
        end
      end
    end
    get_out_of_check_moves
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
    begin
    new_pos = @curr_player.move
    if moves.include?(new_pos)
      row, col = new_pos
      if selected_piece.class == King
        check_kings_move_for_check
      else
        @board.move!(@pos, new_pos, selected_piece)
      end
    end
    rescue
      puts "That would put you in check. Think againnnn!"
      sleep(2)
      @curr_player.unhighlight_poss
      take_turn
    end
    @curr_player.display.render
  end

  def check_kings_move_for_check(new_pos, selected_piece)
    new_board = dup_board
    new_board.move!(@pos, new_pos, selected_piece)
    if board_in_check?(new_board, @curr_player.color)
      raise "That would put you in check. Think againnnn!"
    else
      @board.move!(@pos, new_pos, selected_piece)
    end
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
