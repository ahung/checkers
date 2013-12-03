require_relative 'piece'

class Game
  
  def initialize
    @board = Board.new
    @board.populate_board
    @current_player = :black  
  end
  
  def play
    until @board.win?(:black) || @board.win?(:red)
      begin
        puts @board
        play_turn
        swap_turn
      rescue InvalidMoveError
        puts "Invalid Move. Try Again."
        retry
      end
    end
      
  end
  
  def play_turn
    puts "#{@current_player.capitalize}'s turn:"
    puts "What move would you like to make? Format: 12 34 56"
    input = gets.chomp.split(" ")
    move_sequence = []
    input.each do |pos|
      move_sequence << [Integer(pos[0]), Integer(pos[1])]
    end
    start_pos = move_sequence.shift
    if @board[start_pos].color == @current_player
      @board[start_pos].perform_moves(move_sequence)
    else
      raise InvalidMoveError.new
    end
  end
  
  def swap_turn
    @current_player == :black ?
      @current_player = :red : @current_player = :black
  end
end

game = Game.new
game.play