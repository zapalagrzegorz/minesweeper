require_relative "tile"
require "byebug"

class Board
  include Enumerable

  def initialize
    @board = Array.new(10) do
      Array.new(10) { Tile.new(false) }
    end
  end

  def render
    puts "  #{(0..9).to_a.join(" ")}"
    @board.each_with_index do |row, i|
      # join rzutuje każdy element tablicy na string (to_s)
      puts "#{i} #{row.join(" ")}"
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

  # https://stackoverflow.com/questions/2080007/how-do-i-add-each-method-to-ruby-object-or-should-i-extend-array
  def each
    # "each" is the base method called by all the iterators so you only have to define it
    @board.each do |value|
      # change or manipulate the values in your value array inside this block
      yield value
    end
  end

  def set_random_bombs
    # pos = [0, 0]
    # tile = @board[0][0]
    # tile.set_bomb
    # bombs = 10
  end

  #
end
