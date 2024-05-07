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

- The string`Hello`
- The positive integer `1`

## implicit requirements

- negative numbers are not allowed
- the first argument must be a string

## clarifying questions

- question is simple 
- you could use this also as a way of asking if certain things should be tested for or not

## mental model

Take two inputs and verify that they are a string and an integer. Add a newline character to the end of the string. Create a final array which will be used as the return value. Use the integer as an iterator and add each iteration to each element in the string. Finally, join the array together while removing the final newline character.

The above simulates the outputted format given in the problem. This is done to try and test various solutions


## test cases

``` ruby

# numerical value tests

p repeat('hello', 2) == "hello\nhello"
p repeat('hello', 1.5) == false
p repeat('hello', 1) == 'hello'
p repeat('hello', 0) == ''
p repeat('hello', -1) == false

# string value tests

p repeat('hello', 2) == "hello\nhello"
p repeat('hello hello', 2) == "hello hello\nhello hello"
p repeat('', 2) == "\n"
p repeat('26', 2) == "26\n26"
p repeat('-26', 2) == "-26\n-26"

# wrong format tests

p repeat() == false
p repeat('hello') == false
p repeat(0) == false
p repeat(0, 'hello') == false

```
## data structure
array

## algorithm

Take two inputs and verify that they are a string and an integer. Add a newline character to the end of the string. Create a final array which will be used as the return value. Use the integer as an iterator and add each iteration to each element in the string. Finally, join the array together while removing the final newline character.

given a string called 'string' and a positive integer called 'integer'

START

1. verify the user has given a string and an integer
2. SET string = string + "\n"
3. SET final_array = []
4. WHILE integer > 0\
	i. final_array.push(string)\
	ii. integer = integer -1
5. final_array.join.chomp

END
## one manual test

1. verify the user has given a string and an integer


``` ruby
return false unless correct_arguments?('string', 5) 
```

2. SET string = string + "\n"


```ruby
	string = "string\n"
```

3. SET final_array = []


```ruby
	final_array = []
```

4. WHILE integer > 0


```ruby
	final_array.push("string\n"
    integer = 5 - 1..... all the way to 0
```

5. final_array.join.chomp

```ruby
	'string\nstring\nstring\nstring\nstring"
```


## code with intent

```ruby

def repeat(string=nil, integer=nil)
  return false unless correct_inputs?(string, integer)
  string = string + "\n"
  final_array = []
  while integer > 0
    final_array.push(string)
    integer -= 1
  end\
  final_array.join.chomp
end

def correct_inputs?(string, integer)
  return false if integer.to_i < 0
  return false if string.nil? || integer.nil?
  string.is_a?(String) && integer.is_a?(Integer)
end

# numerical value tests

p repeat('string', 2) == "string\nstring"
p repeat('string', 1.5) == false
p repeat('string', 1) == 'string'
p repeat('string', 0) == ''
p repeat('string', -1) == false

# string tests

p repeat('string', 2) == "string\nstring"
p repeat('string string', 2) == "string string\nstring string"
p repeat('', 2) == "\n"
p repeat('26', 2) == "26\n26"
p repeat('-26', 2) == "-26\n-26"


# wrong format tests

p repeat == false
p repeat('string') == false
p repeat(0) == false
p repeat(0, 'string') == false

```