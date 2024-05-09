Write a method that takes one integer argument, which may be positive, 
negative, or zero. This method returns true if the number's absolute value is 
odd. You may assume that the argument is a valid integer value.

Examples:
``` ruby
puts is_odd?(2)    # => false
puts is_odd?(5)    # => true
puts is_odd?(-17)  # => true
puts is_odd?(-8)   # => false
puts is_odd?(0)    # => false
puts is_odd?(7)    # => true
```

Keep in mind that you're not allowed to use #odd? or #even? in your solution.

#### input and output
---

input:
* integers

output:
* boolean value

#### explicit requirements
---

2 should return false\
5 should return true\
-17 should return true\
-8 should return false\
0 should return false\
7 should return true

#### implicit requirements
---

Any and all integers can be inputs.

#### clarifying questions
---

question is straightforward

#### mental model
---
``` ruby
=begin
1. Evaluate the expression of a given integer modulo 2 and save it as modulus
  i.If the modulus is 1
    a. then return the value true
  ii. otherwise, if the modulus is not 0
    a. then the return value of the function should be false.


=end


```

#### examples and test cases
---

``` ruby
p is_odd?(2) == false
p is_odd?(5) == true
p is_odd?(-17) == true
p is_odd?(-8) == false
p is_odd?(0) == false
p is_odd?(7) == true
p is_odd?(999_999) == true
p is_odd?(1_000_000) == false
```

#### data structure
---

you will use a integer as the input => the end result will return a boolean value

#### algorithm
---
``` ruby
=begin

Evaluate the expression of a given integer modulo 2. If the modulus is 0, then return the value is false. If the modulus is not 0, then the return value of the function should be true.

given an integer called 'integer'

START

1. IF integer % 2 == 0\
  ii. RETURN false
2. ELSIF integer % 2 != 0\
  ii. RETURN true

END

=end
```
#### code with intent

---

``` ruby
def is_odd?(integer)
  modulus_of_one = integer % 2 == 1
  if modulus_of_one
    return true
  else
    return false
  end
end

puts is_odd?(2)    # => false
puts is_odd?(5)    # => true
puts is_odd?(-17)  # => true
puts is_odd?(-8)   # => false
puts is_odd?(0)    # => false
puts is_odd?(7)    # => true
```

#### refactor

``` ruby
def is_odd?(integer)
	integer % 2 == 1
end

puts is_odd?(2) == false
puts is_odd?(5) == true
puts is_odd?(-17) == true
puts is_odd?(-8) == false
puts is_odd?(0) == false
puts is_odd?(7) == true
puts is_odd?(1) == true
```