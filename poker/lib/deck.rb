require_relative 'card'

class Deck




  def fill_deck
    @cards = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        @cards << Card.new(suit,value)
      end
    end
    nil
  end

  def initialize
    fill_deck
  end

  def count
    @cards.count
  end

  def deal(n)

  end


  private
  attr_reader :cards

end
