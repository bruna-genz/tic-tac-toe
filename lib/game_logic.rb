# frozen_string_literal: false

class Player
  attr_accessor :name, :mark

  def initialize(name)
    @name = name
  end
end

class Board
  attr_accessor :board, :mark

  def initialize
    @board = ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']
  end

  def display_board
     "#{board[0]}|#{board[1]}|#{board[2]}\n" <<
     "-----------\n" << 
     "#{board[3]}|#{board[4]}|#{board[5]}\n" <<
     "-----------\n" <<
     "#{board[6]}|#{board[7]}|#{board[8]}\n"
  end

  def mark_position(index, mark)
    board[index] = ' ' + mark + ' '
  end
end

class Game
  attr_accessor :turn, :player_1, :player_2, :board

  def initialize
    @turn = 0
  end

  def play(user_input)
    index = user_input - 1
    player_mark = turn.even? ? player_1.mark : player_2.mark

    board.mark_position(index, player_mark)

    @turn += 1
  end
end
