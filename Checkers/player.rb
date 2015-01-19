class InputError < StandardError
end

class Player
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def play_turn
    begin
      start_piece = get_input("Enter the coordinates of the piece you want to move.")
    rescue InputError => err
      puts err.message
      retry
    end
    
    move_sequence = []

    loop do
      target = get_input("Where do you want to move it to? Press e to end move sequence.")
      break if target == "e"
      move_sequence << target
    end

    [start_piece, move_sequence]

  end

  def get_input(prompt)
    puts prompt
    input = gets.chomp
    input = parse_input(input)

  end

  def parse_input(input)
    validate_input(input)

    return input if input == "e"
    input.split(",").map(&:to_i)
  end

  def validate_input(input)
    good_input = /\A\d,\d\z/
    end_input = /\A[e]\z/

    unless input =~ good_input || input =~ end_input
      raise InputError.new "Please enter valid coordinates, for example: 2,3, or press e."
    end
  end

end
