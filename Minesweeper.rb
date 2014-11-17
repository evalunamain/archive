
  class Tile
    #attr_reader :board, :pos
    attr_accessor :bombed, :flagged, :revealed, :seen_flag

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
      @seen_flag = false
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
      if self.flagged
        self.flagged = false
        @seen_flag = false
      end

      if @seen_flag != true
        @seen_flag = true
        self.revealed = true
        if self.neighbor_bomb_count == 0
          self.neighbors.each do |neighbor|
            neighbor.reveal
          end

        end
      end
    end

    def inspect
       "#{@pos}"
    #   # "Bombed is #{bombed}. Neighbor bomb count is #{neighbor_bomb_count}."
    end
  end

  class Board
    attr_reader :grid, :bomb_tiles

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
      @bomb_tiles = []
      until bombs.count == 10
        i = rand(8)
        j = rand(8)
        bombs << [i, j] unless bombs.include?([i, j])
      end

      bombs.each do |pos|
        self[pos].bombed = true
        @bomb_tiles << self[pos]
      end
    end

    def over?
      self.lost? || self.won?
    end

    def lost?
      return @bomb_tiles.any?{|bomb| bomb.revealed}
    end

    def won?
      @bomb_tiles.all?{ |bomb| bomb.flagged}
    end


  end

  class Game

    def initialize(board)
      @board = board
      @board.seed_bombs
    end

    def play
      p @board.bomb_tiles
      until @board.over?
        self.display
        choose_tile
      end

      if @board.won?
        p "Congratulations, you won!"
      end
      if @board.lost?
        p "You lost"
      end

    end

    def choose_tile
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
        @board[pos].seen_flag = true
      elsif action == "r"
        # if @board[pos].bombed?
        #   @board.lost?(true)
        #   p 'game over'
        #   return
        # else
          @board[pos].reveal
      end
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

  if __FILE__ == $PROGRAM_NAME
    board = Board.new
    game = Game.new(board)
    game.play
  end
