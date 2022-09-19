puts 'Enter your item'

user_input = nil

allowed_items = %w[stone paper scissors]

while user_input.nil?
  user_input = STDIN.gets.chomp.downcase
end

unless allowed_items.include?(user_input)
  puts 'Wrong input try one more time with: stone, paper, scissors'
  return
end

puts "You selected #{user_input}"

bot_selected = allowed_items.sample
puts "Your opponent selected #{bot_selected}"

if user_input == 'stone' && bot_selected == 'scissors'
  puts 'You won!'
elsif user_input == 'stone' && bot_selected == 'paper'
  puts 'You won!'
elsif user_input == 'scissors' && bot_selected == 'stone'
  puts 'You lost!'
elsif user_input == 'scissors' && bot_selected == 'paper'
  puts 'You won!'
elsif user_input == 'paper' && bot_selected == 'scissors'
  puts 'You lost!'
elsif user_input == 'paper' && bot_selected == 'stone'
  puts 'You lost!'
else
  puts 'Draw'
end