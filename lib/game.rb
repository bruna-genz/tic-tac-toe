# frozen_string_literal: false

class Game
  attr_accessor :turn, :board, :game_on
  attr_reader :player1, :player2, :moves_player1, :moves_player2, :win_combinations

  def initialize(player1, player2)
    @turn = 0
    @game_on = true
    @player1 = player1
    @player2 = player2
    @moves_player1 = []
    @moves_player2 = []
    @win_combinations = [[0, 1, 2],
                         [3, 4, 5],
                         [6, 7, 8],
                         [0, 3, 6],
                         [1, 4, 7],
                         [2, 5, 8],
                         [2, 4, 6],
                         [0, 4, 8]]
  end

  def ask_position
    player_name = turn.even? ? player1.name : player2.name
    "#{player_name}, your turn. Choose an available position between 1 to 9."
  end

  def valid?(user_input)
    user_input.between?(1, 9)
  end

  def play(user_input)
    index = user_input - 1
    player_mark = turn.even? ? player1.mark : player2.mark

    board.mark_position(index, player_mark)
    moves(index)

    @turn += 1
  end

  def moves(index)
    if turn.even?
      moves_player1 << index
    else
      moves_player2 << index
    end
  end

  def occupied?(user_input)
    index = user_input - 1
    moves_player1.include?(index) || moves_player2.include?(index)
  end

  def draw?
    if win?
      false
    else
      turn >= 9
    end
  end

  def win?
    result = false
    i = 0
    while i < win_combinations.length
      if (win_combinations[i] & moves_player1) == win_combinations[i] ||
         (win_combinations[i] & moves_player2) == win_combinations[i]
        result = true
        break
      end
      i += 1
    end
    result
  end

  def display_winner
    player_name = turn.even? ? player2.name : player1.name
    "#{player_name}, you are the winner! Congradulations!"
  end
end
