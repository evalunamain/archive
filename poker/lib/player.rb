class Player

  attr_accessor :bankroll, :hand

  def initialize(name, bankroll = 1000)
    @name = name
    @bankroll = bankroll
    @hand = []
  end

  def get_input
    #write later, this is annoying right now
  end

  def discard(input)
    raise "" if input.count > 3

    discarded_cards = []

    input.each do |i|
      card = @hand[i]
      discarded_cards << card
    end
    hand.delete_if.with_index { |_, index| input.include? index }
    discarded_cards
  end

  def bet(amount)
    raise "NO" if amount > bankroll
    #is see and raise
    
    self.bankroll -= amount
    amount
  end

  def fold
    @hand.shift(5)
  end

  private
  def parse_input(input)
    #transform gets into something useable
  end



end
