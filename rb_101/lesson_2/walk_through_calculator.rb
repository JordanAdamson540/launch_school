require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

LANGUAGE = 'en'

def prompt(key)
  message = messages(key, LANGUAGE)
  Kernel.puts("=> #{message}")
end

def interpolation_prompt(key, interpolation)
  message = messages(key, LANGUAGE)
  Kernel.puts("=> #{message} #{interpolation}")
end

def valid_number?(num)
  valid_integer?(num) || valid_float?(num)
end

def valid_integer?(input)
  /^-?\d+$/.match(input)
end

def valid_float?(input)
  /\d/.match?(input) && /^-?\d*\.?\d*$/.match?(input)
end    

def operation_to_message(operation)
  word = case operation
         when '1'
           format(MESSAGES[LANGUAGE]['add'])     
         when '2'
           format(MESSAGES[LANGUAGE]['subtract'])
         when '3'
           format(MESSAGES[LANGUAGE]['multiply'])
         when '4'
           format(MESSAGES[LANGUAGE]['divide'])
         end

  x = "A random line of code"

  puts format(MESSAGES[LANGUAGE]['two_numbers'], word: "#{word}")
end

def messages(message, lang='en')
  MESSAGES[lang][message]
end

prompt('welcome')

name = ''
loop do
  name = Kernel.gets().chomp()

  if name.empty?
    prompt('valid_name')
  else
    break
  end
end

puts format(MESSAGES[LANGUAGE]['hello'], name: "#{name}")

loop do # main loop
  number1 = ''
  loop do
    prompt('number1')
    number1 = Kernel.gets().chomp()

    if valid_number?(number1)
      break
    else
      prompt('incorrect_number')
    end
  end

  number2 = ''
  loop do
    prompt('number2')
    number2 = Kernel.gets().chomp()

    if valid_number?(number2)
      break
    else
      prompt('incorrect_number')
    end
  end

  prompt('operator_prompt')

  operator = ''
  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt('one_to_four_choice')
    end
  end

  operation_to_message(operator)

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

  puts format(MESSAGES[LANGUAGE]['result'], result: "#{result}" )
  prompt('another_one')
  answer = Kernel.gets().chomp
  break unless answer.downcase().start_with?('y')
end

prompt('good_bye')
