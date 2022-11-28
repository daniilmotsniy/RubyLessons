# $ globals
$game_words = %w[glory to Ukraine]
$current = ""
$lives = 5
$template = ""
$current = $game_words[rand($game_words.length)]
$separated_word = $current.split("", $current.length)

i = 0
while i < $current.length
  if $separated_word[i] === " "
    $template += " "
  elsif $separated_word[i] === "-" then
    $template += "-"
  else
    $template += "_"
  end
  i = i + 1
end

puts $template

def check_template(check_string, user_input)
  k = 0
  j = 0

  matched_digits = []

  while k < check_string.length
    if check_string[k] === user_input
      matched_digits.push k
    elsif !check_string.include?(user_input)
      $lives = $lives - 1
      break
    end
    k = k + 1
  end

  matched_digits.each do |digits|
    $template[digits] = user_input
  end

end


def user_input
  # check lives
  if $lives === 0
    puts "You have no more lives ;( Game over."
    exit
  end

  # check if not _ in word
  unless $template.include?("_")
    puts "Congrats! You have won the game ;)"
    exit
  end

  # user input
  input = gets.chomp

  puts check_template($separated_word, input)

  puts $template
  puts "Lives you have left: #{$lives}"

  user_input
end

user_input