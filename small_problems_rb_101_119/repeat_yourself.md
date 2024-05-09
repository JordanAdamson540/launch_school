Write a method that takes two arguments, a string and a positive integer, and prints the string as many times as the integer indicates.

Example:

``` ruby
repeat('Hello', 3)
```

Output:

``` ruby
Hello
Hello
Hello
```
## 11 Easy Pieces (PEDAC) (or 10 if you merge test cases and edge cases)


## input / output

input: string and positive integer

output: string as many times as the integer

## explicit requirements

- The string `Hello`
- The positive integer `1`

## implicit requirements

- negative numbers are not allowed
- the first argument must be a string
- the second agrument must be an integer


## clarifying questions

- question is simple 

## mental model
``` ruby 
=begin
1. create an iterator and set it equal to 0
2. As long as the iterator is less than the given integer
  i. output the string
  ii. add one to the string
=end
```

## test cases

``` ruby



```
## data structure

string as the input => array stores the amount of times the string will be outputted based on integer given => converted back to string before output 

## algorithm


``` ruby
=begin
1. create an iterator and set it equal to 0
2. As long as the iterator is less than the given integer
  i. output the string
  ii. add one to the string

given a string called 'string' and an integer called 'integer'

START

SET iterator = 0

WHILE iterator < integer do
  PRINT string
  iterator = iterator + 1
end

END
=end

```

## code with intent

```ruby

def repeat(string, integer)
  iterator = 0
  while iterator < integer
    puts string
    iterator = iterator + 1
  end
end

# refactored

def repeat(string, integer)
  integer.times { |_| puts string}
end

```