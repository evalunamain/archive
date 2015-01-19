class Hand

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def rank_hand
    return 10 if royal_flush?
    return 9 if straight_flush?
    return 8 if four_of_a_kind?
    return 7 if full_house?
    return 6 if flush?
    return 5 if straight?
    return 4 if three_of_a_kind?
    return 3 if two_pair?
    return 2 if one_pair?
    return 1 if high_card?
  end

  def compare_hand(other_hand)
    case self.rank_hand <=> other_hand.rank_hand
    when 1
      return "better"
    when 0
      return "tie"
    when -1
      return "worse"
    end
  end

  def royal_flush?
    return false unless straight_flush?
    values = cards.map{ |card| card.value }

    values.include?(:king) && values.include?(:ace)
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    card_counts.values.include?(4)
  end

  def full_house?
    card_counts.values.include?(2) &&
    card_counts.values.include?(3)
  end

  def flush?
    suit = cards.first.suit
    cards.all? {|card| card.suit == suit }
  end

  def straight?
    values = cards.map{ |card| card.ranking }
    first = values.sort!.first
    range = (first..first + 4).to_a
    values == range
  end

  def three_of_a_kind?
    card_counts.values.include?(3) && !full_house?
  end

  def two_pair?
    card_counts.values.count(2) == 2
  end

  def one_pair?
    card_counts.values.include?(2) && !two_pair?
  end

  def high_card?
    card_counts.values.all?{ |count| count == 1} && !flush?
  end

  private
  def card_counts
    counts = Hash.new(0)

    self.cards.each do |card|
      counts[card.value] += 1
    end

    counts
  end

end
