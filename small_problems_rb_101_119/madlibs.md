Mad libs are a simple game where you create a story template with blanks for words. You, or another player, then construct a list of words and place them into the story, creating an often silly or funny story as a result.

Create a simple mad-lib program that prompts for a noun, a verb, an adverb, and an adjective and injects those into a story that you create.

Example

``` ruby
Enter a noun: dog
Enter a verb: walk
Enter an adjective: blue
Enter an adverb: quickly

Do you walk your blue dog quickly? That's hilarious!
```

#### inputs and outputs
inputs: string that are a noun, verb, adjective, and adverb

output: string containing all of the given inputs

#### explicit requirements

``` ruby
Enter a noun: dog
Enter a verb: walk
Enter an adjective: blue
Enter an adverb: quickly

Do you walk your blue dog quickly? That's hilarious!
```

#### implicit requirements

letters only

#### mental model

``` ruby
=begin

prompt the user for a noun
store the given string as a variable named noun

prompt the user for a verb
store the given string as a variable named verb

prompt the user for an adjective
store the given string as a variable named adjective

prompt the user for an adverb
store the given string as a variable named adverb

  
output "Do you #{verb} your #{adjective} #{noun} #{adverb}? That's hilarious!"

=end
```

#### examples and test cases
how would you go about making test cases for this?

#### data structure

none

#### algorithm
``` ruby
START

  PRINT "What noun would you like to use?"
  SET noun = gets.chomp

  PRINT "What verb would you like to use?"
  SET verb = gets.chomp

  PRINT "What adjective would you like to use?"
  SET adjective = gets.chomp
  
  PRINT "What adverb would you like to use?"
  SET adverb = gets.chomp
  
  PRINT "Do you #{verb} your #{adjective} #{noun} #{adverb}? That's hilarious!"

END
```

#### code with intent

``` ruby

print 'What noun would you like to use?'
noun = gets.chomp

print 'What verb would you like to use?'
verb = gets.chomp

print 'What adjective would you like to use?'
adjective = gets.chomp

print 'What adverb would you like to use?'
adverb = gets.chomp

puts "Do you #{verb} your #{adjective} #{noun} #{adverb}? That's hilarious!"

```