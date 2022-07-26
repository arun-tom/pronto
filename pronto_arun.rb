
# Arun Thomas
# Pronto Woven coding challenge - play the game of Woven Monopoly.
# Rent is assumed to be half of the property price
# Coded in Ruby. To execute, type "ruby pronto_arun.rb" in the terminal and follow the prompts....

require 'json'
require './board.rb'
require './player.rb'

# Getting JSON files and data
file = File.read('board.json')
board_data = JSON.parse(file)
file_1 = File.read('rolls_1.json')
$rolls_1_data = JSON.parse(file_1)
file_2 = File.read('rolls_2.json')
$rolls_2_data = JSON.parse(file_2)
$dice_1_index = 0
$dice_2_index = 0
$winning_amount = 0

puts "\n"
puts "Hello, Pronto! Woven Monopoly coding challenge"
puts "\n"

pronto_board = Array.new(9) {Board.new}
# Creating an array of nine Board elements.

index = 0
while index < pronto_board.length
# Monopoly board setting up in 'pronto_board' with board.json data.

    pronto_board[index].name = board_data[index]["name"]
    pronto_board[index].price = board_data[index]["price"] if board_data[index]["price"]
    # if price is not 'nil' then copy price from board.json file
    pronto_board[index].colour = board_data[index]["colour"] if board_data[index]["colour"]
    # if colour is not 'nil' then copy colour from board.json file
    pronto_board[index].type = board_data[index]["type"]
    pronto_board[index].rent = board_data[index]["price"] / 2.0 if board_data[index]["price"]
    # if rent is not 'nil' then rent = price/2
    
    index += 1
end

players = [
# Creating players
    Player.new("Peter", 0),
    Player.new("Billy", 1),
    Player.new("Charlotte", 2),
    Player.new("Sweedal", 3)
]

def ownMultipleProperties(boards, colour, owner)
# Checking if a player owns multiple properties of same colour. Returns boolean
    count = 0
    for board in boards do
        if ((board.colour != nil) && (board.colour == colour))
            # checking colour
            if board.owner == owner
                # checking if it is the same owner
                count += 1
            end
        end
    end
    return true if count > 1
return false
end

def rollDice
# Select rolls_1.json, rolls_2.json, both files or random dice for playing.

    case $option

    when 3
        rolled_sum = $rolls_1_data[$dice_1_index] + $rolls_2_data[$dice_2_index]

        puts "Dice rolled is #{rolled_sum}"

        $dice_1_index += 1
        $dice_2_index += 1
    
        if $dice_1_index >= $rolls_1_data.length # checking for overflow
            $dice_1_index = 0
        end
    
        if $dice_2_index >= $rolls_2_data.length # checking for overflow
            $dice_2_index = 0
        end

    when 1
        rolled_sum = $rolls_1_data[$dice_1_index]

        puts "Dice rolled is #{rolled_sum}"

        $dice_1_index += 1

        if $dice_1_index >= $rolls_1_data.length
            $dice_1_index = 0
        end

    when 2
        rolled_sum = $rolls_2_data[$dice_2_index]

        puts "Dice rolled is #{rolled_sum}"

        $dice_2_index += 1

        if $dice_2_index >= $rolls_2_data.length
            $dice_2_index = 0
        end

    else
        random = Random.new
        rolled_sum = random.rand(2..12)
        # Generating random number from 2 to 12 both inclusive

        puts "Dice rolled is #{rolled_sum}"

    end
    return rolled_sum
end

# User select option to choose different dice rolling option
    puts "Enter an option"
    puts "1 - Load dice from rolls_1.json"
    puts "2 - Load dice from rolls_2.json"
    puts "3 - Load dice from both json files"
    puts "Anything - Play with random dice numbers"
    puts "\n"
    $option = gets.chomp().to_i
    puts "\n"

while 1
# Infinite loop to continue play the game until operator wishes to exit

    for player in players do

        puts "#{player.name} is playing now"

        current_location = player.location
        current_location += rollDice
        # rolling dice

        if current_location > (pronto_board.length - 1)
            # means the player has went past 'GO'
            current_location = current_location.remainder(pronto_board.length)
            # so remainder is the current location.
            player.money += 1
            # player gets extra $1 everytime pass GO
            puts "#{player.name} has recieved $1 from passing GO"
        end

        player.location = current_location
            
        if  !pronto_board[current_location].owner && (current_location != 0)
            # Buy this property if this is not occupied and is not GO

            pronto_board[current_location].owner = player.index
            player.money -= pronto_board[current_location].price

            puts "#{player.name} bought #{pronto_board[current_location].name} for $#{pronto_board[current_location].price}"

        elsif (current_location != 0) && (player.name != players[pronto_board[current_location].owner].name)
            # Pay rent if this board is not owned by this player and is not GO
                
            rent = pronto_board[current_location].rent

            if ownMultipleProperties(pronto_board, pronto_board[current_location].colour, pronto_board[current_location].owner)
                # checking if the owner has multiple properties of same colour
                rent = rent * 2
            end
                
            players[pronto_board[current_location].owner].money += rent
            player.money -= rent

            puts "#{player.name} paid $#{rent} to #{players[pronto_board[current_location].owner].name} as rent"
        end

        puts "#{player.name} is at #{pronto_board[current_location].name} (#{pronto_board[current_location].colour})"
        puts "Current board owner is #{players[pronto_board[current_location].owner].name}" if pronto_board[current_location].owner != nil
        puts "#{player.name} has $#{player.money}"
        puts "\n"

        if player.money > $winning_amount
            $winning_amount = player.money
            winner = player.name
        end

        if player.money < 0
            puts "#{player.name} is bankrupt"
            puts "#{winner} is the winner with $#{$winning_amount} in hand"
            $winning_amount = 0
            exit
        end
    end

    puts "Enter to continue or 'q' to exit"
    string = (gets.chomp().to_s).downcase
    puts "$$$$$$$$A$$$$$$$$R$$$$$$$$U$$$$$$$$$$N$$$$$$$$$"
    puts "\n"
    if string == "q"
        break
    end
end
