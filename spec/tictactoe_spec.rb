# frozen_string_literal: true

require './lib/game.rb'
require './lib/player.rb'
require './lib/board.rb'
require './lib/rules.rb'

RSpec.describe Rules do
  let(:rules_text) do
    'Ok, then. The board has a 3x3 grid. Each board space is represented by a number from 1 to 9, like that:

                               1 | 2 | 3
                              -----------
                               4 | 5 | 6
                              -----------
                               7 | 8 | 9

  Each player will be represented by a mark, X and O.
  Every round, the players will choose between an available position.
  The player who suceeds in placing three of their marks in a horizontal, vertical, or diagonal row wins the game.
  Enough talk, type OK to start the game!'
  end

  describe '#display_rules' do
    context 'when answer is yes' do
      it 'displays game rules' do
        expect(Rules.new('yes').display_rules).to eql(rules_text)
      end
    end

    context 'when answer is no' do
      it 'displays a message to continue' do
        expect(Rules.new('no').display_rules).to eql("Alright, let's start the game then. Type OK to continue.")
      end
    end

    context "when answer isn't yes or no" do
      it 'displays a message asking to answer yes or no' do
        expect(Rules.new('no rules please').display_rules).to eql('Please, type yes or no.')
      end
    end
  end
end

RSpec.describe Game do
  let(:player1) { double('player1') }
  let(:player2) { double('player2') }
  let(:game) { Game.new(player1, player2, board) }
  let(:board) { Board.new }

  describe '#ask_position' do
    context "when is Player 1's turn" do
      it 'shows Player 1 name' do
        allow(player1).to receive(:name) { 'Double Player1' }
        expect(game.ask_position).to eql('Double Player1, your turn. Choose an available position between 1 to 9.')
      end
    end

    context "when is Player 2's turn" do
      it 'shows Player 2 name' do
        allow(player1).to receive(:mark) { 'X' }
        allow(player2).to receive(:name) { 'Double Player2' }
        allow(player2).to receive(:mark) { 'O' }
        game.play(1)
        expect(game.ask_position).to eql('Double Player2, your turn. Choose an available position between 1 to 9.')
      end
    end
  end

  describe '#mark_position' do
    context 'when Player 1 chooses a position' do
      it "places player 1's mark on board's array" do
        board.mark_position(4, 'X')
        expect(board.board).to eql(['   ', '   ', '   ', '   ', ' X ', '   ', '   ', '   ', '   '])
      end
    end

    context 'when Player 2 chooses a position' do
      it "places player 2's mark on board's array" do
        board.mark_position(4, 'X')
        board.mark_position(7, 'O')
        expect(board.board).to eql(['   ', '   ', '   ', '   ', ' X ', '   ', '   ', ' O ', '   '])
      end
    end
  end

  describe '#display_board' do
    let(:board_player1) do
      "   |   |   \n" \
      "-----------\n" \
      "   | X |   \n" \
      "-----------\n" \
      '   |   |   '
    end

    let(:board_player2) do
      "   |   |   \n" \
      "-----------\n" \
      "   | X |   \n" \
      "-----------\n" \
      '   |   | O '
    end

    context 'when Player 1 choose an empty space' do
      it "displays the board with Player 1's mark on the chosen position" do
        allow(player1).to receive(:mark) { 'X' }
        game.play(5)
        expect(board.display_board).to eql(board_player1)
      end
    end

    context 'when Player 2 choose an empty space' do
      it "displays the board with Player 2's mark on the chosen position" do
        allow(player1).to receive(:mark) { 'X' }
        allow(player2).to receive(:mark) { 'O' }
        game.play(5)
        game.play(9)
        expect(board.display_board).to eql(board_player2)
      end
    end
  end

  describe '#valid?' do
    context "when user's input is not in the range 1..9" do
      it 'returns false' do
        expect(game.valid?(11)).to eql(false)
      end
    end

    context "when user's input in in the range 1..9" do
      it 'returns true' do
        expect(game.valid?(5)).to eql(true)
      end
    end
  end

  describe '#occupied?' do
    context 'when user choose and empty space' do
      it 'returns false' do
        allow(player1).to receive(:mark) { 'X' }
        allow(player2).to receive(:mark) { 'O' }
        game.play(1)
        game.play(5)
        expect(game.occupied?(7)).to eql(false)
      end
    end

    context 'when user choose and occupied space' do
      it 'returns true' do
        allow(player1).to receive(:mark) { 'X' }
        allow(player2).to receive(:mark) { 'O' }
        game.play(1)
        game.play(5)
        expect(game.occupied?(1)).to eql(true)
      end
    end
  end

  describe '#draw?' do
    it 'returns true when the board is full' do
      allow(player1).to receive(:mark) { 'X' }
      allow(player2).to receive(:mark) { 'O' }
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

    context 'when a player wins in the last possible move' do
      it 'returns false' do
        allow(player1).to receive(:mark) { 'X' }
        allow(player2).to receive(:mark) { 'O' }
        game.play(1)
        game.play(2)
        game.play(3)
        game.play(4)
        game.play(5)
        game.play(7)
        game.play(6)
        game.play(8)
        game.play(9)
        expect(game.draw?).to eql(false)
      end
    end
  end

  describe '#win?' do
    it "returns true when a player's moves are included in winning combinations" do
      allow(player1).to receive(:mark) { 'X' }
      allow(player2).to receive(:mark) { 'O' }
      game.play(1)
      game.play(4)
      game.play(2)
      game.play(7)
      game.play(3)

      expect(game.win?).to eql(true)
    end
  end

  describe '#display_winner' do
    context 'When player 1 wins the game' do
      it "displays the win massage with player 1's name" do
        allow(player1).to receive(:name) { 'Double Player1' }
        allow(player1).to receive(:mark) { 'X' }
        allow(player2).to receive(:name) { 'Double Player2' }
        allow(player2).to receive(:mark) { 'O' }
        game.play(1)
        game.play(4)
        game.play(2)
        game.play(7)
        game.play(3)

        expect(game.display_winner).to eql('Double Player1, you are the winner! Congradulations!')
      end
    end

    context 'When player 2 wins the game' do
      it "displays the win massage with player 2's name" do
        allow(player1).to receive(:name) { 'Double Player1' }
        allow(player1).to receive(:mark) { 'X' }
        allow(player2).to receive(:name) { 'Double Player2' }
        allow(player2).to receive(:mark) { 'O' }
        game.play(9)
        game.play(1)
        game.play(4)
        game.play(2)
        game.play(7)
        game.play(3)

        expect(game.display_winner).to eql('Double Player2, you are the winner! Congradulations!')
      end
    end
  end
end
