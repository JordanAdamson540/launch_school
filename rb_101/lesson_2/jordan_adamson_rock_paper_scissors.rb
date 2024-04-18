require 'Yaml'
MESSAGE = YAML.load_file('jordan_adamson_rock_paper_scissors.yml')

VALID_CHOICES = ['rock', 'paper', 'scissors', 'spock', 'lizard']
RESET_SCORE = 0
WINNER_TOTAL_SCORE = 3
ONE_MATCHUP_POINT_ADDER = 1
PAUSE_TIME = 3

# side effects

def prompt(phrase, interpolation=nil, interpolation2=nil, interpolation3=nil)
  puts "=> #{format(MESSAGE[phrase], one: interpolation,
                                     two: interpolation2,
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
  elsif !acceptable_responses?(response) && response != 'help'
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
  if player_score >= WINNER_TOTAL_SCORE
    prompt('player_winner', user_name)
  elsif computer_score >= WINNER_TOTAL_SCORE
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
  return true if response.include?('rock')
  return true if response.include?('paper')
  return true if response.include?('lizard')
  false
end

def shorthand_for_spock_or_scissors?(response)
  return true if shorthand_spock_checker?(response)
  return true if shorthand_scissors_checker?(response)
  return true if response.include?('spock')
  return true if response.include?('scissors')
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

# small logic

def clear_screen
  system('clear')
end

def response
  gets.chomp.strip
end

def acceptable_name_format?(name)
  /^[A-z]+[\-\']?[A-z]*[\s\-]?[A-z]*[\-\'\s]?[A-z]*$/.match?(name)
end

def delay_time_seconds(seconds)
  sleep(seconds)
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
  case first
  when 'rock'     then rock_beats_?(second)
  when 'paper'    then paper_beats_?(second)
  when 'scissors' then scissors_beats_?(second)
  when 'spock'    then spock_beats_?(second)
  when 'lizard'   then lizard_beats_?(second)
  end
end

def rock_beats_?(second)
  ['scissors', 'lizard'].include?(second)
end

def paper_beats_?(second)
  ['rock', 'spock'].include?(second)
end

def scissors_beats_?(second)
  ['paper', 'lizard'].include?(second)
end

def spock_beats_?(second)
  ['rock', 'scissors'].include?(second)
end

def lizard_beats_?(second)
  ['paper', 'spock'].include?(second)
end

# large logic

def continuously_updating_score_keeper(user_response,
                                       computer_choice,
                                       user_score,
                                       computer_score,
                                       ties)
  if win?(user_response, computer_choice)
    user_score += ONE_MATCHUP_POINT_ADDER
  elsif win?(computer_choice, user_response)
    computer_score += ONE_MATCHUP_POINT_ADDER
  else
    ties += ONE_MATCHUP_POINT_ADDER
  end
  [user_score, computer_score, ties]
end

def user_or_computer_declared_winner?(player_score, computer_score)
  player_score >= WINNER_TOTAL_SCORE || computer_score >= WINNER_TOTAL_SCORE
end

def reset_scores
  reset_player_score = RESET_SCORE
  reset_computer_score = RESET_SCORE
  reset_ties = RESET_SCORE
  [reset_player_score, reset_computer_score, reset_ties]
end

# high level abstracted logic

def aquire_name
  loop do
    prompt('welcome_and_name')
    user_name = response
    prompts_various_wrong_user_names(user_name)
    next if VALID_CHOICES.include?(user_name.downcase)
    break user_name if acceptable_name_format?(user_name)
  end
end

def aquire_user_response
  loop do
    prompt('game_options_or_help')
    user_response = response.downcase
    prompts_various_wrong_user_inputs(user_response)
    prompt_how_to_play(user_response)
    break user_response if acceptable_responses?(user_response)
  end
end

def aquire_play_again
  loop do
    play_again_response = response.downcase.chr
    break play_again_response if %w(y n).include?(play_again_response)
    prompt('type_yes_or_no')
  end
end

def aquire_user_and_computer_responses
  user_response = aquire_user_response
  user_response = full_name_generator(user_response) \
    unless VALID_CHOICES.include?(user_response)
  computer_choice = VALID_CHOICES.sample
  prompt('user_chose_computer_chose', user_response, computer_choice)
  delay_time_seconds(PAUSE_TIME)
  display_results(user_response, computer_choice)
  delay_time_seconds(PAUSE_TIME)
  [user_response, computer_choice]
end

def aquire_name_and_how_to_play
  clear_screen
  user_name = aquire_name
  prompt('greeting_with_name', user_name)
  delay_time_seconds(PAUSE_TIME)
  prompt_how_to_play('help')
end

# start of program

user_name = ''
player_score = RESET_SCORE
computer_score = RESET_SCORE
ties = RESET_SCORE

user_name = aquire_name_and_how_to_play

loop do
  loop do
    user_response, computer_choice = aquire_user_and_computer_responses
    player_score, computer_score, ties = \
      continuously_updating_score_keeper(user_response,
                                         computer_choice,
                                         player_score,
                                         computer_score,
                                         ties)
    prompt('current_score', player_score, computer_score, ties)
    delay_time_seconds(PAUSE_TIME)
    break if user_or_computer_declared_winner?(player_score, computer_score)
  end
  display_grand_champion(player_score, computer_score, user_name)
  player_score, computer_score, ties = reset_scores

  prompt('ask_play_again')
  play_again_response = aquire_play_again
  clear_screen
  break unless play_again_response.start_with?('y')
end

clear_screen
prompt('goodbye_with_name', user_name)
