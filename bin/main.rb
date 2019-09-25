#! /usr/bin/ruby

# frozen_string_literal: true

puts "Hello, players. Welcome to Tic Tac Toe!"
puts "First player, please, choose between X or O."
player_1 = gets.chomp
puts "Thank you. Now, here is the board. Choose an available position between 1 to 9."
# display board 
move_player_1 = gets.chomp
puts "Well done!"
# display board with position taked
puts "New player, it is your turn. Please, choose an available position between 1 to 9."
move_player_2 = gets.chomp
puts "Nicely done!"
# display board with new position taked



# The following code will repeat until someone wins or until the board is full

puts "Player X, your turn. Please, choose an available position between 1 to 9."
move_player_1 = gets.chomp
puts "Ok, nice."
# display board with new position taked
puts "Player O, it is your time. Please, choose an available position between 1 to 9."
move_player_2 = gets.chomp
puts "Alright."
# display board with new position taked



# When someone wins

puts "Player X, your turn. Please, choose an available position between 1 to 9."
# display board with new position taked
move_player_1 = gets.chomp
puts "You are the winner! Congradulations!"
puts "Game over. Do you wanna play again?"
new_game = gets.chomp



# When board is full and there is no winners

puts "Player O, it is your time. Please, choose an available position between 1 to 9."
# display board with new position taked
move_player_2 = gets.chomp
puts "Game over! The board is full. No winners this time!" 
puts "Do you wanna play again?"
new_game = gets.chomp



# When someone choose an unavailable position

puts "Player X, your turn. Please, choose an available position between 1 to 9."
# display board with new position taked
move_player_1 = gets.chomp
puts "This poisition in not available. Please, choose an available position between 1 to 9."
move_player_1 = gets.chomp