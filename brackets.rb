puts "Enter string with brackets: "

str = gets.chomp
stack = []
symbols = { '{' => '}', '[' => ']', '(' => ')' }

str.each_char do |c|
  stack << c if symbols.key?(c)
  if symbols.key(c) && symbols.key(c) != stack.pop
    puts "false"
    return false
  end
end

if stack.empty?
  puts "true"
  return true
end