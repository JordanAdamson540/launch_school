VALID_CHOICES = ['rock', 'paper', 'scissors']

def test_method
  prompt('test message')
end

def prompt(message)
  puts "=> #{message}"
end

def display_results(player, computer)
  if (player == 'rock' && computer == 'scissors') ||
     (player == 'paper' && computer == 'rock') ||
     (player == 'scissors' && computer == 'paper')
    prompt('You Won!')
  elsif (player == 'rock' && computer == 'paper') ||
        (player == 'paper' && computer == 'scissors') ||
        (player == 'scissors' && computer == 'rock')
    prompt('Computer Won!')
  else
    prompt("It's a tie")
  end
end

loop do
  choice = ''
  loop do
    prompt("Select one: #{VALID_CHOICES.join(', ')}.")
    choice = gets.chomp.downcase
    break if VALID_CHOICES.include?(choice)
    prompt("That's not a valid choice.")
  end

  computer_choice = VALID_CHOICES.sample

  prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

  display_results(choice, computer_choice)

  prompt('Do you want to play again?')
  answer = gets.chomp.downcase
  break unless answer.downcase.start_with?('y')
end

prompt('Thank you for playing. Good bye!')