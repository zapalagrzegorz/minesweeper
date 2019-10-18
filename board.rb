require_relative "tile"
require "byebug"
require "colorize"

class Board
  include Enumerable

  def initialize(first_pick)
    @board = Array.new(10) { Array.new(10) }

    @board.each_index do |row|
      @board[row].each_index do |column|
        @board[row][column] = Tile.new(@board)
      end
    end

    place_random_bombs(first_pick)
  end

  def render
    puts "  #{(0..9).to_a.join(" ")}".colorize(:blue)

    @board.each_with_index do |row, i|
      # join rzutuje każdy element tablicy na string (to_s)
      print "#{i}".colorize(:blue)
      puts " #{row.join(" ")}"
    end
  end

  def []=(pos, action)
    # row, col = pos
    # debugger
    # tile = @board[row][col]
    # if action == "r"
    #   tile.reveal
    # else
    #   tile.flagged = !tile.flagged
    # end
  end

  def [](pos)
    row, col = pos

    @board[row][col]
  end

  # Aby obiekt tej klasy mógł skorzystać z metody mixin'a enumerable "any?"
  # klasa musi implementować each

  # https://stackoverflow.com/questions/2080007/how-do-i-add-each-method-to-ruby-object-or-should-i-extend-array
  def each
    # "each" is the base method called by all the iterators so you only have to define it
    @board.each do |value|
      # change or manipulate the values in your value array inside this block
      yield value
    end
  end

  def place_random_bombs(pos)
    x, y = pos
    bombs = 10
    # debugger
    until bombs == 0
      randY = rand(10)
      randX = rand(10)
      if (y != randY || x != randX) && !@board[randY][randX].bombed
        @board[randY][randX].set_bomb
        bombs -= 1
      end
    end

    @board
  end
end
