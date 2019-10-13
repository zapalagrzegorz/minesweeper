require_relative "tile"

class Board
  def initialize
    @board = Array.new(9) do
      Array.new(9) { Tile.new }
    end
  end

  def render
    puts "  #{(0..8).to_a.join(" ")}"
    grid.each_with_index do |row, i|
      # join rzutuje każdy element tablicy na string (to_s)
      puts "#{i} #{row.join(" ")}"
    end
  end
end
