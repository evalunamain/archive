class InvalidMoveError < StandardError
end

class Board
  attr_reader :grid

  def initialize(fill_board = true)
    @grid = Array.new(8) { Array.new(8)}
    place_pieces if fill_board
  end
	
  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    y, x = pos
    @grid[y][x] = value
  end
	
	def empty?(pos)
		self[pos].nil?
	end
  
  def dup
    duped_board = Board.new(false)

    @grid.flatten.compact.each do |piece|
      Piece.new(piece.color, piece.pos, duped_board, piece.king)
    end

    duped_board
  end

  def pieces(color)
    @grid.flatten.compact.select { |p| p.color == color}
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

  def capture(piece)
    self[piece] = nil
  end

  def inspect
    self.display
  end
	
	def self.valid_pos?(pos)
		pos.all? { |num| num.between?(0,7) }
	end
	
	# private
  def place_pieces
    (0..2).each { |row| fill_row(row, :white)}
		(5..7).each { |row| fill_row(row, :black)}
	end
	
	def fill_row(row, color)
		8.times do |col|
			Piece.new(color, [row, col], self) if ((row % 2) == (col % 2))
		end
	end

end


class String
  def checker(switch)
    switch ? self.on_white : self
  end
end