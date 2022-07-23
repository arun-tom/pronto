require 'json'
require './board.rb'
require './player.rb'
require './dice.rb'


file = File.read('board.json')
board_data = JSON.parse(file)

puts "Hello, Pronto!"

pronto_board = Array.new(9) {Board.new} # Creating an array of nine Board elements.

index = 0
puts pronto_board.length
puts board_data[index]["name"]
puts pronto_board[index].name

# Monopoly board setting up in 'pronto_board' with board.json data.
while index < pronto_board.length
    pronto_board[index].name = board_data[index]["name"]
    pronto_board[index].price = board_data[index]["price"] if board_data[index]["price"] # if price is not 'nil' then copy price from board.json file
    pronto_board[index].colour = board_data[index]["colour"] if board_data[index]["colour"] # if colour is not 'nil' then copy colour from board.json file
    pronto_board[index].type = board_data[index]["type"]
    # pronto_board[index].owner = "owner"
    pronto_board[index].rent = board_data[index]["price"] / 2.0 if board_data[index]["price"] # if rent is not 'nil' then rent = rent/2
    
    index += 1
end

# Verifying Monopoly board
 i =0
while i < 9
    puts pronto_board[i].name
    puts pronto_board[i].type
    puts pronto_board[i].colour
    puts pronto_board[i].price
    puts pronto_board[i].owner
    puts pronto_board[i].rent
    puts "******************"
    puts "\n"

   i += 1
end

# Bringing players into the game...
peter = Player.new("Peter", 1)
billy = Player.new("Billy", 2)
charlotte = Player.new("Charlotte", 3)
sweedal = Player.new("Sweedal", 4)

# Verifying player details
puts peter.name
puts peter.play_order
puts peter.money
puts peter.health
puts "\n"


