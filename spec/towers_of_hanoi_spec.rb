require 'rspec'
require 'towers_of_hanoi.rb'

describe TowersOfHanoi do
  subject(:towers) { TowersOfHanoi.new }

  describe "#stacks" do
    it "initializes the stacks" do
      expect(towers.stacks).to eq([ [3, 2, 1], [], [] ])
    end
  end

  describe "#move" do

    before(:each) do
      towers.move(0,1)
    end

    it "moves a smaller element to a new stack" do
      expect(towers.stacks).to eq([ [3, 2], [1], [] ])
    end

    it "doesn't allow a larger piece to be put on a smaller one" do
      expect {towers.move(0,1)}.to raise_error(InvalidMoveError)
    end

    it "doesn't allow a move from an empty stack" do
      expect {towers.move(2,1)}.to raise_error(InvalidMoveError)
    end

  end

  describe "#won?" do
    before(:each) do
        towers.move(0,2)
        towers.move(0,1)
        towers.move(2,1)
        towers.move(0,2)
        towers.move(1,0)
        towers.move(1,2)
    end

    it "identifies when the game is won" do
      towers.move(0,2)
      expect(towers.won?).to be true
    end

    it "returns false when the game is not over" do
      expect(towers.won?).to be false
    end

  end

  describe "#render" do
    

    it "does not alter stacks" do
      towers.render
      expect(towers.stacks).to eq([ [3, 2, 1], [], [] ])
    end
  end

  describe "#get_move" do
    context "invalid input" do
      it "raises an error on single input" do
        allow(towers).to receive(:gets).and_return("2\n")
        expect {towers.get_move }.to raise_error
      end

      it "raises an error on input out of range" do
        allow(towers).to receive(:gets).and_return("2,5\n")
        expect {towers.get_move }.to raise_error
      end
    end

    context "valid input" do
      it "accepts valid input" do
        allow(towers).to receive(:gets).and_return("1,2\n")
        expect(towers.get_move).to eq([1,2])
      end
    end

  end


end
