#module Minesweeper
  class Tile

    def neighbor_bomb_count(pos, grid)
      count = 0

      neighbors = neighbors(pos, grid)

      neighbors.each do |tile|
        i, j = tile
        if grid[i][j] == "B"
          count += 1
        end
      end
      count
    end

    def neighbors(pos, grid)
      neighbors = []

      [-1, 1].each do |i|
        [-1, 1].each do |j|
          neighbor1 =  [pos[0] + i, pos[1] + j]
          neighbor2 = [pos[0] + j, pos[1] + i]
          neighbors << neighbor1 if neighbor1.all?{ |num| num.between?(0, 8)}
          neighbors << neighbor2 if neighbor2.all?{ |num| num.between?(0, 8)}
        end
      end

      neighbors
    end

    def reveal
    end
  end

  class Board
    def initialize
      @grid = Array.new(9){Array.new(9)}
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

  class Player
  end
#end
