class Board

  attr_reader :board

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
  
  def to_s
   output = "  01234567"
   8.times do |row_index|
     output += "\n #{row_index}"
     8.times do |col_index|
       if @board[col_index][row_index] == nil
         piece_text = "-"
       else
         piece_text = @board[col_index][row_index].to_s
       end
       output += piece_text
     end
   end
   output
  end
  
  def dup
    new_board = Board.new
    new_board.board.each_index do |row_index|
      new_board.board[row_index].each_index do |col_index|
        next if @board[col_index][row_index].nil?
        current_piece = @board[col_index][row_index]
        new_piece = current_piece.class.new(current_piece.color,
                                            current_piece.pos.dup,
                                            new_board)
        new_board.board[col_index][row_index] = new_piece
      end
    end
    new_board
  end

end