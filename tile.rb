require "colorize"

class Tile
  attr_reader :bombed, :revealed

  def initialize(board)
    @board = board
    @bombed = false
    @flagged = false
    @revealed = false
    @pos = nil
    @bomb_count = 0
  end

  #   rendering board
  def to_s
    return "*" if @revealed == false

    # debugger
    neighbor_bomb_count ? "#{neighbor_bomb_count}" : "_".colorize(:green)
  end

  def reveal(pos)
    @pos = pos
    return false if @bombed

    @revealed = true

    true
  end

  def neighbors
    # BFS?
  end

  def neighbor_bomb_count
    return @bomb_count if @bomb_count > 0

    x, y = @pos
    direct_neighbors = [
      [x - 1, y + 1],
      [x, y + 1],
      [x + 1, y + 1],

      [x - 1, y],
      [x + 1, y],

      [x - 1, y - 1],
      [x, y - 1],
      [x + 1, y - 1],
    ]

    direct_neighbors.each do |neighbor|
      x, y = neighbor
      if @board[x][y] && @board[x][y].bombed
        @bomb_count += 1
      end
    end

    return @bomb_count if @bomb_count > 0

    false
  end

  def set_bomb
    @bombed = true
  end

  def act_on_tile(action, pos)
    if action == "r"
      reveal(pos)
    else
      @flagged = !@flagged
    end
  end
end
