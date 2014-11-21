class Player

  attr_accessor :bankroll, :hand

  def initialize(name, bankroll = 1000)
    @name = name
    @bankroll = bankroll
    @hand = []
  end

  def discard(input)
    #puts "Which cards do you wish to trade?"
    #helper methods to parse input

    raise "" if input.count > 3

    discarded_cards = []

    input.each do |i|
      card = @hand[i]
      discarded_cards << card
    end
    hand.delete_if.with_index { |_, index| input.include? index }
    discarded_cards
  end

  def bet
    #fold, see or raise
  end

  private
  def parse_input(input)
    #transform gets into something useable
  end



end
