require_relative 'card'

class CardError < StandardError
end

class Deck

  def fill_deck
    Card.suits.each do |suit|
      Card.values.each do |value|
        cards << Card.new(suit,value)
      end
    end
    nil
  end

  def initialize(fill = true)
    @cards = []
    fill_deck if fill
  end

  def [](num)
    cards[num]
  end

  def count
    cards.count
  end

  def deal(n)
    raise CardError.new if n > cards.count
    cards.shift(n)
  end

  def receive(discards)
    cards.concat(discards)
  end

  def shuffle!
    cards.shuffle!
  end


  private
  attr_reader :cards

end
