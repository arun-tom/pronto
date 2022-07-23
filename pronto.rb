require 'json'
require './board.rb'
require './player.rb'


file = File.read('board.json')
board_data = JSON.parse(file)
file_1 = File.read('rolls_1.json')
$rolls_1_data = JSON.parse(file_1)
file_2 = File.read('rolls_2.json')
$rolls_2_data = JSON.parse(file_2)
$dice_1_index = 0
$dice_2_index = 0

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

#dice = Dice.new



puts $rolls_1_data[1]
puts $rolls_1_data[2]
puts $rolls_2_data[1]
puts $rolls_2_data[2]


def rollDice
# Go through rolls_1.json and rolls_2.json files and returns sum of corresponding elements in each files in every pass.
    rolled_sum = $rolls_1_data[$dice_1_index] + $rolls_2_data[$dice_2_index]
        puts $rolls_1_data[$dice_1_index]
        puts $rolls_2_data[$dice_2_index]
        #puts rolled_sum

    $dice_1_index += 1
    $dice_2_index += 1

    if $dice_1_index >= $rolls_1_data.length
        $dice_1_index = 0
    end

    if $dice_2_index >= $rolls_2_data.length
        $dice_2_index = 0
    end
    return rolled_sum
end

# Infinite loop to continue play the game until operator wishes to exit
while 1
    puts rollDice
    puts $dice_1_index
    puts $dice_2_index
    puts "Press Enter to continue or 'q' to exit"
    string = (gets.chomp().to_s).downcase

    if string == "q"
        break
    end
end





