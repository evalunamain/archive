#module Minesweeper
  class Tile
    attr_reader :grid, :pos
    attr_accessor :bombed, :flagged, :revealed

    OFFSETS = [
      [-1, -1],
      [-1, 0],
      [-1, 1],
      [0, -1],
      [0, 1],
      [1, -1],
      [1, 0],
      [1, 1]
    ]
    def initialize(pos, board)
      @pos = pos
      @board = board
      @bombed, @flagged, @revealed = false, false, false
    end

    def bombed?
      @bombed
    end

    def flagged?
      @flagged
    end

    def revealed?
      @revealed
    end

    def neighbor_bomb_count
      neighbors.select(&:bombed?).count
    end

    def neighbors
      neighbors_pos.map do |tile_pos|
        @board[tile_pos]
      end
    end

    def neighbors_pos
      neighbors_pos = []

      OFFSETS.each do |item|

         neighbor =  [@pos[0] + item[0], @pos[1] + item[1]]
         neighbors_pos << neighbor if neighbor.all?{ |num| num.between?(0, 8)}
      end

      neighbors_pos
    end

    def reveal
      self.revealed = true

      if self.neighbor_bomb_count == 0
        self.neighbors.each do |neighbor|
          neighbor.reveal
        end
      end
    end

    def inspect
      "Bombed is #{bombed}. Neighbor bomb count is #{neighbor_bomb_count}."
    end
  end

  class Board
    attr_reader :grid

    def initialize
      @grid = Array.new(9){Array.new(9) }

      @grid.each_index do |row|
        @grid.each_index do |col|
          pos = [row, col]
          self[pos] = Tile.new(pos, self)
        end
      end
    end

    def grid
      @grid
    end

    def [](pos)
      i, j = pos
      self.grid[i][j]
    end

    def []=(pos, value)
      i, j = pos
      self.grid[i][j] = value
    end

    def seed_bombs
      bombs = []
      until bombs.count == 10
        i = rand(8)
        j = rand(8)
        bombs << [i, j] unless bombs.include?([i, j])
      end

      bombs.each do |pos|
        self[pos].bombed = true
      end
    end


  end

  class Game

    def initialize(board)
      @board = board
    end

    def play


    end

    def choose_tile
      #choose coordinates, choose action (reveal/flag),
      puts "Please put in the coordinates (format: 1 2) of the tile you choose."
      choice = gets.chomp
      pos = []
      choice.split(' ').each do |i|
        pos << Integer(i)
      end


      puts "Please type 'f' for flag or 'r' for reveal."
      action = gets.chomp

      if action == "f"
        @board[pos].flagged = true
      elsif action == "r"
        if @board[pos].bombed?
          return 'game over'
        else
          @board[pos].reveal
        end
      end
    end

    def over?
      game.won? || game.lost?
    end

    def won?
      #all tiles with bomb flagged correctly
      bombs.all?{ |bomb| bomb.flagged == true}
    end

    def lost?

    end

    def display
      @board.grid.each do |row|
        row.each do |tile|
          if tile.flagged?
            print "F"
          elsif tile.revealed?
            count = tile.neighbor_bomb_count
            #count > 0 ? print count : print "_"
            print count if count > 0
            print '_' if count == 0
          else
            print '*'
          end
        end
        print "\n"
      end
    end
  end
#end
