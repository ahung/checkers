require_relative 'board'

class Piece

  attr_accessor :king, :pos, :board
  attr_reader :color

  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
    @king = false
    @board[pos] = self
  end
  
  BLACK_MOVES = [[1, -1], [-1, -1]]
  RED_MOVES = [[1, 1], [-1, 1]]
  
  def maybe_promote
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
  
  def valid_jump?(pos)
    possible_moves = []
    self.moves_diff.each do |move|
      new_move = [@pos[0] + (move[0] * 2), @pos[1] + (move[1] * 2)]
      enemy_pos = [@pos[0] + move[0], @pos[1] + move[1]]
      if @board[enemy_pos] != nil && @board[enemy_pos].color != @color
        possible_moves << new_move
      end
      possible_moves.include?(pos)
    end
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
  
  # def to_s
  #   if @color == :red
  #     puts "\u26AA"
  #   else
  #     puts "\u26AB"
  #   end
  # end

end

board = Board.new
#piece1 = Piece.new(:red, [0, 0], board)
piece2 = Piece.new(:black, [1, 1], board)
# p piece2.color
p board
p piece2.perform_slide([0, 0])
p piece2
# p board