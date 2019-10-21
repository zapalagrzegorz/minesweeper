require "colorize"

class Tile
  attr_reader :bombed
  attr_accessor :revealed

  def initialize(board, pos)
    @board = board
    @direct_neighbors = nil
    @bombed = false
    @flagged = false
    @revealed = false
    @pos = pos
    @bomb_count = 0
  end

  #   rendering board
  def to_s
    return "!".colorize(:red) if @bombed && @revealed

    return "#{@bomb_count}".colorize(:yellow) if @bomb_count.positive?

    return "_".colorize(:green) if @revealed == true

    return "F".colorize(:light_red) if @flagged

    "*"
  end

  def reveal
    @revealed = true

    neighbor_bomb_count

    if @bomb_count.zero?
      reveal_neighbors
    end

    return false if @bombed

    true
  end

  def revealed?
    revealed
  end

  def reveal_neighbors
    @direct_neighbors.each do |neighbor|
      x, y = neighbor
      # exist?(pos)
      if @board[x] && @board[x][y] && !@board[x][y].revealed?
        @board[x][y].reveal
      end
    end
  end

  def neighbor_bomb_count
    @direct_neighbors ||= direct_neighbors

    @direct_neighbors.each do |neighbor|
      x, y = neighbor
      if @board[x] && @board[x][y] && @board[x][y].bombed
        @bomb_count += 1
      end
    end

    @bomb_count
  end

  def set_bomb
    @bombed = true
  end

  def act_on_tile(action)
    return reveal if action == "r"

    @flagged = true if action == "f"

    true
  end

  def direct_neighbors
    direct_neighbors = []

    x, y = @pos
    possible_neighbors = [
      [x - 1, y + 1],
      [x, y + 1],
      [x + 1, y + 1],

      [x - 1, y],
      [x + 1, y],

      [x - 1, y - 1],
      [x, y - 1],
      [x + 1, y - 1],
    ]

    possible_neighbors.each do |neighbor|
      neighbour_x, neighbour_y = neighbor
      if neighbour_x >= 0 && neighbour_y >= 0 && @board[x] && @board[x][y]
        direct_neighbors << neighbor
      end
    end

    direct_neighbors
  end

  def inspect
    "Tile: @bombed - #{@bombed} - pos: #{@pos}, @revealed - #{@revealed}, @bomb_count - #{@bomb_count}; direct_neighbors: #{@direct_neighbors}; @flagged: #{@flagged}"
  end
end
