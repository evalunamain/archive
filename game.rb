class InvalidMoveError < StandardError
end

class Game

  def initialize(player1, player2, size = 8)
    @players = [player1, player2]
    @board = Board.new(size)
  end

  def play
    until over?
      @players.each do |current_player|
        system "clear"
        @board.display
        puts "It is #{current_player.color}'s turn!"
        begin
          move = current_player.play_turn
          make_move(move, current_player.color)
        rescue InvalidMoveError => err
          puts err.message
          retry
        rescue InputError => err
          puts err.message
          retry
        end
      end
    end

  end

  def make_move(move, color)
    start_piece = move[0]
    move_sequence = move[1]

    if @board[(start_piece)].nil?
      raise InvalidMoveError.new "You selected an empty square."
    end

    unless @board[(start_piece)].color == color
      raise InvalidMoveError.new "Please select one of your own pieces."
    end

    @board[start_piece].perform_moves(move_sequence)
  end

  def over?
    @board.pieces.empty?
  end
end
