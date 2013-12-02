require_relative 'board'

class Piece

  attr_accessor :king

  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
    @king = false
    @board[pos] = self
  end
  
  BLACK_MOVES = [[1, -1], [-1, -1]]
  RED_MOVES = [[1, 1], [-1, 1]]
  
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
  
  def perform_slide(pos)
    possible_moves = []
    self.moves_diff.each do |move|
      new_move = [@pos[0] + move[0], @pos[1] + move[1]]
      if @board.on_board?(new_move)
        possible_moves << new_move
      end
    end
    return false unless possible_moves.include?(pos)
      if @board[pos] == nil       
        @board[@pos] = nil
        @pos = pos
        @board[pos] = self
        return true
     end
    
  end
  
  def perform_jump
  end  

end

board = Board.new
piece = Piece.new(:red, [0, 0], board)
p piece
p piece.perform_slide([1, 1])
p piece