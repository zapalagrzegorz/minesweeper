class Tile
  attr_reader :bombed, :revealed

  def initialize()
    @bombed = false
    @flagged = false
    @revealed = false
  end

  #   rendering board
  def to_s
    return "*" if @revealed == false

    neighbor_bomb_count ? neighbor_bomb_count : "_"
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
    false
    # filter neighbour with bombs
  end

  def set_bomb
    @bombed = true
  end

  def act_on_tile(action)
    if action == "r"
      reveal
    else
      @flagged = !@flagged
    end
  end
end
