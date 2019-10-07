# frozen_string_literal: true

require "./lib/game.rb"
require "./lib/player.rb"
require "./lib/board.rb"

RSpec.describe Game do  
  before(:each) do
    player1 = Player.new("Player1")
    player1.mark = "X"
    player2 = Player.new("Player2")
    player2.mark = "O"
    
    new_board = Board.new
    game = Game.new(player1, player2)
    game.board = new_board
  end

  describe "#valid?" do
    it "returns false when the user input is not in the range 1..9" do
      expect(game.valid?(11)).to eql(false)
    end
  end

  describe "#win?" do
    game.play(1)
    game.play(4)
    game.play(2)
    game.play(7)
    game.play(3)
    game.play(9)

    it "returns true when a player's moves are included in winning combinations" do
      expect(@game.win?).to eql(true)
    end
  end

  describe "#draw?" do
    game.play(1)
    game.play(5)
    game.play(3)
    game.play(7)
    game.play(8)
    game.play(9)
    game.play(4)
    game.play(2)
    game.play(6)

    it "returns true when the board is full" do
      expect(game.draw?).to eql(true)
    end
  end
end
