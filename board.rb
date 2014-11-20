require_relative "piece.rb"

class MoveError < StandardError
end

class Board
  attr_reader :size, :grid

  def initialize(size)
    @size = size
    make_board
  end

  def make_board
    @grid = Array.new(size) { Array.new(size) }

    [:white, :black].each do |color|
      place_pieces(@grid, color)
    end
  end

  def capture(piece)
    @board[piece] = nil
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

  def empty_between?(start, target)
    squares = find_squares_between(start, target)

    squares.all? { |square| self[square].nil? }
  end

  def find_squares_between(start, target)
    x_range = find_axis(start[0], target[0])
    y_range = find_axis(start[1], target[1])

    squares = []
    x_range.each do |x|
      y_range.each do |y|
        squares << [x, y]
      end
    end
    squares
  end

  def find_axis(pos1, pos2)
    if pos1 < pos2
      i, j = (pos1 + 1), pos2
    else
      i, j = (pos2 + 1), pos1
    end

    axis_range = (i..j)
  end

  def display
    puts self.render
  end

  def dark_squares
    dark_squares = []

    (0...@grid.size).each do |x|
      (0...@grid.size).each do |y|
        next if y.odd? && x.even?
        next if x.odd? && y.even?

        dark_squares << [x,y]
      end
    end
    dark_squares
  end

  def render
    @grid.reverse.map do |row|
      row.map do |square|
        square.nil? ? "  " : square.render
      end.join("")
    end.join("\n")
  end

  def inspect
    self.display
  end

end


if __FILE__ == $PROGRAM_NAME
  b = Board.new(8)
  puts b.render
end
