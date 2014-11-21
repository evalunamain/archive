class InvalidMoveError < StandardError
end

class TowersOfHanoi

  attr_reader :stacks

  def initialize
    @stacks = [ [3, 2, 1], [], [] ]
  end

  def render
    @stacks.each { |stack| p stack}
  end

  def move(stack1, stack2)
    if @stacks[stack1].empty?
      raise InvalidMoveError.new
    end

    unless @stacks[stack2].empty?
      raise InvalidMoveError.new if @stacks[stack1].last > @stacks[stack2].last
    end

    disk = @stacks[stack1].pop
    @stacks[stack2] << disk
  end

  def won?
    @stacks[0].empty? && (@stacks[1].count == 3 || @stacks[2].count == 3)
  end

  def get_move
    puts "Please enter your move"
    input = gets.chomp
    move = input.split(',').map!(&:to_i)
    raise InvalidMoveError.new unless move.all? { |num| num.between?(0,2) }
    raise InvalidMoveEror.new unless move.count == 2
    move
  end

end

class Array
  def my_transpose
    columns = Array.new(self.length) {Array.new(self.length)}

    self.length.times do |i|
      self.length.times do |j|
        columns[i][j] = self[j][i]
      end
    end

    columns
  end
end
