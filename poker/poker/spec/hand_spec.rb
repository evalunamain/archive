require 'rspec'
require 'card.rb'
require 'hand.rb'

describe Hand do
  let(:deck_cards) { deck_cards = [
        Card.new(:spades, :deuce),
        Card.new(:spades, :three),
        Card.new(:spades, :four),
        Card.new(:spades, :five),
        Card.new(:spades, :six)] }


  describe "#initialize" do
    it "starts with a 5 card hand" do
      hand = Hand.new(deck_cards)
      expect(hand.cards).to match_array(deck_cards)
    end
  end

  describe "#compare hand" do
    it "returns tie if the hands have equal rank" do
      hand2 = Hand.new(deck_cards)
      hand1 = Hand.new(deck_cards)
      expect(hand1.compare_hand(hand2)).to eq("tie")
    end

    it "returns better if our hand is better than theirs" do
      hand1 = Hand.new(deck_cards)
      hand2 = Hand.new([Card.new(:spades, :nine),
        Card.new(:hearts, :nine),
        Card.new(:clubs, :nine),
        Card.new(:diamonds, :nine),
        Card.new(:spades, :king)])
      expect(hand1.compare_hand(hand2)).to eq("better")
    end

  end

  describe "#royal flush" do
    it "identifies a royal flush" do
      hand = Hand.new([Card.new(:spades, :ten),
        Card.new(:spades, :jack),
        Card.new(:spades, :queen),
        Card.new(:spades, :king),
        Card.new(:spades, :ace)])

      expect(hand.royal_flush?).to be true
    end

    it "doesn't identify a straight as royal" do
      hand = Hand.new([Card.new(:spades, :nine),
        Card.new(:spades, :ten),
        Card.new(:spades, :jack),
        Card.new(:spades, :queen),
        Card.new(:spades, :king)])

      expect(hand.royal_flush?).to be false
    end
  end

  describe "#straight flush" do
    it "identifies a straight flush" do
      hand = Hand.new(deck_cards)
      expect(hand.straight_flush?).to be true
    end

    it "doesn't identify a flush as a straight flush" do
      hand = Hand.new(deck_cards)
      hand.cards[0] = Card.new(:spades, :queen)
      expect(hand.straight_flush?).to be false
    end
  end

  describe "#four of a kind" do
    it "identifies four cards of the same value" do
      hand = Hand.new([Card.new(:spades, :nine),
        Card.new(:hearts, :nine),
        Card.new(:clubs, :nine),
        Card.new(:diamonds, :nine),
        Card.new(:spades, :king)])

      expect(hand.four_of_a_kind?).to be true
    end

  end

  describe "#full house" do
    it "doesn't allow a card to be used more than once (3 of a kind)" do
      hand = Hand.new([Card.new(:spades, :nine),
        Card.new(:hearts, :nine),
        Card.new(:clubs, :nine),
        Card.new(:diamonds, :four),
        Card.new(:spades, :king)])

      expect(hand.full_house?).to be false
    end

    it "correctly identifies a full house" do
      hand = Hand.new([Card.new(:spades, :nine),
        Card.new(:hearts, :nine),
        Card.new(:clubs, :nine),
        Card.new(:diamonds, :king),
        Card.new(:spades, :king)])

      expect(hand.full_house?).to be true
    end

  end

  describe "#flush" do
    it "identifies when all 5 cards are the same suit" do
      hand = Hand.new(deck_cards)
      expect(hand.flush?).to be true
    end

    it "ensures that ALL 5 cards are the same suit" do
      hand = Hand.new(deck_cards)
      hand.cards[3] = Card.new(:hearts, :queen)
      expect(hand.flush?).to be false
    end

  end

  describe "#straight" do
    it "ensures all 5 cards are in a row" do
      hand = Hand.new(deck_cards)
      hand.cards[0] = Card.new(:spades, :queen)
      expect(hand.straight?).to be false
    end

    it "lets the ace be the low card in a straight"

  end

  describe "#two pair" do
    it "doesn't identify four of a kind as two pair" do
      hand = Hand.new([Card.new(:spades, :nine),
        Card.new(:hearts, :nine),
        Card.new(:clubs, :nine),
        Card.new(:diamonds, :nine),
        Card.new(:spades, :king)])

      expect(hand.two_pair?).to be false
    end

    it "correctly identifies two pair" do
      hand = Hand.new([Card.new(:spades, :nine),
        Card.new(:hearts, :nine),
        Card.new(:clubs, :three),
        Card.new(:diamonds, :king),
        Card.new(:spades, :king)])

      expect(hand.two_pair?).to be true
    end
  end

  describe "#high card" do
    it "identifies a high card" do
      hand = Hand.new([Card.new(:spades, :nine),
        Card.new(:spades, :ten),
        Card.new(:spades, :deuce),
        Card.new(:hearts, :five),
        Card.new(:spades, :king)])

      expect(hand.high_card?).to be true
    end

    it "only identifies a high card if its not part of anything else" do
      hand = Hand.new([Card.new(:spades, :nine),
        Card.new(:spades, :ten),
        Card.new(:spades, :deuce),
        Card.new(:hearts, :king),
        Card.new(:spades, :king)])

      expect(hand.high_card?).to be false
    end
  end

  describe "#ranks hand" do
    it "awards a royal flush the highest value" do
      hand = Hand.new([Card.new(:spades, :ten),
        Card.new(:spades, :jack),
        Card.new(:spades, :queen),
        Card.new(:spades, :king),
        Card.new(:spades, :ace)])

        expect(hand.rank_hand).to eq(10)
    end

    it "awards a high card the lowest value" do
      hand = Hand.new([Card.new(:spades, :nine),
        Card.new(:spades, :ten),
        Card.new(:spades, :deuce),
        Card.new(:hearts, :five),
        Card.new(:spades, :king)])

        expect(hand.rank_hand).to eq(1)
    end
  end

end
