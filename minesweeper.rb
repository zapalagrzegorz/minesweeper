require_relative "board"

class Game
  def initialize
    @board = Board.new()
  end

  def take_turn
    until game_solved?
      @board.render
      user_play
    end
  end

  def user_play
    user_input = get_user_input
    pos = user_input[pos_x], user_input[pos_y]
    action = user_input[action]
  end

  def get_user_input
    user_input = nil
    until user_input
      puts "Choose operation 'r' - to reveal, 'f' to flag with coordinates like '2,3'"
      user_input = gets.chomp
      user_input = parse_input(user_input)
    end

    parse_input
  end

  def game_solved?
    @board.each
    # if(bombed && revealed)
    # win = false
    # return false
    # end
    # revealed++ if revealed
    #end
    # @win = true if revelead.count = all-bombs_num
  end
end
