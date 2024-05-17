Write a method that takes a positive integer, n, as an argument, and displays a right triangle whose sides each have n stars. The hypotenuse of the triangle (the diagonal side in the images below) should have one end at the lower-left of the triangle, and the other end at the upper-right.

Examples:

``` ruby
triangle(5)
    *
   **
  ***
 ****
*****
```

``` ruby
triangle(9)
        *
       **
      ***
     ****
    *****
   ******
  *******
 ********
*********
```

#### input and output

input: positive integer\
output: a triangle of `n` length and height

#### explicit requirements

``` ruby
triangle(5)
    *
   **
  ***
 ****
*****
```

``` ruby
triangle(9)
        *
       **
      ***
     ****
    *****
   ******
  *******
 ********
*********
```

#### implicit requirements

none

#### clarifying questions

none

#### mental model

``` ruby
=begin

given an integer
the integer value 1 is assigned to the variable counter

while the counter is less than or equal to integer

  output the integer times counter
  add one to counter


=end
``` 

#### examples and test cases

``` ruby
triangle(5)
    *
   **
  ***
 ****
*****
```

``` ruby
triangle(9)
        *
       **
      ***
     ****
    *****
   ******
  *******
 ********
*********
```

#### data structure

none

#### algorithm


``` ruby
=begin

given an integer
the integer value 1 is assigned to the variable counter

while the counter is less than or equal to integer

  output the integer times counter with the "*" shifting to the right
  add one to counter

-------

given an integer called 'integer'

SET counter = 1
WHILE counter <= integer
  PRINT ("*" * counter).rjust(integer)
  counter = counter + 1
END

STOP

=end
``` 

#### code with intent

``` ruby
def triangle(integer)
  counter = 1
  while counter <= integer
    puts integer * "*"
    counter += 1
   end
end

triangle(5)
    *
   **
  ***
 ****
*****


triangle(9)
        *
       **
      ***
     ****
    *****
   ******
  *******
 ********
*********
```

#### refactor


``` ruby
def triangle(integer)
  integer.times { |current_n| puts ("*" * (current_n +     1)).rjust(integer) }
end

triangle(5)
triangle(9)
```