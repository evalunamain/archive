require 'rspec'
require 'deck.rb'

describe Deck do
  subject(:deck) { Deck.new }

  context "initialize" do
    it "starts with full stack" do
      expect(deck.count).to eq(52)
    end
  end

  describe "#count" do
    it "returns the current number of cards in the deck" do
      expect(deck.count).to eq(52)
    end
  end


  describe "#deal" do
    it "deals out number of cards from front of deck" do
      second_card = deck[1]
      deck.deal(1)
      expect(deck[0]).to eq(second_card)
      expect(deck.count).to eq(51)
    end

    it "doesn't deal out more cards than it has" do
      expect {deck.deal(60)}.to raise_error
    end
  end

  describe "#receive" do
    it "adds cards to the deck" do
      deck.receive([1,2])
      expect(deck.count).to eq(54)
    end

    it "adds cards to the bottom of the deck" do
      first_card = deck[0]
      deck.receive([2,5])
      expect(deck[0]).to eq(first_card)
      expect(deck[-2..-1]).to eq([2,5])
    end
  end

  describe "#shuffle!" do
    it "should shuffle all cards" do
      first_card, last_card = deck[0], deck[-1]
      deck.shuffle!
      expect(deck[0]).to_not eq(first_card)
      expect(deck[-1]).to_not eq(last_card)
    end
  end

end
