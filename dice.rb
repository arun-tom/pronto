require 'json'

file_1 = File.read('rolls_1.json')
rolls_1_data = JSON.parse(file_1)
file_2 = File.read('rolls_2.json')
rolls_2_data = JSON.parse(file_2)


puts rolls_1_data.length
puts rolls_2_data.length