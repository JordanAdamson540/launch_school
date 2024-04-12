VALID_CHOICES = ['rock', 'paper', 'scissors', 'spock', 'lizard']

def prompt(phrase)
  puts "=> #{phrase}"
end

def one_letter_s_given?(response)
  /^[s]$/i.match?(response)
end

def shorthand_for_rock_paper_lizard?(response)
  return true if shorthand_rock_checker?(response)
  return true if shorthand_paper_checker?(response)
  return true if shorthand_lizard_checker?(response)
  false
end

def shorthand_for_spock_or_scissors?(response)
  return true if shorthand_spock_checker?(response)
  return true if shorthand_scissors_checker?(response)
  false
end

def shorthand_for_rock_paper_scissors_lizard_spock?(response)
  return true if shorthand_spock_checker?(response)
  return true if shorthand_scissors_checker?(response)
  return true if shorthand_rock_checker?(response)
  return true if shorthand_paper_checker?(response)
  return true if shorthand_lizard_checker?(response)
  false
end

def shorthand_spock_checker?(response)
  return true if /^sp$/i.match?(response)
  return true if /^spo$/i.match?(response)
  return true if /^spoc$/i.match?(response)
  false
end

def shorthand_scissors_checker?(response)
  return true if /^sc$/i.match?(response)
  return true if /^sci$/i.match?(response)
  return true if /^scis$/i.match?(response)
  return true if /^sciss$/i.match?(response)
  return true if /^scisso$/i.match?(response)
  return true if /^scissor$/i.match?(response)
  false
end

def shorthand_rock_checker?(response)
  return true if /^r$/i.match?(response)
  return true if /^ro$/i.match?(response)
  return true if /^roc$/i.match?(response)
  false
end

def shorthand_paper_checker?(response)
  return true if /^p$/i.match?(response)
  return true if /^pa$/i.match?(response)
  return true if /^pap$/i.match?(response)
  return true if /^pape$/i.match?(response)
  false
end

def shorthand_lizard_checker?(response)
  return true if /^l$/i.match?(response)
  return true if /^li$/i.match?(response)
  return true if /^liz$/i.match?(response)
  return true if /^liza$/i.match?(response)
  return true if /^lizar$/i.match?(response)
end

def prompts_various_wrong_user_inputs(response)
  if one_letter_s_given?(response)
    prompt('You cannot abbreviate to one letter (Scissors and Spock both start with "S"). Type the entire response, please.')
  elsif shorthand_for_spock_or_scissors?(response)
    prompt('Type out the full word for Scissors or Spock')
  elsif shorthand_for_rock_paper_lizard?(response)
    prompt('You must type out Rock, Paper, or Lizard.')
  elsif response.empty?
    prompt('You must give a response. You left the blank empty.')
  elsif !VALID_CHOICES.include?(response)
    prompt('You must select a valid choice.')
  end
end

def prompt_how_to_play(user_response)
  case user_response
  when 'help' then prompt_what_beats_what
  end
end

def prompt_what_beats_what
  prompt(rules_of_game)
end

def rules_of_game
  <<~MSG
  The game is the exact same as Rock-Paper-Scissors, but with two new options...
                            Lizard and Spock
            Here are the various ways players win, lose, or tie
     Rock:     beats Scissors and Lizard;   loses to Paper    and Spock
     Paper:    beats Rock     and Spock;    loses to Scissors and Lizard
     Scissors: beats Paper    and Lizard;   loses to Rock     and Spock
     Spock:    beats Rock     and Scissors; loses to Paper    and Lizard
     Lizard:   beats Paper    and Spock;    loses to Rock     and Scissors
  MSG
end

def prompts_various_wrong_user_names(name)
  if name.empty?
    prompt('You must type a valid name and not leave the response blank')
  elsif /[0-9]/.match?(name)
    prompt('You cannot use numbers')
  elsif VALID_CHOICES.include?(name.downcase)
    prompt('Your name surly cannot be one of the objects, a lizard, or Spock himself. Enter your real name.')
  end
end

def acceptable_name_format?(name)
  /^[A-z]+[\-\']?[A-z]*[\s\-]?[A-z]*[\-\'\s]?[A-z]*$/.match?(name)
end
def response
  gets.chomp.strip
end

def display_results(player, computer)
  if win?(player, computer)
    prompt('You Won!')
  elsif win?(computer, player)
    prompt('Computer Won!')
  else
    prompt("It's a tie")
  end
end

def win?(first, second)
  (first == 'rock' && second == 'scissors') ||
    (first == 'paper' && second == 'rock') ||
    (first == 'scissors' && second == 'paper')
end

# start of program

user_name = ''
loop do
  prompt('Hello. And welcome to Rock, Paper, Scissors, Spock, Lizard. What is your name?')
  user_name = response
  prompts_various_wrong_user_names(user_name)
  next if VALID_CHOICES.include?(user_name.downcase)
  break if acceptable_name_format?(user_name)
end

prompt("Hello #{user_name}. It is time to play a familiar game with a twist.")

loop do
  user_response = ''
  loop do
    prompt('What is your choice between: Rock, Paper, Scissors, Spock, Lizard? (or type help for how the game works)')
    user_response = response.downcase
    prompts_various_wrong_user_inputs(user_response)
    prompt_how_to_play(user_response)
    break if VALID_CHOICES.include?(user_response)
  end

  computer_choice = VALID_CHOICES.sample

  prompt("You chose: #{user_response}; Computer chose: #{computer_choice}")

  display_results(user_response, computer_choice)

  prompt('Do you want to play again?')
  play_again_response = response.downcase
  break unless play_again_response.start_with?('y')
end
prompt("Thank you for playing Rock, Paper, Scissors, Spock, Lizard #{user_name}. Have a good day.")

# Rock Paper Scissors are the only computer choices so far
# you need to get text to yaml file
# cleaning up the body of the loop (possibly)
# keeping score (Spock and Lizard always end in a tie currently when the user selects)
# make a test list when you complete everything above before you move on