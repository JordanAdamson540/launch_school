Write a method that will take a short line of text, and print it within a box.

Example:

``` ruby
print_in_box('To boldly go where no one has gone before.')
+--------------------------------------------+
|                                            |
| To boldly go where no one has gone before. |
|                                            |
+--------------------------------------------+
```

``` ruby
print_in_box('')
+--+
|  |
|  |
|  |
+--+
```

You may assume that the input will always fit in your terminal window.

#### input and output

input: string

output: string

#### explicit requirements

``` ruby

+--------------------------------------------+
|                                            |
| To boldly go where no one has gone before. |
|                                            |
+--------------------------------------------+

+--+
|  |
|  |
|  |
+--+

```

#### implicit requirements

- you must have a border around your text
- there must be padding of one row above and below the string

#### clarifying questions

none (yet)

#### mental model


``` ruby
=begin
given a string

1. a string value "|\s{string}\s|" will be assigned to the variable 
  formatted_string
2. the length of formatted_string will be assigned to the variable 
  formatted_string_length
3. a string value "\s" will be multiplied by formatted_string_length - 4 and 
  assigned to a variable called padding. Padding will have 
  "|\s" prepended and "\s|" appended
4. a string value "-" will be multipled by formatted_string_length - 2 and 
  assigned to variable called perimeter. Perimeter will have "+" prepended and 
  appended
5. output perimeter
   output padding
   output formatted string
   output padding 
   output perimeter

=end
```

#### examples and test cases

``` ruby

+--------------------------------------------+
|                                            |
| To boldly go where no one has gone before. |
|                                            |
+--------------------------------------------+

+--+
|  |
|  |
|  |
+--+

```

#### data structure

a string is passed into the method and a string is outputted from the method

#### algorithm

``` ruby
=begin
given a string

1. a string value "|\s{string}\s|" will be assigned to the variable 
  formatted_string
2. the length of formatted_string will be assigned to the variable 
  formatted_string_length
3. a string value "\s" will be multiplied by formatted_string_length - 4 and 
  assigned to a variable called padding. Padding will have 
  "|\s" prepended and "\s|" appended
4. a string value "-" will be multipled by formatted_string_length - 2 and 
  assigned to variable called perimeter. Perimeter will have "+" prepended and 
  appended
5. output perimeter
   output padding
   output formatted string
   output padding 
   output perimeter


given a string called 'string'

START

SET formatted_string = "|\s{string}\s|"
SET formatted_string_length = formatted_string.length
SET padding = ("\s" * (formatted_length - 4)).push("|\s").unshift("\s|")
SET perimeter = "-" * (formatted_length - 2).push("+").unshift("+")

PRINT perimeter
PRINT padding
PRINT formatted_string
PRINT padding
PRINT perimeter

END
=end
```

#### code with intent

``` ruby
def print_in_box(string)
  formatted_string = "|\s#{string}\s|"
  formatted_string_length = formatted_string.length
  padding = ("\s" * (formatted_string_length - 4)).insert(0, "|\s").insert(-1, "\s|")
  perimeter = ("-" * (formatted_string_length - 2)).insert(0, "+").insert(-1, "+")
  
  puts perimeter
  puts padding
  puts formatted_string
  puts padding
  puts perimeter
end

print_in_box('To boldly go where no one has gone before.')
print_in_box('')
```

#### refactor

``` ruby
def print_in_box(string)
  padding = "|#{' ' * (string.length + 2)}|"
  perimeter = "+#{'-' * (string.length + 2)}+"
  
  puts perimeter
  puts padding
  puts "|\s#{string}\s|"
  puts padding
  puts perimeter
end

print_in_box('To boldly go where no one has gone before.')
print_in_box('')
```

