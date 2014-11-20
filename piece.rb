class Piece

  MOVES = {:white => [[-1, 1], [1, 1]],
           :black => [[-1, -1], [1, -1]]}

  attr_reader :color
  attr_accessor :pos, :king

  def initialize(color, pos, board, king = false)
    @color = color
    @pos = pos
    @board = board
    @king = king
  end

  def render
    self.color == :white ? " W" : " B"
  end

  def perform_moves(move_sequence)
    if valid_move_seq?(move_sequence)
      perform_moves!(move_sequence)
    else
      raise InvalidMoveError.new "This is not a valid sequence"
    end
  end

  def valid_move_seq?(move_sequence)
    test_board = @board.dup
    test_piece = test_board[self.pos]

    begin test_piece.perform_moves!(move_sequence)
    rescue InvalidMoveError
      return false
    else
      return true
    end
  end

  def perform_moves!(move_sequence)
    if move_sequence.count == 1
      return true if perform_slide(move_sequence.first)
      perform_jump(move_sequence.first)
    else
      move_sequence.each do |move|
        raise InvalidMoveError.new unless perform_jump(move)
      end
    end

    true
  end

  def perform_slide(target)
    if !poss_moves("slide").include?(target) || !@board[target].nil?
      raise InvalidMoveError.new "This is not a valid move."
    end

    move_piece(pos, target)

    true
  end

  def perform_jump(target)
    if !poss_moves("jump").include?(target) || !@board[target].nil?
      raise InvalidMoveError.new "Piece can't make this move."
    end

    jumped_square = find_jumped_square(pos, target)

    if @board[jumped_square].color == color || !@board[jumped_square].nil?
      raise InvalidMoveError.new "You can only jump your opponent's pieces."
    end

    @board.capture(jumped_square)
    move_piece(pos, target)

    true
  end

  private

  def find_jumped_square(start, target)
    if start[0] > target[0]
      x = start[0] - 1
    else x = target[0] - 1
    end

    if start[1] > target[1]
      y = start[1] - 1
    else x = target[1] - 1
    end

    [x, y]
  end

  def move_piece(start, target)
    self.pos = target
    @board[target] = self
    @board[start] = nil

    maybe_promote
  end

  def poss_moves(type)
    moves = []

    @king ? move_dirs = MOVES[:black] + MOVES[:white] : move_dirs = MOVES[color]

    move_dirs.each do |diff|
       if type == "slide"
         x, y = diff
       elsif type == "jump"
         x, y = diff
         x = 2 * x
         y = 2 * y
       end

       move = [pos[0] + x, pos[1] + y]
       moves << move if move.all? { |num| num.between?(0, @board.grid.size - 1) }
     end

   moves
  end

  def maybe_promote
    y_goal = (color == :black ? 0 : @board.grid.size - 1)

    if pos[1] == y_goal
      @king = true
    end

  end

end
