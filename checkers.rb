# encoding: utf-8

require 'colorize'

require './piece.rb'
require './board.rb'
require './player.rb'
require './game.rb'

if __FILE__ == $PROGRAM_NAME
  p1 = Player.new(:black)
  p2 = Player.new(:white)
  g = Game.new(p1, p2)
  g.play
end
