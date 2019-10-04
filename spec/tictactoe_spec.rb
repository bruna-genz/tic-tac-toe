# frozen_string_literal: true

require "./lib/game.rb"

RSpec.describe Game do
  game = Game.new("player1", "player2")
  
  describe "#win?" do
    it "returns true when a player's moves are included in winning combinations" do
      expect(game.win?).to eql(true)
    end
  end

  describe "#draw?" do
    it "returns true when the board is full" do
      game.turn = 9
      expect(game.draw?).to eql(true)
    end

    it "returns true when the board is full" do
      game.turn = 15
      expect(game.draw?).to eql(true)
    end

    it "returns false unless the board is full" do
      game.turn = 15
      expect(game.draw?).to eql(true)
    end
  end
end
