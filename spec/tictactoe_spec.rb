# frozen_string_literal: true

require "./lib/game.rb"
require "./lib/player.rb"
require "./lib/board.rb"
require "./lib/rules.rb"

RSpec.describe Rules do
  let(:rules_text) do
    "Ok, then. The board has a 3x3 grid. Each board space is represented by a number from 1 to 9, like that:

                               1 | 2 | 3
                              -----------
                               4 | 5 | 6
                              -----------
                               7 | 8 | 9

  Each player will be represented by a mark, X and O.
  Every round, the players will choose between an available position.
  The player who suceeds in placing three of their marks in a horizontal, vertical, or diagonal row wins the game.
  Enough talk, type OK to start the game!" 
  end

  describe "#display_rules" do
    context "when answer is yes" do
      it "displays game rules" do
        expect(Rules.new("yes").display_rules).to eql(rules_text)
      end
    end

    context "when answer is no" do
      it "displays a message to continue" do
        expect(Rules.new("no").display_rules).to eql("Alright, let's start the game then. Type OK to continue.")
      end
    end

    context "when answer isn't yes or no" do
      it "displays a message asking to answer yes or no" do
        expect(Rules.new("no rules please").display_rules).to eql('Please, type yes or no.')
      end
    end
  end
end

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

  describe "#mark_position" do
    context "when Player 1 chooses a position" do
      it "places player 1's mark on board's array" do
        board_double.mark_position(4, "X")
        expect(board_double.board).to eql(['   ', '   ', '   ', '   ', ' X ', '   ', '   ', '   ', '   '])
      end
    end

    context "when Player 2 chooses a position" do
      it "places player 2's mark on board's array" do
        board_double.mark_position(4, "X")
        board_double.mark_position(7, "O")
        expect(board_double.board).to eql(['   ', '   ', '   ', '   ', ' X ', '   ', '   ', ' O ', '   '])
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
