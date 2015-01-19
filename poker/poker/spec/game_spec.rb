require 'rspec'
require 'game.rb'

describe Game do
	let(:player1) {double("player1")}
	let(:player2) {double("player2")}
	subject(:game) { Game.new(player1, player2)}
	
	describe "#initialize" do
		it "starts with a full deck" do
			expect(game.deck.count).to eq(52)
		end
		
		it "holds several players" do
			expect(game.players).to eq([player1, player2])
		end
	end
	

end