#set document(
  title: "Honors Class07 Activity: Creating Python Functions",
  author: "Elements of Data Science",
  keywords: ("data science", "honors", "python", "functions", "parameters", "activity"),
)

#set page(
  paper: "us-letter",
  margin: (x: 1in, y: 1in),
)

#set par(justify: true, leading: 0.65em)
#set heading(numbering: none)
#set text(font: "Liberation Serif", size: 11pt, lang: "en", region: "us")

#show raw.where(block: true): it => block(
  fill: rgb("#f2f2f2"),
  inset: 8pt,
  radius: 3pt,
  width: 100%,
  text(font: "Liberation Mono", size: 9.5pt, it),
)
#show raw.where(block: false): it => text(font: "Liberation Mono", size: 9.5pt, it)

#show heading.where(level: 1): it => [
  #set align(center)
  #set text(size: 15pt, weight: "bold")
  #block(above: 0pt, below: 12pt, it.body)
]
#show heading.where(level: 2): it => [
  #set text(size: 12pt, weight: "bold")
  #block(above: 12pt, below: 6pt, it.body)
]

#let question(body) = block(
  width: 100%,
  inset: (left: 8pt, top: 4pt, bottom: 4pt),
  stroke: (left: 2pt + rgb("#4a4a4a")),
  text(weight: "bold", body),
)

#let blank(width: 2.5cm) = box(
  width: width,
  height: 0.9em,
  stroke: (bottom: 0.5pt + black),
)

#let answer-space(height: 2cm) = block(height: height, width: 100%)

= Honors Class 07 Activity: Creating Python Functions

#par(justify: false)[
  #box(width: 3.2cm)[*Team Members:*] #blank(width: 3.9cm) #h(0.4cm) #blank(width: 3.9cm) #h(0.4cm) #blank(width: 3.9cm)
]
#v(-0.15cm)
#par(justify: false)[
  #h(3.2cm) #blank(width: 3.9cm) #h(0.4cm) #blank(width: 3.9cm)
]

#v(0.2cm)

== Learning Objectives

- Understanding how to create and use Python functions
- The difference between parameters and arguments
- The difference between local and global variables
- Return statements
- Boolean variables
- Keyword arguments and default parameter values

In the last few classes, you've been using functions that other people have created.
Today, you'll learn how to create your own functions. This is a very important skill,
because it allows you to write code that is reusable and easier to read.

Once again, there is a starter Jupyter notebook under "class activities." Open the one
for `class_07`.

#question[
  Problem 1: Add a line to the function `print_one_dad_joke()` that prints "LOL" like this:
]

```python
def print_one_dad_joke():
    print("What did one plant say to the other? Aloe! Long thyme no see.")
    print("LOL")
```

Call the function to see the result.

Now remove the indent from the second `print` statement, run the cell, and call the
function again. *What happens? Why do you think that is?*

#answer-space(height: 1.6cm)

== Adding a parameter to a function

You don't want to have to redefine the function every time you change the joke, so we
will use a parameter to allow us to pass in a new joke each time we call the function.

Call the function `print_any_dad_joke()` with a new joke:

#align(center)[*"What brand of underwear do chemists wear? Kelvin Klein."*]

== Terminology Alert: Parameters vs. Arguments

The variables that are defined in the function definition are called *parameters*. The
values that you pass into the function when you call it are called *arguments*.

- Parameter #sym.arrow the variable name in the function definition
- Argument #sym.arrow the actual value passed into the function when you call it

#question[
  Problem 2: In our Function 2 example, what is the parameter? What is the argument?
]

#answer-space(height: 1.6cm)

== Creating a function with one parameter and one return value

The Function 3 example returned a value. Create a function called `square_it` that takes
one parameter (a number) and returns the square of that number. Test your function.

#question[
  Problem 3: What happens if you call your function without an argument? Why do you think
  that is?
]

#answer-space(height: 1.6cm)

In Function 4, we defined a function that takes two parameters. Create a function called
`add_numbers` that takes two parameters (numbers) and returns the sum of those numbers.
Test your function.

#question[
  Problem 4: What happens if you pass in strings to `add_numbers` instead of numbers as
  arguments? Why?
]

#answer-space(height: 1.6cm)

#question[
  Problem 5: What happens if you pass in more than two arguments? Why?
]

#answer-space(height: 1.6cm)

== Creating a function with multiple input parameters and multiple return values

#question[
  Problem 6: Create a function that calculates the area and perimeter of a rectangle given
  its length and width as parameters.
]

The function should return both the area and the perimeter. If you want an extra
challenge, return the length of the diagonal as well. *Test your function for a rectangle
with length 5 and width 3 and report the results.*

#answer-space(height: 1.6cm)

== Digression: Boolean variables

A Boolean variable is a variable that can only take on two values: `True` or `False`.
They are tested using comparison operators (`==`, `!=`, `<`, `>`, `<=`, `>=`) and logical
operators (`and`, `or`, `not`). Here is a simple example of a Boolean variable:

```python
a = 5
b = 10
is_a_greater_than_b = a > b
print(is_a_greater_than_b)
```

This will be `False` because 5 is not greater than 10. *Try it.*

Boolean variables are often used in conditional statements (if this, do that) to control
the flow of a program, a topic we will cover in more detail in a future class, but you
will see an example in Function 5.

#align(center)[*End Digression*]

== Function keyword arguments and default parameter values

When you define a function, you can specify default values for parameters. This allows
you to call the function without providing arguments for those parameters, and the
default values will be used instead.

Here is another example, a function called `greet` that takes one parameter, `name`, with
a default value of `"World"`. The function prints a greeting message that says
"Hello, \[name\]!"

```python
def greet(name="World"):
    print("Hello, " + name + "!")
```

#question[
  Problem 7: Call the `greet` function without an argument. What is the output? Now call
  it with your name as an argument. What is the output?
]

#answer-space(height: 1.6cm)

== Putting it all together

Look at the final example in the notebook, Function 6, which combines many of the
concepts you've learned today.

#question[
  Problem 8: What are the keyword arguments used for in this function? What are their
  default values?
]

#answer-space(height: 1.6cm)

== Extra Practice

Create a function called `fahrenheit_to_celsius` that takes one parameter (a temperature
in Fahrenheit) and returns the temperature in Celsius. The formula to convert Fahrenheit
to Celsius is:

#align(center)[$C = (F - 32) times 5 slash 9$]

Test your function with the following Fahrenheit values: 32, 68, 100, and 212. Report the
results.
