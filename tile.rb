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
    return "*" if @revealed == false
    return "!".colorize(:red) if @bombed == true

    neighbor_bomb_count ? "#{neighbor_bomb_count}" : "_".colorize(:green)
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
    return @bomb_count if @bomb_count > 0

    # @direct_neighbors = @direct_neighbors ||  direct_neighbors(board)
    @direct_neighbors ||= direct_neighbors

    direct_neighbors.each do |neighbor|
      x, y = neighbor
      # debugger if @board[x][y] == nil
      if @board[x] && @board[x][y] && @board[x][y].bombed
        # debugger
        @bomb_count += 1
      end
    end

    return @bomb_count if @bomb_count > 0

    false
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

  def direct_neighbors
    # debugger
    @direct_neighbors = []

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
      x, y = neighbor
      # debugger if @board[x][y].nil?
      # debugger if x == 0 && y < 0
      if x >= 0 && y >= 0 && @board[x] && @board[x][y]
        @direct_neighbors << neighbor
      end
    end
  end

  def inspect
    "Tile: @bombed - #{@bombed} - pos: #{@pos}, @revealed - #{@revealed}, @bomb_count - #{@bomb_count}; direct_neighbors: #{@direct_neighbors}"
  end
end
