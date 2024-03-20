require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  valid_integer?(num) || valid_float?(num)
end

def valid_integer?(input)
  /^-?\d+$/.match(input)
end

def valid_float?(input)
  /\d+/.match?(input) && /^-?\d*\.?\d*$/.match?(input)
end    

def operation_to_message(operation)
  word = case operation
           when '1'
             'Adding'
           when '2'
             'Subtracting'
           when '3'
             'Multiplying'
           when '4'
             'Dividing'
         end

  x = "A random line of code"

  word
end

prompt(MESSAGES['welcome'])

name = ''
loop do
  name = Kernel.gets().chomp()

  if name.empty?
    prompt(MESSAGES['valid_name'])
  else
    break
  end
end

prompt(MESSAGES['hello'] + " #{name}! ")

loop do # main loop
  number1 = ''
  loop do
    prompt(MESSAGES['number1'])
    number1 = Kernel.gets().chomp()

    if valid_number?(number1)
      break
    else
      prompt(MESSAGES['incorrect_number'])
    end
  end

  number2 = ''
  loop do
    prompt(MESSAGES['number2'])
    number2 = Kernel.gets().chomp()

    if valid_number?(number2)
      break
    else
      prompt(MESSAGES['incorrect_number'])
    end
  end

  operator_prompt = <<-MSG
    What operation would you like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
  MSG

  prompt(operator_prompt)

  operator = ''
  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(MESSAGES['one_to_four_choice'])
    end
  end

  prompt("#{operation_to_message(operator)} " + MESSAGES['two_numbers'])

  result = case operator
           when '1'
             number1.to_i() + number2.to_i()
           when '2'
             number1.to_i() - number2.to_i()
           when '3'
             number1.to_i() * number2.to_i()
           when '4'
             number1.to_f() / number2.to_f()
           end

  prompt((MESSAGES['result'] + "#{result}"))

  prompt(MESSAGES['another_one'])
  answer = Kernel.gets().chomp
  break unless answer.downcase().start_with?('y')
end

prompt(MESSAGES['good_bye'])
