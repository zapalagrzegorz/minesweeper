require_relative "board"
require "colorize"

class Game
  attr_reader :board

  def initialize
    @board = nil
    @win = false
    @keep_playing = true
  end

  def run
    until game_solved?
      board_render
      user_play
    end

    puts @win ? "You've win." : "You've lost."
  end

  def user_play
    # debugger
    user_action_and_coords = get_user_input
    action = user_action_and_coords["action"]
    pos = user_action_and_coords["coordinates"]
    # debugger
    unless @board
      @board ||= Board.new(pos)
    end
    tile = @board[pos]
    #  tile.act_on_tile(action)
    @keep_playing = tile.act_on_tile(action, pos)
  end

  def get_user_input
    user_input = nil
    until user_input
      puts "Choose operation 'r' - to reveal, 'f' to flag with coordinates like 'r2,3'"
      user_input = gets.chomp
      user_input = parse_input(user_input)
    end

    user_input
  end

  def parse_input(user_input)
    return nil unless user_input[0] == "r" || user_input[0] == "f"

    return nil unless user_input[2] == ","

    return nil unless user_input.length == 4

    coordinates = user_input[1..3].split(",").map { |pos| Integer(pos) }

    return {
             "action" => user_input[0],
             "coordinates" => coordinates,
           }
  end

  def game_solved?
    return false unless @board

    return true unless @keep_playing

    revealed_tiles = 0
    # to powinna robić metoda board
    # end_game = @board.any? do |row|
    #   row.any? { |tile| tile.bombed == true && tile.revealed == true }
    # end

    # to powinna robić metoda board
    @board.each do |row|
      row.each do |tile|
        revealed_tiles += 1 if tile.revealed
      end
    end

    if revealed_tiles == 90
      @win = true
      return @win
    end

    false
  end

  def board_render
    # debugger

    if @board
      @board.render
    else
      nine_stars = []
      10.times { nine_stars << "*" }
      nine_stars = nine_stars.join(" ")
      # nine_stars = "* * * * * * * * * *"

      puts "  #{(0..9).to_a.join(" ")}".colorize(:blue)
      10.times do |i|
        print "#{i}".colorize(:blue)
        print " #{nine_stars}\n"
        # (0..9).to_a.join(" ")
      end
    end
  end

  def board_render_debug
    @board ||= Board.new([0, 0])
    debug_board = Board.make_debug_board

    # debugger
    debug_board.board = @board.board.map do |row|
      row.map do |tile|
        tile.revealed = true
        tile
      end
    end

    # debugger
    debug_board.render
  end
end

if $PROGRAM_NAME == __FILE__
  Game.new()
  # else
end
# load "minesweeper.rb"
# game = Game.new
# game.user_play

# game.board[]
# game.user_play

# game = Game.new
