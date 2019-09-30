# frozen_string_literal: false

class Player
  attr_accessor :name, :mark

  def initialize(name)
    @name = name
  end
end

class Rules
  attr_reader :answer

  def initialize(answer)
    @answer = answer
  end

  def display_rules
    case answer
    when 'yes'
      result = "Ok, then. The board has a 3x3 grid. Each board space is represented by a number from 1 to 9, like that:

                              1 | 2 | 3
                            -----------
                              4 | 5 | 6
                            -----------
                              7 | 8 | 9

Each player will be represented by a mark, X and O.
Every round, the players will choose between an available position.
The player who suceeds in placing three of their marks in a horizontal, vertical, or diagonal row wins the game.
Enough talk, type OK to start the game!"
    when 'no'
      result = "Alright, let's start the game then. Type OK to continue."
    else
      result = 'Please, type yes or no.'
    end
    result
  end
end

class Board
  attr_accessor :board, :mark

  def initialize
    @board = ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']
  end

  def display_board
    "#{board[0]}|#{board[1]}|#{board[2]}\n" \
    "-----------\n" \
    "#{board[3]}|#{board[4]}|#{board[5]}\n" \
    "-----------\n" \
    "#{board[6]}|#{board[7]}|#{board[8]}\n"
  end

  def mark_position(index, mark)
    board[index] = ' ' + mark + ' '
  end
end

class Game
  attr_accessor :turn, :player_1, :player_2, :board, :game_on
  attr_reader :moves_player1, :moves_player2

  def initialize
    @turn = 0
    @game_on = true
    @moves_player1 = []
    @moves_player2 = []
  end

  def ask_position
    player_name = turn.even? ? player_1.name : player_2.name
    "#{player_name}, your turn. Choose an available position between 1 to 9."
  end

  def valid?(user_input)
    user_input.between?(1, 9)
  end

  def play(user_input)
    index = user_input - 1
    player_mark = turn.even? ? player_1.mark : player_2.mark

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
end
