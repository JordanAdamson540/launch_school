# m = p * (j / (1 - (1 + j)**(-n)))
=begin
m = monthly payment
p = loan amount
j = monthly interest rate
n = loan duration in months
=end

=begin
You'll need three pieces of information:

the loan amount
the Annual Percentage Rate (APR)
the loan duration
From the above, you'll need to calculate the following things:

monthly interest rate
loan duration in months
monthly payment
=end

=begin
greet the user
get the loan amount from the user
  -the amount must be a positive float
get the interest rate from the user
  -the amount must be a positive float
  -show what the interest rate will be each month

get the loan duration from the user
  -the amount must be a positive integer
  -show how many months the user will have the loan
calculate the monthly payment
=end

=begin
BEGIN
PRINT greet the user
SET loan_amount = SUBPROCCESS GET loan amount from user (+ float)
SET interest_rate_months = SUBPROCCESS GET interest rate from user (+ float)
                             -convert to monthly interest rate
SET duration_months = SUBPROCESS GET the years from user (+ integer)
                        -convert to months
SET monthly_payment = SUBPROCESS formula for loan
PRINT monthly_payment
END
=end

=begin
  extra features
  -=>
  -text on yaml (do not put interpolation on yaml file)

=end
require "Yaml"

MESSAGE = YAML.load_file('mortgage_calculator.yml')

def prompt(value)
  puts "=> #{MESSAGE[value]}"
end

def prompt_interpolation(value, interpolation)
  puts "=> #{format(MESSAGE[value], one: interpolation)}"
end

def prompt_two_interpolation(value, inter1, inter2)
  puts "=> #{format(MESSAGE[value], one: inter1, two: inter2)}"
end

def user_loan_amount
  loan = ''
  loop do
    prompt('to_borrow')
    loan = gets.chomp
    break if positive_float?(loan)
    prompt('pos_req')
  end
  loan.to_f
end

def user_interest_rate
  interest_rate_years = ''
  interest_rate_months = ''
  loop do
    interest_rate_years = annual_rate.to_f
    interest_rate_months = (interest_rate_years / 12)
    prompt_interpolation('your_rate', interest_rate_months.round(4))
    prompt_interpolation('actual_rate', interest_rate_months)
    break if interest_rate_check?(interest_rate_years)
  end
  interest_rate_months
end

def annual_rate
  interest_rate_years = ''
  loop do
    prompt('ask_annual')
    interest_rate_years = gets.chomp
    break if positive_float?(interest_rate_years)
    prompt('pos_req')
  end
  interest_rate_years
end

def interest_rate_check?(i_r_y) # interest_rate_years
  if i_r_y >= 0.3
    prompt_two_interpolation('preditory', i_r_y / 100, i_r_y / 10)
    prompt_interpolation("continue_apr", i_r_y * 100)
    response = gets.chomp.downcase
    return true if response.start_with?('y') # nil if no yes
  else
    true
  end
end

def user_duration
  duration = ''
  loop do
    prompt('duration_mon_yrs')
    duration = gets.chomp.downcase
    break if duration == 'months' || duration == 'years'
    prompt('yrs_or_months')
  end
  case duration
  when 'years'  then years
  when 'months' then months
  end
end

def years
  years = ''
  loop do
    prompt('years?')
    years = gets.chomp
    break if positive_integer?(years)
    prompt_interpolation('no_decimal', 'years')
  end
  years.to_i * 12
end

def months
  months = ''
  loop do
    prompt('months?')
    months = gets.chomp
    break if positive_integer?(months)
    prompt_interpolation('no_decimal', 'months')
  end
  months.to_i
end

def loan_formula(loan_amount, i_r_m, dur_months) # interest rate months
  final_value = (loan_amount * i_r_m) / (1 - ((1 + i_r_m)**(-(dur_months))))
  final_value.round(2)
end

def positive_float?(value)
  /\d/.match?(value) && /^\d*\.?\d*$/.match?(value) && !value.to_f.zero?
  # format 0.0 (no negatives)
end

def positive_integer?(value)
  /^\d+$/.match?(value) && !value.to_f.zero?
  # format 0 (no negatives)
end

def currency_formatting(monthly_payment)
  format("$%.2f", monthly_payment)
end

def another_calc?
  prompt('another?')
  response = gets.chomp.downcase
  response.start_with?('y') ? true : false
end

prompt('welcome')
loop do
  loan_amount = user_loan_amount
  interest_rate_months = user_interest_rate
  duration_months = user_duration
  monthly_pmt = loan_formula(loan_amount, interest_rate_months, duration_months)
  monthly_pmt = currency_formatting(monthly_pmt)
  prompt_interpolation('payment', monthly_pmt)
  break unless another_calc?
end

prompt('goodbye')
