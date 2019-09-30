#!/usr/bin/env ruby

# frozen_string_literal: true

require './lib/game_logic.rb'

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

=begin ----- this must be on game_logic -------
game_on = true if gets.chomp == "OK" || "ok"
position_taken = false # later it will have a method that changes this variable
winner_combination = false # later it will have a method that changes this variable
board_full = false # later it will have a method that changes this variable
player_turn = "X" # later it will have a method that changes this variable
=end

# the game will start with a loop. It will stop when someone wins or until a draw.

new_board = Board.new if gets.chomp == "ok" || "OK"
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
end




=begin

while player_turn == "X"
    if move_player_X.between?(1, 9) # if the player choose a valid position
        
        unless position_taken # if the player choose an empty position
            if winner_combination # if selected move is a winning move
                game_on = false
                puts "You are the winner! Congradulations!"

                puts " X |   | O "
                puts "-----------"
                puts "   | X | O "
                puts "-----------"
                puts "   |   | X "
            
            elsif board_full # if selected move is a draw move
                game_on = false
                puts "Game over! The board is full. No winners this time!" 

                puts " X | X | O "
                puts "-----------"
                puts " O | X | X "
                puts "-----------"
                puts " X | O | O "

            else # if it is an available position
                player_turn = "O"
                puts "Well done! The selected move is valid, but the game is not over yet." 

                game.play(move_player_X)
                puts game.board.display_board
            end
        
        else # if the player choose a position that is already taken
            player_turn = "X"
            puts "This position is already taken. Please, choose an available position between 1 to 9."
            move_player_X = gets.chomp.to_i
        end

    else # an error message will apperar if a player input is not valid (not between 1 to 9)
        player_turn = "X"
        puts "This move is not valid. Please, choose an available position between 1 to 9." 
        move_player_X = gets.chomp.to_i
    end
end

# when game_on = false asks if want new game

puts "Do you wanna play again? (type yes or no)" if !game_on
new_game = gets.chomp
game_on true if new_game == "yes"

=end


=begin
while game.game_on
    puts game.ask_position 
    puts new_board.display_board if game.turn == 0

    move_player_X = gets.chomp.to_i

    puts game.return_position(move_player_X) 

    game.play(move_player_X)
    puts game.board.display_board
end
=end