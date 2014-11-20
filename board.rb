require_relative "piece.rb"

class InvalidMoveError < StandardError
end

class Board
  attr_reader :size, :grid

  def initialize(size, new_board = true)
    @size = size
    make_board(new_board)
  end

  def make_board(new_board)
    @grid = Array.new(size) { Array.new(size) }

    if new_board
      [:white, :black].each do |color|
        place_pieces(@grid, color)
      end
    end
  end

  def dup
    new_board = Board.new(@grid.size, false)

    pieces.each do |piece|
      pos = piece.pos
      new_board[pos] = Piece.new(piece.color, piece.pos, new_board, piece.king)
    end

    new_board
  end

  def pieces
    @grid.flatten.compact
  end

  def place_pieces(grid, color)
    rows = (grid.size / 2 - 1)

    if color == :black
     y_range = ((@grid.size - 1).downto(@grid.size - rows))
    else
      y_range = (0...rows)
    end

   (0...@grid.size).each do |x|
     (y_range).each do |y|
       next if y.odd? && x.even?
       next if x.odd? && y.even?
          pos = [x,y]
      self[pos] = Piece.new(color, pos, self)
      end
    end
  end

  def [](pos)
    x, y = pos
    @grid[y][x]
  end

  def []=(pos, value)
    x, y = pos
    @grid[y][x] = value
  end

  def capture(piece)
    self[piece] = nil
  end

  def display
    puts self.render
  end


  def render
    switch = false

    @grid.reverse.map do |row|
      switch = !switch
      row.map do |square|
        switch = !switch
          square.nil? ? "    ".checker(switch) : square.render.checker(switch)
      end.join("")
    end.join("\n")
  end

  def inspect
    self.display
  end

end

class String
  def checker(switch)
    switch ? self.on_white : self
  end
end

  # def dark_squares
  #   dark_squares = []
  #
  #   (0...@grid.size).each do |x|
  #     (0...@grid.size).each do |y|
  #       next if y.odd? && x.even?
  #       next if x.odd? && y.even?
  #
  #       dark_squares << [x,y]
  #     end
  #   end
  #   dark_squares
  # end

# def empty_between?(start, target)
#   squares = find_squares_between(start, target)
#
#   squares.all? { |square| self[square].nil? }
# end
#
# def find_squares_between(start, target)
#   x_range = find_axis(start[0], target[0])
#   y_range = find_axis(start[1], target[1])
#
#   squares = []
#   x_range.each do |x|
#     y_range.each do |y|
#       squares << [x, y]
#     end
#   end
#   squares
# end
#
# def find_axis(pos1, pos2)
#   if pos1 < pos2
#     i, j = (pos1 + 1), pos2
#   else
#     i, j = (pos2 + 1), pos1
#   end
#
#   axis_range = (i..j)
# end
