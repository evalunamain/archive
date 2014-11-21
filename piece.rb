# encoding: utf-8

class Piece

  MOVES = {:white => [[-1, 1], [1, 1]],
           :black => [[-1, -1], [1, -1]]}

  attr_reader :color, :board
  attr_accessor :pos, :king

  def initialize(color, pos, board, king = false)
    @color, @pos, @board, @king = color, pos, board, king
		
    @board[pos] = self
  end

	def dup(new_board)
		Piece.new(color, pos, new_board, king)
	end
	
  def render
    color == :white ? "  W " : "  B "
  end
	
	def perform_moves(move_sequence)
    if valid_move_seq?(move_sequence)
	    perform_moves!(move_sequence)
	  else
			raise InvalidMoveError
	  end
	end
	
	protected
	WHITE_MOVES = [
	    [ 1, -1],
	    [ 1,  1]
	  ]

	  BLACK_MOVES = [
	    [-1, -1],
	    [-1,  1]
	  ]

	def valid_move_seq?(move_sequence)
		test_board = board.dup
   
	  begin test_board[pos].perform_moves!(move_sequence)
	  rescue InvalidMoveError
	     false
	  else
	     true
	  end
	end

	def perform_moves!(move_sequence)
	  if move_sequence.count == 1
			move = move_sequence.first
			unless perform_slide(move) || perform_jump(move)
	      raise InvalidMoveError
	    end
	  else
	    move_sequence.each do |move|
	    	raise InvalidMoveError unless perform_jump(move)
	    end
	  end
	end

	def perform_slide(target)
	  return false unless Board.valid_pos?(target)
		return false unless board.empty?(target)
		
		move_diff = [
			target[0] - pos[0],
			target[1] - pos[1]
		]
		return false unless move_diffs.include?(move_diff)
  
	  move_piece(pos, target)

	  true
	end

	def perform_jump(target)
		return false unless Board.valid_pos?(target)
		
		jump_diff = [
			(target[0] - pos[0]).div(2),
			(target[1] - pos[1]).div(2)
		]
		
		return false unless move_diffs.include?(jump_diff)
		
		jumped_square = find_jumped_square(pos, target)
		
   	if @board.empty?(jumped_square) || @board[jumped_square].color == color
			return false
		end

	  @board.capture(jumped_square)
		move_piece(pos, target)
	  
		true
	end

  def find_jumped_square(start, target)
    x = (start[0] + target[0]) / 2
    y = (start[1] + target[1]) / 2

    [x,y]
  end

  def move_piece(start, target)
    self.pos = target
    @board[target] = self
    @board[start] = nil

    maybe_promote
  end

  def move_diffs
		if king
			WHITE_MOVES + BLACK_MOVES
		else 
			(color == :white) ? WHITE_MOVES : BLACK_MOVES
		end
	end

  def maybe_promote
   @king = true if at_back_row?  
  end
	
	def at_back_row?
		case color
		when :white
			pos[0] == 7
		when :black
			pos[0] == 0
		end
	end

end
