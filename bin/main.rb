#! /usr/bin/ruby

# frozen_string_literal: true

puts "Hello, players. Welcome to Tic Tac Toe!"
puts "First player, what is your name?"
player_1 = gets.chomp
puts "Alright, #{player_1}. You're gonna be the X's."
puts "Now, player number 2, what is your name?"
palyer_2 = gets.chomp
puts "Ok #{palyer_2}, you're gonna be the O's."
puts "Do you wanna look at the game rules before start? (type yes or no)"
show_rules = true if gets.chomp == "yes"
game_on = true

# if wants to see the rules

show_rules = true
puts "Ok, then. The board has a 3x3 grid. Each board space is represented by a number from 1 to 9, like that:"
puts " 1 | 2 | 3 "
puts "-----------"
puts " 4 | 5 | 6 "
puts "-----------"
puts " 7 | 8 | 9 "
puts "Each player will be represented by a mark, X and O. Every round, the players will choose between an available position."
puts "The player who suceeds in placing three of their marks in a horizontal, vertical, or diagonal row wins the game."
puts "Enough talk, let's start the game!"
game_on = true

# the game will start with a loop. It will stop when someone wins or until a draw.

puts "#{player_1}, your turn. Choose an available position between 1 to 9."

puts "   |   |   "
puts "-----------"
puts "   |   |   "
puts "-----------"
puts "   |   |   "

move_player_1 = gets.chomp.to_i
puts "Well done! The selected move is valid, but the game is not over yet." if move_player_1.between?(1, 9)

puts "   |   |   "
puts "-----------"
puts "   | X |   "
puts "-----------"
puts "   |   |   "

puts "#{palyer_2}, your turn. Please, choose an available position between 1 to 9."
move_player_2 = gets.chomp.to_i
puts "Nicely done! The selected move is valid, but the game is not over yet." if move_player_2.between?(1, 9)

puts "   |   | O "
puts "-----------"
puts "   | X |   "
puts "-----------"
puts "   |   |   "


# an error message will apperar if a player input is not valid (not between 1 to 9)

puts "#{player_1}, your turn. Choose an available position between 1 to 9."
move_player_1 = gets.chomp.to_i
puts "This move is not valid. Please, choose an available position between 1 to 9." unless move_player_1.between?(1, 9) || move_player_2.between?(1, 9)
move_player_1 = gets.chomp.to_i

# an error message will apperar if someone choose an unavailable position

puts "#{palyer_2}, your turn. Please, choose an available position between 1 to 9."
move_player_1 = gets.chomp.to_i
puts "This poisition is already taken. Please, choose an available position between 1 to 9."
move_player_1 = gets.chomp.to_i

# When someone wins

puts "#{player_1}, your turn. Please, choose an available position between 1 to 9."
move_player_1 = gets.chomp.to_i

game_on = false
puts "You are the winner! Congradulations!"

puts " X |   | O "
puts "-----------"
puts "   | X | O "
puts "-----------"
puts "   |   | X "

# When it is a draw

puts "#{player_1}, your turn. Please, choose an available position between 1 to 9."
move_player_2 = gets.chomp.to_i

game_on = false
puts "Game over! The board is full. No winners this time!" 

puts " X | X | O "
puts "-----------"
puts " O | X | X "
puts "-----------"
puts " X | O | O "

# when game_on = false asks if want new game

puts "Do you wanna play again? (type yes or no)"
new_game = gets.chomp
game_on true if new_game == "yes"

