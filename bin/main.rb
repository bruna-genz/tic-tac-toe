#!/usr/bin/env ruby

# frozen_string_literal: true

require "./lib/rules.rb"
require "./lib/board.rb"
require "./lib/player.rb"
require "./lib/game.rb"

puts "Hello, players. Welcome to Tic Tac Toe!"
puts "First player, what is your name?"
player_X = Player.new(gets.chomp, "X")
puts "Alright, #{player_X.name}. You're gonna be the X's."
puts "Now, player number 2, what is your name?"
player_O = Player.new(gets.chomp, "O")
puts "Ok #{player_O.name}, you're gonna be the O's."

puts "Do you wanna look at the game rules before start? (type yes or no)"
answer = Rules.new(gets.chomp)
puts answer.display_rules

repeat_game = true

while repeat_game
  new_board = Board.new if gets.chomp == "ok" || "OK"  
  game = Game.new(player_X, player_O, new_board)

  while game.game_on
    puts game.ask_position
    puts new_board.display_board if game.turn == 0 
    move = gets.chomp.to_i

    if game.valid?(move)
      if game.occupied?(move)
        while game.occupied?(move)
          puts "This position is already taken. Please, choose an available position between 1 to 9."
          move = gets.chomp.to_i
          until game.valid?(move)
            puts "This move is not valid. Please, choose an available position between 1 to 9."
            move = gets.chomp.to_i
          end
        end
      else
        puts "Well done! The selected move is valid, but the game is not over yet."
      end
    else
      until game.valid?(move)
        puts "This move is not valid. Please, choose an available position between 1 to 9."
        move = gets.chomp.to_i
        while game.occupied?(move)
          puts "This position is already taken. Please, choose an available position between 1 to 9."
          move = gets.chomp.to_i
        end
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
      puts "One more round then, type OK to continue."
    when "no"
      repeat_game = false
      abort "Ok, see you in the next game!"
    else
      puts "Please write yes or no"
    end
  end
end
