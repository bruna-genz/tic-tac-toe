#!/usr/bin/env ruby

# frozen_string_literal: true

require "./lib/game_logic.rb"

puts "Hello, players. Welcome to Tic Tac Toe!"
puts "First player, what is your name?"
player_X = Player.new(gets.chomp)
player_X.mark = "X"
puts "Alright, #{player_X.name}. You're gonna be the X's."
puts "Now, player number 2, what is your name?"
player_O = Player.new(gets.chomp)
player_O.mark = "O"
puts "Ok #{player_O.name}, you're gonna be the O's."

=begin
puts "Do you wanna look at the game rules before start? (type yes or no)"
answer = Rules.new(gets.chomp)
puts answer.display_rules
=end

repeat_game = true

while repeat_game
  new_board = Board.new if gets.chomp == "ok" || "OK"   # TODO fix this
  game = Game.new
  game.board = new_board
  game.player_1 = player_X
  game.player_2 = player_O

  while game.game_on
    puts game.ask_position
    puts new_board.display_board if game.turn == 0 
    move = gets.chomp.to_i

    if game.valid?(move)
      if game.occupied?(move)
        while game.occupied?(move)
          puts "This position is already taken. Please, choose an available position between 1 to 9."
          move = gets.chomp.to_i
        end
      else
        puts "Well done! The selected move is valid, but the game is not over yet."
      end
    else
      until game.valid?(move)
        puts "This move is not valid. Please, choose an available position between 1 to 9."
        move = gets.chomp.to_i
      end
    end

    game.play(move)
    puts game.board.display_board

    if game.draw?
      puts "Game over! The board is full. No winners this time!"
      game.game_on = false
    end

    if game.win?
      puts game.display_winner
      game.game_on = false
    end
  end

  unless game.game_on
    puts "Do you wanna play again? (type yes or no)"
    case gets.chomp
    when "yes"
      puts "you answered yes"
    when "no"
      repeat_game = false
      abort "Ok, see you in the next game!"
    else
      puts "Please write yes or no"
    end
  end
end