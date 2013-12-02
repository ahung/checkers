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
  
  # def to_s
  #  output = ""
  #  8.times do |row_index|
  #    8.times do |col_index|
  #      if @board[col_index, row_index] == []
  #        piece_text = "  "
  #      else
  #        return @board[col_index, row_index].to_s
  #        piece_text = "test"
  #        #piece_text = @board[col_index, row_index].to_s
  #      end
  #      output += piece_text
  #    end
  #  end
  #  output
  # end

end