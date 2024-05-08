Write a method that takes one integer argument, which may be positive, negative, or zero. This method returns true if the number's absolute value is odd. You may assume that the argument is a valid integer value.

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

Evaluate the expression of a given integer modulo 2. If the modulus is 0, then return the value false. If the modulus is not 0, then the return value of the function should be true.

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

Evaluate the expression of a given integer modulo 2. If the modulus is 0, then return the value is false. If the modulus is not 0, then the return value of the function should be true.

given an integer called 'integer'

START

1. IF integer % 2 == 0
	1. RETURN false
2. ELSIF integer % 2 != 0\
	2. RETURN true

END

#### one manual test
---
is_odd?(-17) == true

---

1. ELSIF -17 % 2 != 0


``` ruby
	return true
```

#### code with intent
---

``` ruby
def is_odd?(integer)
	if integer % 2 == 0
    	return false
    else
    	return true
    end
end

puts is_odd?(2)    # => false
puts is_odd?(5)    # => true
puts is_odd?(-17)  # => true
puts is_odd?(-8)   # => false
puts is_odd?(0)    # => false
puts is_odd?(7)    # => true


```