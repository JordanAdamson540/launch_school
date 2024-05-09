Write a method that takes one argument, a positive integer, and returns a string of alternating 1s and 0s, always starting with 1. The length of the string should match the given integer.


``` ruby
puts stringy(6) == '101010'
puts stringy(9) == '101010101'
puts stringy(4) == '1010'
puts stringy(7) == '1010101'
```

The tests above should print true.

#### inputs and outputs

input:
* integer

output:
* string of repeating `1`'s and `0`'s

#### explicit requirements

6 should return '101010'\
9 should return '101010101'\
4 should return '1010'\
7 should return '101010101'

#### implicit requirements

none

#### clarifying questions

none

#### mental model

A final string will be created to be used as the return value. Another integer will be created called counter. Counter will compared to the given integer, and while the counter is less than the given integer, the numerical value of one will be added to counter. From there, if the counter is odd, the  string '1' will be added to the end of final string. If the counter is even, a  string '0' will be added to the end of final string. Final string is then returned.

#### examples and test cases

``` ruby
puts stringy(6) == '101010'
puts stringy(9) == '101010101'
puts stringy(4) == '1010'
puts stringy(7) == '1010101'
puts stringy(12 == '101010101010'
```

#### data structure

an integer on the input => a string on the output

#### algorithm




``` ruby
=begin
# given an integer called 'integer'

# START
1. SET final_string = ''
2. SET counter = 0
3. WHILE counter < integer
  i.   counter = counter + 1
  ii.  IF counter is odd?
      a. final_string = final_string + '1'
  iii. ELSIF counter is even?
      a. final_string = final_string + '0'
4. RETURN final_string

# END
=end
```

#### code with intent

``` ruby
def stringy(integer)
  final_string = ''
  counter = 0
  while counter < integer
    counter += 1
    if counter.odd?
      final_string = final_string + '1'
    else
      final_string = final_string + '0'
    end
  end
  final_string
end

puts stringy(6) == '101010'
puts stringy(9) == '101010101'
puts stringy(4) == '1010'
puts stringy(7) == '1010101'
puts stringy(12) == '101010101010'
```

#### refactored

``` ruby

def stringy(integer)
  final_string = ''
    integer.times do |current_number|
    final_string = final_string + (current_number.even? ? '1' : '0')
    end
    # switched method to even? since the .times method starts at integer 0
  final_string
end

puts stringy(6) == '101010'
puts stringy(9) == '101010101'
puts stringy(4) == '1010'
puts stringy(7) == '1010101'
puts stringy(12) == '101010101010'
```
