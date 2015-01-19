class Array
  def my_uniq
    array = []
    self.each do |el|
      array << el unless array.include?(el)
    end
    array
  end

  def two_sum
    array = []
    self.length.times do |i|
      (i+1...self.length).each do |j|
        array << [i,j] if self[i] + self[j] == 0
      end
    end

    array
  end

  def my_transpose
    columns = Array.new(self.length) {Array.new(self.length)}

    self.length.times do |i|
      self.length.times do |j|
        columns[i][j] = self[j][i]
      end
    end

    columns
  end

  def stockpicker
    best_pair = nil
    best_profit = 0

    self.length.times do |i|
      (i + 1...self.length).each do |j|
        if self[j] - self[i] > best_profit
          best_pair = [i, j]
          best_profit = self[j] - self[i]
        end
      end
    end

    best_pair

  end

end
