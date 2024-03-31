require "Yaml"

MESSAGE = YAML.load_file('mortgage_calculator.yml')
PREDATORY_INTEREST = 0.3
UNREALISTIC_INTEREST = 0
MONTHS_IN_YEAR = 12

# methods

def prompt(value)
  puts "=> #{MESSAGE[value]}"
end

def prompt_interpolation(value, interpolation) # used for one interpolation
  puts "=> #{format(MESSAGE[value], one: interpolation)}"
end

def prompt_two_interpolation(value, inter1, inter2) # two interpolations
  puts "=> #{format(MESSAGE[value], one: inter1, two: inter2)}"
end

def prompt_three_interpolation(value, inter1, inter2, inter3) # used for three
  puts "=> #{format(MESSAGE[value], one: inter1, two: inter2, three: inter3)}"
end

def clear_screen
  puts "\e[2J\e[f"
end

def input_your_name
  name = ''
  loop do
    prompt('name')
    name = gets.chomp.strip
    break if valid_name_checker?(name)
    prompt('valid_name')
  end
  name
end

def display_welcome_message(name)
  prompt_interpolation('user_greeting', name)
end

def valid_name_checker?(name)
  /^[A-z]+[\']*[A-z]*\s*\-?[A-z]*\-*[A-z]*[\']*[A-z]*$/.match?(name)
  # the above is to try and account for various names that can come up
end

def user_loan_amount
  loan = ''
  loop do
    prompt('to_borrow')
    loan = gets.chomp
    break if monetary_value?(loan) && positive_float?(loan)
  end
  loan.to_f
end

def user_interest_rate
  i_r_y = '' # interest rate years
  i_r_m = '' # intereset rate months
  loop do
    i_r_y = annual_rate.to_f
    i_r_m = (i_r_y / MONTHS_IN_YEAR)
    if i_r_y != UNREALISTIC_INTEREST && i_r_y < PREDATORY_INTEREST
      prompt_interpolation('your_rate', i_r_m.round(4))
      # '##.####' text you will see in output from yml file tries to explain
      # how the user will read the rounding of their interest rate
      prompt_interpolation('actual_rate', i_r_m)
    end
    break if interest_rate_check?(i_r_y)
  end
  i_r_m
end

def annual_rate
  i_r_y = '' # interest_rate_years
  loop do
    prompt('ask_annual')
    i_r_y = gets.chomp
    break if percent_check?(i_r_y) && positive_float?(i_r_y) # line_AA
  end
  i_r_y
end

def percent_check?(i_r_y) # interest_rate_years
  value = /\%/.match?(i_r_y)
  prompt('percentage') if value
  !value
  # flips to false with the ! sign which causes line_AA to short circuit
  # this is intended so positive_float is not needed to be evaluated,
  # as I do not want the user to be told 'enter a positive number',
  # when they did, just with a percentage sign
end

def interest_rate_check?(i_r_y) # interest_rate_years
  value = zero_check?(i_r_y)
  if i_r_y >= PREDATORY_INTEREST
    i_r_y.round(4) # done first: keep from exceeding 80 characters below
    prompt_two_interpolation('preditory', i_r_y / 100, i_r_y / 10)
    prompt_interpolation("continue_apr", i_r_y * 100)
    # 100 and 10 come from user misentering percent to decimal conversions
    response = gets.chomp.downcase
    value = response.start_with?('y')
  elsif i_r_y < PREDATORY_INTEREST && i_r_y > UNREALISTIC_INTEREST
    value = true
  end
  clear_screen unless value
  value
end

def zero_check?(i_r_y)
  if i_r_y.to_f.zero?
    prompt('zero_interest')
    confirm = gets.chomp
    return true if confirm.start_with?('y') # nil if response is not yes
  else
    true
  end
end

def user_duration
  duration = ''
  loop do
    prompt('duration_mon_yrs')
    duration = gets.chomp.downcase
    break if duration.start_with?('m', 'y')
    prompt('yrs_or_months')
  end

  if duration.start_with?('y')
    years
  else
    months
  end
end

def years
  years = ''
  loop do
    prompt('years?')
    years = gets.chomp
    break if positive_integer?(years)
  end
  years.to_i * MONTHS_IN_YEAR
end

def months
  months = ''
  loop do
    prompt('months?')
    months = gets.chomp
    break if positive_integer?(months)
  end
  months.to_i
end

def confirm_choices?(loan, interest_rate, duration)
  loan = currency_formatting(loan)
  interest_rate = percentage_formatting(interest_rate)
  prompt_three_interpolation('confirm_loan', loan, interest_rate, duration)
  response = gets.chomp.downcase
  response.start_with?('y')
end

def loan_formula(loan_amount, i_r_m, duration_months) # interest_rate_MONTHS
  return loan_amount / dur_months if i_r_m == 0
  final_value = (loan_amount * i_r_m) /
                (1 - ((1 + i_r_m)**(-(duration_months))))
  final_value.round(2)
end

def positive_float?(value)
  result = /\d/.match?(value) && /^\d*\.?\d*$/.match?(value)
  # format 0.0 (no negatives)
  prompt('pos_req') unless result
  result
end

def positive_integer?(value)
  result = /^\d+$/.match?(value) && !value.to_f.zero?
  prompt('pos_req') unless result
  result
  # format 0 (no negatives)
end

def currency_formatting(monthly_payment)
  format("$%.2f", monthly_payment)
end

def percentage_formatting(value)
  value = (value.to_f * MONTHS_IN_YEAR * 100).to_s
  # 100 comes from misentering percent to decimal conversions
  format("%.2f%%", value)
end

def monetary_value?(loan)
  value = /^\-?\d*\.?\d?\d?$/.match?(loan)
  prompt('money') unless value
  value = !loan.to_f.zero?
  prompt('zero_dollars') unless value
  value
end

def another_calculation?
  prompt('another?')
  response = gets.chomp.downcase
  true if response.start_with?('y')
end

# start of calculator
PREDATORY_INTEREST = 0.3
UNREALISTIC_INTEREST = 0
MONTHS_IN_YEAR = 12

clear_screen
prompt('welcome')
user_name = input_your_name
display_welcome_message(user_name)

loan_amount = ''
interest_rate_months = ''
duration_months = ''
monthly_payment = ''

loop do
  loop do
    loan_amount = user_loan_amount
    interest_rate_months = user_interest_rate
    duration_months = user_duration
    monthly_payment = loan_formula(loan_amount,
                                   interest_rate_months,
                                   duration_months)
    clear_screen
    break if confirm_choices?(loan_amount,
                              interest_rate_months,
                              duration_months)
  end
  monthly_payment = currency_formatting(monthly_payment)
  prompt_interpolation('payment', monthly_payment)
  break unless another_calculation?
  clear_screen
end
clear_screen
prompt('goodbye')
