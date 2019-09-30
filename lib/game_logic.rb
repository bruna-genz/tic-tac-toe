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

  def initialize
    @turn = 0
    @game_on = true
  end

  def ask_position
    player_name = turn.even? ? player_1.name : player_2.name
    "#{player_name}, your turn. Choose an available position between 1 to 9."
  end

  def return_position(user_input)
    if user_input.between?(1, 9)
      'Well done! The selected move is valid, but the game is not over yet.'
    else
      'This position is already taken. Please, choose an available position between 1 to 9.' # how to take user input???
      play(user_input)
    end
  end

  def play(user_input)
    index = user_input - 1
    player_mark = turn.even? ? player_1.mark : player_2.mark

    board.mark_position(index, player_mark)

    @turn += 1
  end
end