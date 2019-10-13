def Tile
  @bombed = false
  @flagged = false
  @revealed = false

  def initialize
  end

  def []=(pos, action)
    row, col = pos
    tile = grid[row][col]
    if (action == "r")
      tile.revealed = true
    else
      tile.flagged = !tile.flagged
    end
  end

  #   rendering board
  def to_s
    value == 0 ? " " : value.to_s.colorize(color)
  end

  def reveal
    return false if @bombed
    @revealed = true

    true
  end

  def neighbors
    # BFS?
  end

  def neighbor_bomb_count
    # filter neighbour with bombs
  end
end
