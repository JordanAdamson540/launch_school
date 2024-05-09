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
1. create an empty array called final array, which will end up being the return value at the end of the method
2. reassign the string to the string with a newline character added to the end
3. As long as the integer given is greater than 0
  i. append the string to the end of the final array
  ii. subtract one from the integer
4. When the final array is complete, join the array into one string and eliminate the final newline character from the end
```

## test cases

``` ruby

# numerical value tests

p repeat('hello', 2) == "hello\nhello"
p repeat('hello', 1) == 'hello'
p repeat('hello', 0) == ''

# string value tests

p repeat('hello', 2) == "hello\nhello"
p repeat('hello hello', 2) == "hello hello\nhello hello"
p repeat('', 2) == "\n"
p repeat('26', 2) == "26\n26"
p repeat('-26', 2) == "-26\n-26"

```
## data structure

string as the input => array stores the amount of times the string will be outputted based on integer given => converted back to string before output 

## algorithm
``` ruby
1. create an empty array called final array, which will end up being the return value at the end of the method
2. reassign the string to the string with a newline character added to the end
3. As long as the integer given is greater than 0
  i. append the string to the end of the final array
  ii. subtract one from the integer
4. When the final array is complete, join the array into one string and eliminate the final newline character from the end
---
given a string called 'string' and a positive integer called 'integer'

START

1. SET final_array = []
2. SET string_with_newline = string + "\n"
3. WHILE integer > 0
  i. final_array.push(string_with_newline)
  ii. SET integer = integer - 1
4. final_array.join.chomp

END
```


## code with intent

```ruby

def repeat(string, integer)
  final_array = []
  string_with_newline = string = string + "\n"

  while integer > 0
    final_array.push(string_with_newline)
    integer -= 1
  end

  final_array.join.chomp
end

# numerical value tests

p repeat('string', 2) == "string\nstring"
p repeat('string', 1) == 'string'

# string tests

p repeat('string', 2) == "string\nstring"
p repeat('string string', 2) == "string string\nstring string"
p repeat('', 2) == "\n"
p repeat('26', 2) == "26\n26"
p repeat('-26', 2) == "-26\n-26"

```