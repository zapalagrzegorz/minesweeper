require_relative "board"

class Game
  def initialize
    @board = Board.new
    @win = false
  end

  def run
    until game_solved?
      @board.render
      user_play
    end
  end

  def user_play
    user_action_and_coords = get_user_input
    action = user_action_and_coords["action"]
    pos = user_action_and_coords["coordinates"]
    # debugger
    tile = @board[pos]
    tile.act_on_tile(action)
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
    revealed_tiles = 0

    # to powinna robić metoda board
    end_game = @board.any? do |row|
      row.any? { |tile| tile.bombed == true }
    end

    return true if end_game

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
end

if $PROGRAM_NAME == __FILE__
  Game.new().run
  # else
end
# game = Game.new
