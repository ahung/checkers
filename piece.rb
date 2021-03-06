require_relative 'board'

class InvalidMoveError < StandardError
end

class Piece

  attr_accessor :king, :pos, :board
  attr_reader :color

  def initialize(color, pos, board, king = false)
    @color = color
    @pos = pos
    @board = board
    @king = king
    @board[pos] = self
  end
  
  BLACK_MOVES = [[1, -1], [-1, -1]]
  RED_MOVES = [[1, 1], [-1, 1]]
  
  def maybe_promote
    return if @king == true
    if @color == :black && @pos[1] == 0
      @king = true
    elsif @color == :red && @pos[1] == 7
      @king = true
    end
  end
  
  def moves_diff
    moves = []
    if @king == true
      moves = RED_MOVES
      moves += BLACK_MOVES
    elsif @color == :black
      moves = BLACK_MOVES
    else
      moves = RED_MOVES
    end
  end
  
  def perform_moves!(sequence)
    if sequence.length == 1
      if self.valid_slide?(sequence[0])
        self.perform_slide(sequence[0]) 
      elsif self.valid_jump?(sequence[0])
        self.perform_jump(sequence[0])
      else 
        raise InvalidMoveError.new
      end
    else
      sequence.each do |pos|
        raise InvalidMoveError.new unless self.valid_jump?(pos)
        self.perform_jump(pos)
      end
    end  
  end
  
  def perform_moves(sequence)
    if valid_move_seq?(sequence)
      perform_moves!(sequence)
    else
      raise InvalidMoveError.new
    end
  end
  
  def perform_jump(pos)
    if valid_jump?(pos)
      @board[@pos] = nil
      enemy_pos = (@pos[0] + pos[0]) / 2, (@pos[1] + pos[1]) / 2
      @board[enemy_pos].pos = nil
      @board[enemy_pos] = nil
      @pos = pos
      @board[pos] = self
      self.maybe_promote
      return true
    end
    false
  end
  
  def perform_slide(pos)
    if valid_slide?(pos)      
      @board[@pos] = nil
      @pos = pos
      @board[pos] = self
      self.maybe_promote
      return true
    end
    false
  end
  
  def valid_move_seq?(sequence)
    test_board = self.board.dup
    test_piece = test_board[self.pos]
    p test_piece
    begin
      test_piece.perform_moves!(sequence)
    rescue InvalidMoveError
      return false
    end
    true
  end
  
  #refactor valid_jump? and valid_slide? too similar
  def valid_jump?(pos)
    possible_moves = []
    self.moves_diff.each do |move|
      new_move = [@pos[0] + (move[0] * 2), @pos[1] + (move[1] * 2)]
      enemy_pos = [@pos[0] + move[0], @pos[1] + move[1]]
      if @board[enemy_pos] != nil && @board[enemy_pos].color != @color
        possible_moves << new_move
      end
    end
    possible_moves.include?(pos)
  end
  
  def valid_slide?(pos)
    possible_moves = []
    self.moves_diff.each do |move|
      new_move = [@pos[0] + move[0], @pos[1] + move[1]]
      if @board.on_board?(new_move) && @board[pos] == nil
        possible_moves << new_move
      end
    end
    possible_moves.include?(pos) 
  end
  
  def to_s
    if @color == :red && @king == true
      #"\u26AA"
      "R"
    elsif @color == :red && @king == false
      "r"
    elsif @color == :black && @king == true
      #"\u26AB"
      "B"
    else
      "b"
    end
  end

end

# board = Board.new
# board.populate_board
# piece1 = Piece.new(:black, [1, 1], board)
# puts board
# piece1.perform_moves([[0, 0]])
# puts board
# p piece1.valid_move_seq?([1, 1])
# piece1.perform_moves([[1, 1]])
# puts board

