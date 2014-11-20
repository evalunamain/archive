class Piece

  MOVES = {:white => [[-1, 1], [1, 1]],
           :black => [[-1, -1], [1, -1]]}

  attr_reader :color
  attr_accessor :pos, :status

  def initialize(color, pos, board, status = nil)
    @color = color
    @pos = pos
    @board = board
    @status = "Pawn" unless status
  end

  def render
    self.color == :white ? " W" : " B"
  end

  def perform_slide(target)
    #should return true or false
    if !poss_moves("slide", status).include?(target) || !@board[target].nil?
      return false
    end

    move_piece(pos, target)

    true
  end

  def perform_jump(target)
    if !poss_moves("jump", status).include?(target) || !@board[target].nil?
      return false
    end

    jumped_square = @board.find_squares_between(pos, target)
    return false unless @board[jumped_square].color != color || @board[jumped_square].nil?

    @board.capture(jumped_square)
    move_piece(pos, target)

    true
  end

  def move_piece(start, target)
    self.pos = [target]
    @board[target] = self
    @board[start] = nil

    maybe_promote
  end

  def poss_moves(type, status)
    moves = []

    MOVES[color].each do |diff|
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
      self.status = "King"
    end

  end

end
