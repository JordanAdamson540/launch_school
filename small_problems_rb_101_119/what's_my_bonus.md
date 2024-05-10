Write a method that takes two arguments, a positive integer and a boolean, and calculates the bonus for a given salary. If the boolean is true, the bonus should be half of the salary. If the boolean is false, the bonus should be 0.

Examples:

``` ruby
puts calculate_bonus(2800, true) == 1400
puts calculate_bonus(1000, false) == 0
puts calculate_bonus(50000, true) == 25000
```

The tests above should print `true`.

#### input / output

input: positive integer and a boolean

output: positive, rational number if boolean is `true`, `0` if `false`

#### explicit requirements

2000 and true with an output of 1400\
1000 and false with an output of 0\
50000 and true with an output of 25000

#### implicit requirements

none

#### clarifying questions

none

#### mental model

``` ruby
=begin

given a positive integer and a boolean value,

1. if the boolean is false, 
  i. the return value should be 0
2. otherwise, if the boolan is true, 
  i. multiply the the integer by 0.5

=end
```

#### examples and test cases

``` ruby
puts calculate_bonus(2800, true) == 1400
puts calculate_bonus(1000, false) == 0
puts calculate_bonus(50000, true) == 25000
puts calculate_bonus(1, true) == 0.5
puts calculate_bonus(999_999, true) == 499_999.5
puts calculate_bonus(1_000_000, false) == 0
```

#### data structure

an integer and a boolean will be passed into the method with an output of a rational number

#### algorithm

``` ruby
=begin

given a positive integer and a boolean value,

1. if the boolean is false, 
  i. the return value should be 0
2. otherwise, if the boolan is true, 
  i. multiply the the integer by 0.5


given a positive integer called 'salary' and boolean value called 'boolean'

START

1. IF boolean == false
  i. RETURN 0
2. ELSIF boolean == true
  ii. RETURN salary * 0.5
  
END
=end
```

#### code with intent

``` ruby
def calculate_bonus(salary, boolean)
  if boolean == false
    return 0
  elsif boolean == true
    return salary * 0.5
  end
end

puts calculate_bonus(2800, true) == 1400
puts calculate_bonus(1000, false) == 0
puts calculate_bonus(50000, true) == 25000
puts calculate_bonus(1, true) == 0.5
puts calculate_bonus(999_999, true) == 499_999.5
puts calculate_bonus(1_000_000, false) == 0
```

#### refactored

``` ruby
def calculate_bonus(salary, boolean)
  salary * (boolean ? 0.5 : 0)
end

puts calculate_bonus(2800, true) == 1400
puts calculate_bonus(1000, false) == 0
puts calculate_bonus(50000, true) == 25000
puts calculate_bonus(1, true) == 0.5
puts calculate_bonus(999_999, true) == 499_999.5
puts calculate_bonus(1_000_000, false) == 0
```