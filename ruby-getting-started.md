# Getting started with Ruby

Before creating our own Blog, let's get familiar with the Ruby programming language.

## Let's check if everyone has Ruby installed by typing

```bash
ruby -v
```

If you get a similar answer you won:

```
ruby 2.4.4p296 (2018-03-28 revision 63013)
```

Don't worry if you don't have Ruby installed, we'll help you with that.

## Playing around with Interactive Ruby

First let's play around using the interactive Ruby, on Windows press the Windows key and start typing 'Interactive Ruby', then hit enter. On Mac and Linux open a terminal window and type in `irb`.

Once you have interactive ruby running, go and type in *anything* you want.

Most likely you'll get an error as Ruby couldn't understand what you instructed it to do; this is completely fine, you'll see several similar messages as a programmer every day.

Now let's do a simple math, type

```ruby
2 + 3
```

Ruby could understand this. In fact, it calculated the result for you.

Congratulations, you just created a program. It's kind of limited, but that's ok for now.

Now let's type the following command:

```ruby
puts "Hi, I'm ruby"
```

You'll see that Ruby printed the text to the output, that's what the `puts` command does. Note the quotation mark (`"`), it tells Ruby that this is a so called **String**, which is a piece of text.

Try this one:

```ruby
puts "Hi," + " I'm ruby"
```

The plus (`+`) sign concatenated the two Strings into one. That's cool.

Let's try something interesting:

```ruby
puts 3 + "2"
```

Once again, you got an error. That's because `3` is an `Integer` and `"2"` is a `String`.

These are called **types**.

There are several types in Ruby, and we'll see a few other ones later. For now, it's enough to remember we have Integer and String.

## Variables

Now type in this:

```ruby
result = 2 + 3

puts result
```

This way we created a new **variable** called `result`. Variables are used to store information in the memory and later you can use them to retrieve the information. In the example above we calculated the sum of 2 and 3, then stored the result in a new variable called `result`. In the programming world we call this `assignment` , we told Ruby to assign the value `5` to the variable `result`.

From now on we can use this variable as many times as we wish:

```ruby
puts result * 2
```

Now, create a variable named `name` and assign your name to it as a String.

The following line should print out your name:

```ruby
puts name
```

## More complex example

Now let's try this one, it calculates the square root of 25:

```ruby
Math.sqrt 25
```

Note that period mark (`.`) here, it means that the `sqrt` operation **belongs to** Math.

Now go ahead and compute the cosine of 1. You can use the `cos` operation from Math.

## Type conversion

Sometimes we want to convert between different types, e.g. we have a String and would like to convert it to an Integer to be able to do calculations.

```ruby
puts "2".to_i + 3
```

We've used the `to_i` operation, which belongs to the String "2", and converts our String to in Integer. This way we can safely use the `+` operation to calculate the sum.

## Working with files

Now you can close the Interactive Ruby shell.

Programmers usually write software in text files, and that's what we'll learn to do now.

Create a new folder in you Home called `MyFirstRubyProgram`, open the folder and create a new file called `first.rb`.

Open up `first.rb` in VS Code.

Type the following lines:

```ruby
puts "What's your name?"
name = gets

puts "Nice to meet you, " + name
```

Open up a terminal window and go to the `MyFirstRubyProgram` folder, and run your code using

```bash
ruby first.rb
```

We asked Ruby to open the file called `first.rb` and run every line.

You'll see that this program asks for your name, you can type in your name, and then it greets you. The `gets` command is used for the input part.

Now change the program to ask for the user's `first_name` and `last_name` separately. (Yes, you can use the underscore (`_`) character in a variable name).

The program should print the first and last name separated by a space character.

Note that `gets` will put an extra new line character at the end of your Strings. You can use the `chomp` function to get rid of it. E.g.

```ruby
first_name = first_name.chomp
```

## My first calculator

Your task now is to create a very simple calculator. The program should ask for two numbers (`a` and `b`) and print the sum of the numbers.

Here is the frame of the program:

```ruby
puts "Please input the first number:"

# store the user input into variable `a`


puts "Please input the second number:"

# store the user input into variable `b`

# Calculate a + b and store the sum in the `result` variable

puts "The sum of the two number in: " + result
```

Note that lines starting with a hash mark (`#`) are called comments, and are ignored by Ruby.

### Extend the program

The program now should ask for 4 numbers, a, b, c and d, and calculate a + b and c + d.

### Let's do more complicated math

Extend the application to calculate the square root of (a + b) * 2, and the square root of (c + d) * 2. Note that you have to use parentheses (`(`) to make sure the sum is computed before the multiplication.

Notice that **you had to change two separate lines**, because you copied the calculation over.

## Functions

For operations which can be repeated you can create functions in your program:

```ruby
def do_math number1, number2
    return Math.sqrt (number1 + number2) * 2
end

do_math a, b
do_math c, d
```

This way we created a **function** called `do_math` and returned the result of the calculation. Later, we could use this method to do the same operation twice.

Now we can tell you that `puts` and `gets` are also functions, which are provided by default. Also, `sqrt` is also a function which belongs to Math.

Go ahead and change your program to use a function to avoid code duplication.

## Conditions

Sometimes we only want to do something if certain conditions are met. E.g. we can't calculate the square root of negative numbers (let's ignore complex numbers for this exercise). 

```ruby
puts "Please input a number, and I'll tell the square root of it!"
number = gets.to_i

if number < 0
    puts "The number is negative; sorry, I won't be able to calculate the square root of it"
else
    puts "The square root of the number is: " + Math.sqrt(number).to_s
end
```

As you can see the square root is calculated only if the number is positive or zero.

Improve the `do_math` function: only calculate the square root if the partial result of the calculation is larger than zero. Otherwise print a nice error message and return -1.

## Array

Sometimes you want to store series of information, e.g. not just a single number, but an array of numbers:

```ruby
numbers = [11, 23, 43, 94]


puts numbers[0]
puts numbers[1]
puts numbers[2]
puts numbers[3]
```

Notice that to access the first number in the array we had to use `numbers[0]`. This is common in the programming world for historical reasons.

We can extend the the previous exercise to store the result of the calculations in an array:

```ruby
results = []  # let's create an empty array

results.push do_math a, b
results.push do_math c, d

puts results
```

The `push` function of the array adds a new element to the array.

If we want to do an operation for each element in an array we can use the `each` function:

```ruby
results.each do | result |
    puts result + 1
end
``` 

This way we printed every result incremented by one.

## Hash

Hashes are similar to arrays as they store series of information, but every piece of data has a label. These are called key-value pairs, e.g. store the exam results of students. The keys are the name of the student and the value is the score.

```ruby
exam_scores = { "Peter" => 15, "Levente" => 15, "Pavla" => 20 }

puts exam_scores["Peter"]
puts exam_scores["Levente"]
puts exam_scores["Pavla"]
```

You can also add results later:

```ruby
exam_scores["Bara"] = 20

puts exam_scores["Bara"]
```

You can go through each item in a hash similar to an array:

```ruby
exam_scores.each do |name, score|
    puts name + " scored " + score.to_s
end
```

## Final exercise before the blog

You know enough to start creating your own blog. That's really good, but let's do a final exercise to practice what you've learned so far.

Create a program which asks for the exam results of students: ask for 5 exam result. For every student, first ask for the name of the student, then for the result. Store the scores in a Hash. 

After you have the 5 student score print every score. If the score is above 25, then the student passed the exam, so write "Peter passed the exam". Otherwise print "Peter failed the exam".
