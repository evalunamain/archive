require_relative "deck"

class Game
	
	attr_reader :deck, :players, :pot

	def initialize(*players)
		@players = players
		@deck = Deck.new
		@pot = 0
	end
	
	def play
		play_round until game.over?
		game_over
	end
	
	def play_ground	
		deck.shuffle
		unfold_players
		deal_cards
		take_bets
		(end_round && return) if game_over?
		trade_cards
		take_bets
		end_round
	end
	
	def unfold_players
		players.each(&:unfold)
	end
	
	def deal_cards
	end
	
	def take_bets
	end
	
	def end_round
	end
	
	def game_over?
		
	end
	
	def trade_cards
	end
	
	
		
end
