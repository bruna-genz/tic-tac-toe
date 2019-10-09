# frozen_string_literal: true

require "./lib/game.rb"
require "./lib/player.rb"
require "./lib/board.rb"

RSpec.describe Game do

  let(:player_double1) { double("player_double1") }
  let(:player_double2) { double("player_double2") }
  let(:game_double) { Game.new(player_double1, player_double2, board_double) }
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
    context "when user's input is not in the range 1..9" do
      it "returns false" do
        expect(game_double.valid?(11)).to eql(false)
      end
    end

    context "when user's input in in the range 1..9" do
      it "returns true" do
        expect(game_double.valid?(5)).to eql(true)
      end
    end
  end

  describe "#occupied?" do
    context "when user choose and empty space" do
      it "returns false" do
        allow(player_double1).to receive(:mark) { "X" }
        allow(player_double2).to receive(:mark) { "O" }
        game_double.play(1)
        game_double.play(5)
        expect(game_double.occupied?(7)).to eql(false)
      end
    end

    context "when user choose and occupied space" do
      it "returns true" do
        allow(player_double1).to receive(:mark) { "X" }
        allow(player_double2).to receive(:mark) { "O" }
        game_double.play(1)
        game_double.play(5)
        expect(game_double.occupied?(1)).to eql(true)
      end
    end
  end

  describe "#draw?" do
    it "returns true when the board is full" do
      allow(player_double1).to receive(:mark) { "X" }
      allow(player_double2).to receive(:mark) { "O" }
      game_double.play(1)
      game_double.play(5)
      game_double.play(3)
      game_double.play(7)
      game_double.play(8)
      game_double.play(9)
      game_double.play(4)
      game_double.play(2)
      game_double.play(6)
      expect(game_double.draw?).to eql(true)
    end

    context "when a player wins in the last possible move" do
      it "returns false" do
        allow(player_double1).to receive(:mark) { "X" }
        allow(player_double2).to receive(:mark) { "O" }
        game_double.play(1)
        game_double.play(2)
        game_double.play(3)
        game_double.play(4)
        game_double.play(5)
        game_double.play(7)
        game_double.play(6)
        game_double.play(8)
        game_double.play(9)
        expect(game_double.draw?).to eql(false)
      end
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

      expect(game_double.win?).to eql(true)
    end
  end

  describe "#display_winner" do 
    context "When player 1 wins the game" do
      it "displays the win massage with player 1's name" do
        allow(player_double1).to receive(:name) { "Double Player1" }
        allow(player_double1).to receive(:mark) { "X" }
        allow(player_double2).to receive(:name) { "Double Player2" }
        allow(player_double2).to receive(:mark) { "O" }
        game_double.play(1)
        game_double.play(4)
        game_double.play(2)
        game_double.play(7)
        game_double.play(3)

        expect(game_double.display_winner).to eql("Double Player1, you are the winner! Congradulations!")
      end
    end

    context "When player 2 wins the game" do
      it "displays the win massage with player 2's name" do
        allow(player_double1).to receive(:name) { "Double Player1" }
        allow(player_double1).to receive(:mark) { "X" }
        allow(player_double2).to receive(:name) { "Double Player2" }
        allow(player_double2).to receive(:mark) { "O" }
        game_double.play(9)
        game_double.play(1)
        game_double.play(4)
        game_double.play(2)
        game_double.play(7)
        game_double.play(3)

        expect(game_double.display_winner).to eql("Double Player2, you are the winner! Congradulations!")
      end
    end
  end
end
