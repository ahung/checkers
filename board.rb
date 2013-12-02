class Board

  def initialize
    @board = Array.new(8) { Array.new(8, nil) }
  end
  
  def populate_board
  end
  
  def []=(pos, piece)
    x, y = pos
    @board[x][y] = piece
  end

  def [](pos)
    x, y = pos
    @board[x][y]
  end

  def on_board?(pos)
    (0..7).include?(pos[0]) &&
    (0..7).include?(pos[1])
  end
end