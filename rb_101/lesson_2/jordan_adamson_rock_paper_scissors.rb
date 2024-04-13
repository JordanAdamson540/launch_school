require 'Yaml'
MESSAGE = YAML.load_file('jordan_adamson_rock_paper_scissors.yml')

VALID_CHOICES = ['rock', 'paper', 'scissors', 'spock', 'lizard']

def prompt(phrase, interpolation=nil, interpolation2=nil, interpolation3=nil)
  puts "=> #{format(MESSAGE[phrase], one:   interpolation, 
                                     two:   interpolation2,
                                     three: interpolation3)}"
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
    prompt('one_letter_s')
  elsif shorthand_for_spock_or_scissors?(response)
    prompt('full_word_scissors_spock')
  elsif shorthand_for_rock_paper_lizard?(response)
    prompt('type_rock_paper_lizard')
  elsif response.empty?
    prompt('left_empty')
  elsif !VALID_CHOICES.include?(response)
    prompt('select_valid_option')
  end
end

def prompt_how_to_play(user_response)
  case user_response
  when 'help' then prompt_what_beats_what
  end
end

def prompt_what_beats_what
  prompt('rules_of_game')
end

# def rules_of_game
#   <<~MSG
#   The game is the exact same as Rock-Paper-Scissors, but with two new options...
#                             Lizard and Spock
#             Here are the various ways players win, lose, or tie
#      Rock:     beats Scissors and Lizard;   loses to Paper    and Spock
#      Paper:    beats Rock     and Spock;    loses to Scissors and Lizard
#      Scissors: beats Paper    and Lizard;   loses to Rock     and Spock
#      Spock:    beats Rock     and Scissors; loses to Paper    and Lizard
#      Lizard:   beats Paper    and Spock;    loses to Rock     and Scissors
#   MSG
# end

def prompts_various_wrong_user_names(name)
  if name.empty?
    prompt('no_blank_name')
  elsif /[0-9]/.match?(name)
    prompt('no_numbers')
  elsif VALID_CHOICES.include?(name.downcase)
    prompt('object_lizard_spock_mistype')
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
    prompt('win')
  elsif win?(computer, player)
    prompt('cpu_win')
  else
    prompt("tie")
  end
end

def win?(first, second)
  (first == 'rock' && second == 'scissors') ||
    (first == 'paper' && second == 'rock') ||
    (first == 'scissors' && second == 'paper') ||
    (first == 'rock' && second == 'lizard') ||
    (first == 'paper' && second == 'spock') ||
    (first == 'scissors' && second == 'lizard') ||
    (first == 'spock' && second == 'rock') ||
    (first == 'spock' && second == 'scissors') ||
    (first == 'lizard' && second == 'paper') ||
    (first == 'lizard' && second == 'spock')
end

# start of program

user_name = ''
loop do
  prompt('welcome_and_name')
  user_name = response
  prompts_various_wrong_user_names(user_name)
  next if VALID_CHOICES.include?(user_name.downcase)
  break if acceptable_name_format?(user_name)
end

prompt('greeting_with_name', user_name)

loop do
  user_response = ''
  loop do
    prompt('game_options_or_help')
    user_response = response.downcase
    prompts_various_wrong_user_inputs(user_response)
    prompt_how_to_play(user_response)
    break if VALID_CHOICES.include?(user_response)
  end

  computer_choice = VALID_CHOICES.sample

  prompt('user_chose_computer_chose', user_response, computer_choice)

  display_results(user_response, computer_choice)

  prompt('ask_play_again')

  play_again_response = ''
  loop do
    play_again_response = response.downcase.chr
    break if %w(y n).include?(play_again_response)
    prompt('type_yes_or_no')
  end

  break unless play_again_response.start_with?('y')
end
prompt('goodbye_with_name', user_name)

# cleaning up the body of the loop (possibly)
# keeping score (Spock and Lizard always end in a tie currently when the user selects)
# make a test list when you complete everything above before you move on

# new commit
# lizard and spock logic added
# loop for play again response
# yaml file