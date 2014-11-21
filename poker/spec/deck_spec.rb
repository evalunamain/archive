require 'rspec'
require 'deck.rb'

describe Deck do
  subject(:deck) { Deck.new }

  context "initialize" do
    it "starts with full stack" do
      expect(deck.count).to eq(52)
    end
  end

  describe "count" do
    it "returns the current number of cards in the deck" do
      expect(deck.count).to eq(52)
    end
  end
end
