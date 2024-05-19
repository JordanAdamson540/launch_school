Write a method that takes a positive integer as an argument and returns that number with its digits reversed. Examples:

``` ruby
reversed_number(12345) == 54321
reversed_number(12213) == 31221
reversed_number(456) == 654
reversed_number(12000) == 21 # No leading zeros in return value!
reversed_number(12003) == 30021
reversed_number(1) == 1
```

Don't worry about arguments with leading zeros - Ruby sees those as octal numbers, which will cause confusing results. For similar reasons, the return value for our fourth example doesn't have any leading zeros.


#### inputs and outputs
input: positive integer
output: digits reversed with no leading 0's

#### explicit requirements

``` ruby
reversed_number(12345) == 54321
reversed_number(12213) == 31221
reversed_number(456) == 654
reversed_number(12000) == 21 # No leading zeros in return value!
reversed_number(12003) == 30021
reversed_number(1) == 1
```

#### implicit requirements

none

#### clarifying questions (none)

#### mental model

``` ruby
=begin

given a positive integer

1. convert integer to a string and assign the value to a variable called string
2. reverse the ordering of the string and assign the value to a variable called reversed_string
3. convert reversed_string back to an integer and use this as the return value

=end
```
  
#### examples and test cases

``` ruby
reversed_number(12345) == 54321
reversed_number(12213) == 31221
reversed_number(456) == 654
reversed_number(12000) == 21 # No leading zeros in return value!
reversed_number(12003) == 30021
reversed_number(1) == 1
```

#### data structure

array

#### algorithm

``` ruby
=begin

given a positive integer

1. convert integer to a string and assign the value to a variable called string
2. reverse the ordering of the string and assign the value to a variable called reversed_string
3. convert reversed_string back to an integer and use this as the return value

=end

```

``` ruby

=begin

given a positive integer called 'integer'

START

SET string = integer.to_s
SET reversed_string = string.reverse
RETURN reversed_string.to_i

END

=end

```

#### code with intent

``` ruby
def reversed_number(integer)
	string = integer.to_s
	reversed_string = string.reverse
	reversed_string.to_i
end

p reversed_number(12345) == 54321
p reversed_number(12213) == 31221
p reversed_number(456) == 654
p reversed_number(12000) == 21
p reversed_number(12003) == 30021
p reversed_number(1) == 1
```