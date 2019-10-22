require_relative "board"
require "colorize"
require "yaml"

class Game
  OPTIONS = ["r", "f", "s"]

  attr_reader :board

  def initialize
    @board = nil
    @win = false
    @keep_playing = true
  end

  def run
    load_game

    until game_solved?
      board_render
      user_play
    end
    board_render
    puts @win ? "\nYou've win.".colorize(:green) : "\nYou've lost.".colorize(:red)
  end

  def user_play
    user_action_and_coords = get_user_input

    unless @board
      setup_board(user_action_and_coords)
    end

    make_tile_action(user_action_and_coords)
  end

  def make_tile_action(user_input)
    action = user_input["action"]
    pos = user_input["coordinates"]

    if action.downcase == "s"
      save_game
    else
      tile = @board[pos]
      @keep_playing = tile.act_on_tile(action)
    end
  end

  def save_game
    File.open("save-game.yml", "w") do |file|
      file.write(YAML.dump(@board))
    end
  end

  def load_game
    first_arg, *the_rest = ARGV
    if first_arg == "save-game.yml"
      # file = ARGF.read
      # board = YAML.load(file)
      board = YAML.load_file("./save-game.yml")

      @board = board
    end
  end

  def setup_board(user_input)
    pos = user_input["coordinates"]
    @board ||= Board.new(pos)
  end

  def get_user_input
    user_input = nil
    until user_input
      puts "Choose operation 'r' - to reveal, 'f' to flag with coordinates like 'r2,3'"
      user_input = STDIN.gets.chomp
      user_input = parse_input(user_input)
      puts
    end

    user_input
  end

  def parse_input(user_input)
    return nil unless OPTIONS.include?(user_input[0].downcase)

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
    if @board
      @board.render
    else
      nine_stars = []
      10.times { nine_stars << "*" }
      nine_stars = nine_stars.join(" ")

      puts "  #{(0..9).to_a.join(" ")}".colorize(:blue)
      10.times do |i|
        print "#{i}".colorize(:blue)
        print " #{nine_stars}\n"
      end
    end
  end

  def board_render_debug
    @board ||= Board.new([0, 0])
    debug_board = Board.make_debug_board

    debug_board.board = @board.board.map do |row|
      row.map do |tile|
        tile.revealed = true
        tile
      end
    end

    debug_board.render
  end
end

if $PROGRAM_NAME == __FILE__
  Game.new().run
end
# load "minesweeper.rb"
# game = Game.new
# game.user_play

# game.board[]
# game.user_play

# game = Game.new
