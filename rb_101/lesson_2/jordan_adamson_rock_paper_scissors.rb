require 'Yaml'
MESSAGE = YAML.load_file('jordan_adamson_rock_paper_scissors.yml')

VALID_CHOICES = ['rock', 'paper', 'scissors', 'spock', 'lizard']

# side effects

def prompt(phrase, interpolation=nil, interpolation2=nil, interpolation3=nil)
  puts "=> #{format(MESSAGE[phrase], one:   interpolation, 
                                     two:   interpolation2,
                                     three: interpolation3)}"
end

def prompts_various_wrong_user_names(name)
  if name.empty?
    prompt('no_blank_name')
  elsif /[0-9]/.match?(name)
    prompt('no_numbers')
  elsif VALID_CHOICES.include?(name.downcase)
    prompt('object_lizard_spock_mistype')
  end
end

def prompts_various_wrong_user_inputs(response)
  if one_letter_s_given?(response)
    prompt('one_letter_s')
  elsif response.empty?
    prompt('left_empty')
  elsif !acceptable_responses?(response)
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

def display_results(player, computer)
  if win?(player, computer)
    prompt('win')
  elsif win?(computer, player)
    prompt('cpu_win')
  else
    prompt("tie")
  end
end

def display_grand_champion(player_score, computer_score, user_name)
  if player_score >= 3
    prompt('player_winner', user_name)
  elsif computer_score >= 3
    prompt('computer_winner')
  end
end

# logic for player response inputs

def acceptable_responses?(user_response)
  return true if shorthand_for_rock_paper_lizard?(user_response)
  return true if shorthand_for_spock_or_scissors?(user_response)
  return true if VALID_CHOICES.include?(user_response)
  false
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
  false
end

# logic

def clear_screen
  system('clear')
end

def response
  gets.chomp.strip
end

def acceptable_name_format?(name)
  /^[A-z]+[\-\']?[A-z]*[\s\-]?[A-z]*[\-\'\s]?[A-z]*$/.match?(name)
end

def full_name_generator(user_response)
  if shorthand_rock_checker?(user_response)
    'rock'
  elsif shorthand_paper_checker?(user_response)
    'paper'
  elsif shorthand_scissors_checker?(user_response)
    'scissors'
  elsif shorthand_spock_checker?(user_response)
    'spock'
  elsif shorthand_lizard_checker?(user_response)
    'lizard'
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

def continuously_updating_score_keeper(user_response, 
                                       computer_choice, 
                                       user_score, 
                                       computer_score, 
                                       ties)
  if win?(user_response, computer_choice)
    user_score += 1
  elsif win?(computer_choice, user_response)
    computer_score += 1
  else
    ties += 1
  end
  [user_score, computer_score, ties]
end

def reset_scores(player_score, computer_score, ties)
  player_score = 0
  computer_score = 0
  ties = 0
  [player_score, computer_score, ties]
end

# start of program

user_name = ''
player_score = 0
computer_score = 0
ties = 0

clear_screen

loop do
  prompt('welcome_and_name')
  user_name = response
  prompts_various_wrong_user_names(user_name)
  next if VALID_CHOICES.include?(user_name.downcase)
  break if acceptable_name_format?(user_name)
end

prompt('greeting_with_name', user_name)

loop do
  loop do
  user_response = ''
  loop do
    prompt('game_options_or_help')
    user_response = response.downcase
    prompts_various_wrong_user_inputs(user_response)
    prompt_how_to_play(user_response)
    break if acceptable_responses?(user_response)
  end

  user_response = full_name_generator(user_response) \
    unless VALID_CHOICES.include?(user_response)

  computer_choice = VALID_CHOICES.sample

  prompt('user_chose_computer_chose', user_response, computer_choice)

  display_results(user_response, computer_choice)

  player_score, computer_score, ties = \
    continuously_updating_score_keeper(user_response,
                                       computer_choice,
                                       player_score,
                                       computer_score,
                                       ties)
  prompt('current_score', player_score, computer_score, ties)
  break if player_score >= 3 || computer_score >= 3
  end
  display_grand_champion(player_score, computer_score, user_name)
  player_score, computer_score, ties = reset_scores(player_score,
                                                    computer_score,
                                                    ties)
  prompt('ask_play_again')

  play_again_response = ''
  loop do
    play_again_response = response.downcase.chr
    break if %w(y n).include?(play_again_response)
    prompt('type_yes_or_no')
  end

  break unless play_again_response.start_with?('y')
end

clear_screen

prompt('goodbye_with_name', user_name)

# work on ordering the methods (you have done this for the most part)

# cleaning up the body of the loop (possibly)
# clean up logic of win? method
# rubocop
# make a test list when you complete everything above before you move on

