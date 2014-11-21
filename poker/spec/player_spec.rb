require 'rspec'
require 'player.rb'
require 'card.rb'

describe Player do
  subject(:player) { Player.new("Frank")}

  let(:hand) { hand = [
        Card.new(:spades, :deuce),
        Card.new(:spades, :three),
        Card.new(:spades, :four),
        Card.new(:spades, :five),
        Card.new(:spades, :six)] }

  describe "#initialize" do
    it "starts with a bankroll of 1000" do
      expect(player.bankroll).to eq(1000)
    end
  end

  describe "#discard" do
    it "removes the selected cards from the player's hand" do
      player.hand = hand
      hand2 = hand.take(2)

      expect(player.discard([0,1])).to eq(hand2)
      expect(player.hand.count).to eq(3)
    end

    it "does not allow for more than 3 cards to be discarded" do

      expect {player.discard([0,1,2,3])}.to raise_error
    end
  end

  describe "#bet" do

    it "removes money from bankroll for a call or raise" do
      player.bet(50)
      expect(player.bankroll).to eq(950)
    end

    it "should raise an error if bet is larger than current bankroll" do
      expect {player.bet(1001)}.to raise_error
    end
  end

  describe "#fold" do
    it "should discard all cards" do
      player.hand = hand
      player.fold
      expect(player.hand).to be_empty
    end
  end

  #   it "discards all cards on a fold"
  # end



end
