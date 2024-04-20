require 'Yaml'
MESSAGE = YAML.load_file('jordan_adamson_rock_paper_scissors.yml')

VALID_CHOICES = ['rock', 'paper', 'scissors', 'spock', 'lizard']
RESET_SCORE = 0
WINNER_TOTAL_SCORE = 3
ONE_MATCHUP_POINT_ADDER = 1
PAUSE_TIME = 0

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

def prompts_various_wrong_user_inputs(response, shorthand_responses)
  if one_letter_s_given?(response)
    prompt('one_letter_s')
  elsif response.empty?
    prompt('left_empty')
  elsif !acceptable_responses?(response, shorthand_responses) && response != 'help'
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

def display_results(player, computer, what_beats_what)
  if win?(player, computer, what_beats_what)
    prompt('win')
  elsif win?(computer, player, what_beats_what)
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

def acceptable_responses?(user_response, shorthand_responses)
  shorthand_responses.any? do |key, value| 
    value.match?(user_response)
  end
end

def one_letter_s_given?(response)
  /^[s]$/i.match?(response)
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

def full_name_generator(user_response, shorthand_responses)
  if shorthand_responses[:rock].match?(user_response)
    'rock'
  elsif shorthand_responses[:paper].match?(user_response)
    'paper'
  elsif shorthand_responses[:scissors].match?(user_response)
    'scissors'
  elsif shorthand_responses[:spock].match?(user_response)
    'spock'
  elsif shorthand_responses[:lizard].match?(user_response)
    'lizard'
  end
end

def win?(first, second, what_beats_what)
  case first
  when 'rock'     then what_beats_what[:rock].include?(second)
  when 'paper'    then what_beats_what[:paper].include?(second)
  when 'scissors' then what_beats_what[:scissors].include?(second)
  when 'spock'    then what_beats_what[:spock].include?(second)
  when 'lizard'   then what_beats_what[:lizard].include?(second)
  end
end

# large logic

def continuously_updating_score_keeper(user_response,
                                       computer_choice,
                                       user_score,
                                       computer_score,
                                       ties,
                                       what_beats_what)
  if win?(user_response, computer_choice, what_beats_what)
    user_score += ONE_MATCHUP_POINT_ADDER
  elsif win?(computer_choice, user_response, what_beats_what)
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
  [RESET_SCORE, RESET_SCORE, RESET_SCORE]
end

# high level abstracted logic

def acquire_name
  loop do
    prompt('welcome_and_name')
    user_name = response
    prompts_various_wrong_user_names(user_name)
    next if VALID_CHOICES.include?(user_name.downcase)
    break user_name if acceptable_name_format?(user_name)
  end
end

def acquire_user_response(shorthand_responses)
  loop do
    prompt('game_options_or_help')
    user_response = response.downcase
    prompts_various_wrong_user_inputs(user_response, shorthand_responses)
    prompt_how_to_play(user_response)
    break user_response if acceptable_responses?(user_response, shorthand_responses)
  end
end

def acquire_play_again
  loop do
    play_again_response = response.downcase.chr
    break play_again_response if %w(y n).include?(play_again_response)
    prompt('type_yes_or_no')
  end
end

def acquire_user_and_computer_responses(shorthand_responses, what_beats_what)
  user_response = acquire_user_response(shorthand_responses)
  user_response = full_name_generator(user_response, shorthand_responses) \
    unless VALID_CHOICES.include?(user_response)
  computer_choice = VALID_CHOICES.sample
  prompt('user_chose_computer_chose', user_response, computer_choice)
  delay_time_seconds(PAUSE_TIME)
  display_results(user_response, computer_choice, what_beats_what)
  delay_time_seconds(PAUSE_TIME)
  [user_response, computer_choice]
end

def acquire_name_and_how_to_play
  clear_screen
  user_name = acquire_name
  prompt('greeting_with_name', user_name)
  delay_time_seconds(PAUSE_TIME)
  prompt_how_to_play('help')
  user_name
end

# start of program

shorthand_responses = {
                        rock: /^ro?c?k?$/i,
                        paper: /^pa?p?e?r?$/i,
                        scissors: /^sc+i?s?s?o?r?s?$/i,
                        lizard: /^li?z?a?r?d?$/i,
                        spock: /^sp+o?c?k?$/i
                      }
        
what_beats_what = {
                    rock: ['scissors', 'lizard'],
                    paper: ['rock', 'spock'],
                    scissors: ['paper', 'lizard'],
                    lizard: ['paper', 'spock'],
                    spock: ['rock', 'scissors']
                  }

user_name = ''
player_score = RESET_SCORE
computer_score = RESET_SCORE
ties = RESET_SCORE

user_name = acquire_name_and_how_to_play

loop do
  loop do
    user_response, computer_choice = acquire_user_and_computer_responses(shorthand_responses, what_beats_what)
    player_score, computer_score, ties = \
      continuously_updating_score_keeper(user_response,
                                         computer_choice,
                                         player_score,
                                         computer_score,
                                         ties,
                                         what_beats_what)
    prompt('current_score', player_score, computer_score, ties)
    delay_time_seconds(PAUSE_TIME)
    break if user_or_computer_declared_winner?(player_score, computer_score)
  end
  display_grand_champion(player_score, computer_score, user_name)
  player_score, computer_score, ties = reset_scores

  prompt('ask_play_again')
  play_again_response = acquire_play_again
  clear_screen
  break unless play_again_response.start_with?('y')
end

clear_screen
prompt('goodbye_with_name', user_name)
# 300 lines