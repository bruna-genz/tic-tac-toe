# frozen_string_literal: true

require "./lib/game.rb"
require "./lib/player.rb"
require "./lib/board.rb"

RSpec.describe Game do

  let(:player1) { Player.new("Player1", "X") }
  let(:player2) { Player.new("Player2", "O") }
  let(:board) { Board.new }
  let(:game) { Game.new(player1, player2, board) }
  let(:player_double1) { double("player_double1") }
  let(:player_double2) { double("player_double2") }
  let(:game_double) { Game.new(player_double1, player_double2, board) }
  let(:board_double) { Board.new }

  describe "#ask_position" do
    context "when is Player 1's turn" do
      it "shows Player 1 name" do
        allow(player_double1).to receive(:name) { "Double Player1" }
        expect(game_double.ask_position).to eql("Double Player1, your turn. Choose an available position between 1 to 9.")
      end
    end

    context "when is Player 2's turn" do
      it "shows Player 2 name" do
        allow(player_double1).to receive(:mark) { "X" }
        allow(player_double2).to receive(:name) { "Double Player2" }
        allow(player_double2).to receive(:mark) { "O" }
        game_double.play(1)
        expect(game_double.ask_position).to eql("Double Player2, your turn. Choose an available position between 1 to 9.")
      end
    end
  end

  describe "#valid?" do
    it "returns false when the user input is not in the range 1..9" do
      expect(game_double.valid?(11)).to eql(false)
    end
  end

  describe "#win?" do
    it "returns true when a player's moves are included in winning combinations" do
      allow(player_double1).to receive(:mark) { "X" }
      allow(player_double2).to receive(:mark) { "O" }
      game_double.play(1)
      game_double.play(4)
      game_double.play(2)
      game_double.play(7)
      game_double.play(3)
      game_double.play(9)

      expect(game_double.win?).to eql(true)
    end
  end

  describe "#draw?" do
    it "returns true when the board is full" do
      game.play(1)
      game.play(5)
      game.play(3)
      game.play(7)
      game.play(8)
      game.play(9)
      game.play(4)
      game.play(2)
      game.play(6)
      expect(game.draw?).to eql(true)
    end
  end
end
