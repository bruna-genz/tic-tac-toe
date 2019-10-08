# frozen_string_literal: false

class Board
  attr_reader :board, :mark

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
