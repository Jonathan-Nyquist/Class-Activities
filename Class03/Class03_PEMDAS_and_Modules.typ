#set document(
  title: "Honors Class03 Activity: PEMDAS and Modules",
  author: "Elements of Data Science",
  keywords: ("data science", "honors", "Python", "order of operations", "activity"),
)

#set page(
  paper: "us-letter",
  margin: (x: 1in, y: 1in),
)

#set par(justify: true, leading: 0.65em)
#set text(font: "Liberation Serif", size: 11pt, lang: "en", region: "US")
#set heading(numbering: none)

// ── Heading styles ─────────────────────────────────────────────────────────

#show heading.where(level: 2): it => block(
  above: 1.2em, below: 0.5em,
)[#text(weight: "bold", size: 12pt)[#it.body]]

#show heading.where(level: 3): it => block(
  above: 1.0em, below: 0.4em,
)[#text(weight: "bold", size: 11pt)[#it.body]]

#show heading.where(level: 4): it => block(
  above: 0.9em, below: 0.3em,
)[#text(weight: "bold", style: "italic", size: 11pt)[#it.body]]

// ── Helpers ────────────────────────────────────────────────────────────────

#let blank(width: 4cm) = box(
  width: width,
  stroke: (bottom: 0.5pt),
  inset: (bottom: 2pt),
  []
)

#let answer-space(height: 1.2cm) = block(width: 100%, height: height, [])

// Inline code style
#show raw.where(block: false): it => box(
  fill: luma(240),
  inset: (x: 3pt, y: 1pt),
  radius: 2pt,
  text(font: "Liberation Mono", size: 10pt)[#it]
)

// Code block style
#show raw.where(block: true): it => block(
  width: 100%,
  fill: luma(245),
  stroke: (left: 3pt + luma(160)),
  inset: (x: 10pt, y: 8pt),
  radius: 2pt,
  text(font: "Liberation Mono", size: 10pt)[#it]
)

// ── Title ──────────────────────────────────────────────────────────────────

// Title as a tagged H1 heading
#show heading.where(level: 1): it => align(center)[
  #block(above: 0em, below: 1em)[
    #text(size: 16pt, weight: "bold")[#it.body]
  ]
]

= Honors Class03 Activity: PEMDAS and Modules

#v(1em)
*Team Members:* #blank(width: 9cm)
#v(0.3em)
#line(length: 100%, stroke: 0.5pt)

// ── Learning Objectives ────────────────────────────────────────────────────

== Learning Objectives

- Order of operations in Python (PEMDAS)
- Using functions from modules
- Turning word problems into code

// ── Part 1 ─────────────────────────────────────────────────────────────────

== Part 1: PEMDAS in Python

In Python, the order of operations follows the PEMDAS rule:

#block(inset: (left: 1em))[
  - #strong[P]arentheses
  - #strong[E]xponents
  - #strong[M]ultiplication and #strong[D]ivision (from left to right)
  - #strong[A]ddition and #strong[S]ubtraction (from left to right)
]

Create a Jupyter notebook and code the following expressions in Python to find the solutions.
Check with your teammates that you are getting the same result:

#v(0.5em)

#let expr-row(num, eq) = grid(
  columns: (1.5em, 1fr, 3cm),
  gutter: 0.4em,
  align: (right, left, left),
  [#num.], eq,
  box(width: 3cm, stroke: (bottom: 0.5pt), inset: (bottom: 2pt), [])
)

#expr-row(1, $(4^2 - 5 times 3) div (12 div 3) + 7 = $)
#v(0.5em)
#expr-row(2, $3^3 - [2 times (14 - 3^2)] div 4 = $)
#v(0.5em)
#expr-row(3, $((5^3 - 2^4) div (18 div 3) + 4^2) / ((7 - 3)^2) = $)
#v(0.5em)
#expr-row(4, $6^2 - [(3 times (2^5 - 4^2)) / ((9 - 3)^2)] = $)
#v(0.5em)
#expr-row(5, $((4^3 + 2^5) / 3^2 - 5) div (1 + 8 / 2^3) = $)

// ── Part 2 ─────────────────────────────────────────────────────────────────

== Part 2: Using Modules in Python

=== Built-in Python Functions

Many math functions are built into the Python programming language.

*Create a new Jupyter notebook and try entering the following code:*

