allowed_items = %w[/ * + -]

begin
  puts('Enter the number 1')
  user_value_1 = gets.to_i
rescue TypeError => e
  puts("Logs: #{e}")
end

puts('Enter operation')
operation = gets.chomp
unless allowed_items.include?(operation)
  puts 'Wrong input try one more time with: -, +, *, /'
  return
end

begin
  puts('Enter the number 2')
  user_value_2 = gets.to_i
rescue TypeError => e
  puts("Logs: #{e}")
end

def addition(val1, val2)
  val1+val2
end

add = addition(user_value_1, user_value_2)

def subtraction(val1, val2)
  val1-val2
end

sub = subtraction(user_value_1, user_value_2)

def division(val1, val2)
  val1/val2
end

div = division(user_value_1, user_value_2)

def multiplication(val1, val2)
  val1*val2
end

mult = multiplication(user_value_1, user_value_2)

puts('Result')

if operation == "+"
  puts add
elsif operation == "-"
  puts sub
elsif operation == "/"
  puts div
elsif operation == "*"
  puts mult
else puts "error"
end