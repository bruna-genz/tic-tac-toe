# frozen_string_literal: false

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