```python
maximum_number = max(3, 4.4, 12, 0, -8)
maximum_number
```

You are calling the Python function `max()` and assigning the result to the variable
`maximum_number`. Then, when you type the variable name on a separate line the result is
displayed. Naturally, there is also a `min()` function.

*Try `min()` with the same set of numbers.*

=== External Modules

To keep Python lean, not every function is baked into the language. Often you must load the
functions you need from an external module. Here we import the `math` module so we have
access to the value pi. Try this:

```python
import math
print(math.pi)
```

After you have imported the `math` module, you have access to all of its functions using dot
notation. Thus, `math.pi` gives you the value for pi from the `math` module.

*Use `math.pi` to find the area of a circle with a radius of 4:* #blank(width: 4cm)

The `math` module contains many functions. *To see the complete list, type `dir(math)` in a
code cell that comes after you have imported the math module.*

There are many, many modules available in Python. Each module is a library of functions
designed to assist with a particular task — math problems, machine learning, plotting graphs,
working with databases, designing websites, creating games — you name it, there is probably a
Python module that does it! Often, more than one. You will become familiar with quite a few
Python modules in this course.

// ── Part 3 ─────────────────────────────────────────────────────────────────

== Turning Word Problems into Code

Learning to program is all about breaking down a problem into simple steps that can be
expressed in code. Computers do precisely what you tell them to do — no more, no less. You
need to know exactly what steps are needed before you can create a program that solves a
problem. Your instructions have to be clear and free of typos. Let's code some simple word
problems for practice.

==== Problem

A stream's water level was measured at four times during the day:
1.12, 1.18, 1.09, 1.15 meters.
What is the average water level? #blank(width: 4cm)

==== Problem

A pond's water level increased from 0.85 m to 0.92 m after rainfall.
What is the percent increase?
#v(0.05cm)
#blank(width: 4cm)

==== Problem

A student's final grade is:
- Homework: 30% (92)
- Midterm: 25% (85)
- Final: 45% (88)

What is the final numeric grade? #blank(width: 4cm)

=== Breaking Down Longer Problems

As problems become more complicated, it is important to solve them in steps, creating Python
variables to hold intermediate values.

==== Problem

An environmental science class is planning a field trip.
- The bus costs \$485 total.
- Each student ticket costs \$12.50.
- There are 28 students and 2 instructors, and instructors do not pay ticket fees.

The department will subsidize 40% of the total cost.

*What is the cost per student after the subsidy? Let's work an example together.*

```python
bus_cost = 485
ticket_cost = 12.5
num_students = 28
subsidy = 0.4

total_cost = bus_cost + ticket_cost * num_students
print("The total cost is:", total_cost)

cost_with_subsidy = total_cost - total_cost * subsidy
print("Cost after subsidy is:", cost_with_subsidy)

cost_per_student = cost_with_subsidy / num_students
print("Cost per student is:", cost_per_student)
```

==== Key points
#v(0.1cm)
- Print and check intermediate results. It is easier to debug your code when the final answer
  is not what you expected.
- Pick variable names that are easy to understand.

Once a solution is programmed this way, it is easy to change a value.

*Suppose the department decides to increase the subsidy to 50%. What is the new price per
student?* 
#v(.2cm)
#blank(width: 3cm)

Now it is your turn. Create as many code cells as you need.

==== Problem

A rain gauge recorded rainfall over three consecutive intervals:
- 18 mm in 30 minutes
- 22 mm in 45 minutes
- 10 mm in 15 minutes

*What was the total rainfall?*
#answer-space(height: 1.0cm)

*What was the average rainfall rate (mm/hr) over the entire storm?*
#answer-space(height: 1.0cm)

==== Problem
#v(0.1cm)
A field crew orders sampling supplies:
- 6 test kits at \$18.75 each
- 3 calibration solutions at \$42.00 each

Shipping costs \$24.50. Sales tax is 7.25% and applies only to the supplies, not shipping.
After everything is purchased, the vendor issues a \$35 rebate.

*What is the final total cost?*
#answer-space(height: 1.2cm)

// ── Reflection ─────────────────────────────────────────────────────────────

== Reflection

Each team member solved at least one problem using intermediate variables.
- Choose one problem you all attempted.
- How did your variable choices and variable names differ?
- Did one approach feel clearer or easier to debug? Why?
