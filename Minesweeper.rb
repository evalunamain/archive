#module Minesweeper
  class Tile

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
    def initialize(grid, pos)
      @pos = pos
      @grid = grid
      @status = nil
      @bomb_count = neighbor_bomb_count
      @is_bomb = !grid[pos[0]][pos[1]].nil?
      # @bombed, @flagged, @revealed = nil, nil, nil
    end

    def set_status(status)
      @status = status
    end

    def neighbor_bomb_count
      count = 0

      neighbors_arr = neighbors

      neighbors_arr.each do |tile|
        i, j = tile
        unless @grid[i][j].nil?
          count += 1
        end
      end
      count
    end

    def neighbors
      neighbors_arr = []

      OFFSETS.each do |item|
        neighbor =  [@pos[0] + item[0], @pos[1] + item[1]]
        neighbors_arr << neighbor if neighbor.all?{ |num| num.between?(0, 8)}
      end

      neighbors_arr
    end

    def reveal(pos, grid)
      i, j = pos

      if is_bomb
        p "game over"

      end

    end
  end

  class Board
    attr_reader :grid

    def initialize
      @grid = Array.new(9){Array.new(9)}
    end

    def grid
      @grid
    end

    def seed_bombs
      bombs = []
      until bombs.count == 10
        i = rand(8)
        j = rand(8)
        bombs << [i, j] unless bombs.include?([i, j])
      end

      bombs.each do |bomb|
        @grid[bomb[0]][bomb[1]] = 'B'
      end
    end

  end

  class Game
    def play
      @board = Board.new
    end

    def display

    end
  end
#end
