#set document(
  title: "Honors Class05 Activity: Practice Quiz Questions",
  author: "Elements of Data Science",
  keywords: ("data science", "honors", "Python", "quiz", "practice", "activity"),
)

#set page(
  paper: "us-letter",
  margin: (x: 1in, y: 1in),
)

#set text(font: "Liberation Serif", size: 11pt, lang: "en", region: "US")
#set par(justify: true, leading: 0.65em)
#set heading(numbering: none)

// ── Heading styles ─────────────────────────────────────────────────────────

#show heading.where(level: 2): it => block(
  above: 1.2em, below: 0.5em,
)[#text(weight: "bold", size: 12pt)[#it.body]]

#show heading.where(level: 4): it => block(
  above: 1.0em, below: 0.3em,
)[#text(weight: "bold", style: "italic", size: 11pt)[#it.body]]

// ── Helpers ────────────────────────────────────────────────────────────────

#let blank(width: 4cm) = box(
  width: width,
  stroke: (bottom: 0.5pt),
  inset: (bottom: 2pt),
  []
)

#let answer-space(height: 1.2cm) = block(width: 100%, height: height, [])

#show raw.where(block: false): it => box(
  fill: luma(240),
  inset: (x: 3pt, y: 1pt),
  radius: 2pt,
  text(font: "Liberation Mono", size: 10pt)[#it]
)

#show raw.where(block: true): it => block(
  width: 100%,
  fill: luma(245),
  stroke: (left: 3pt + luma(160)),
  inset: (x: 10pt, y: 8pt),
  radius: 2pt,
  text(font: "Liberation Mono", size: 10pt)[#it]
)

// Error message style
#let error-msg(body) = block(
  width: 100%,
  fill: rgb("fff0f0"),
  stroke: (left: 3pt + rgb("cc0000")),
  inset: (x: 10pt, y: 6pt),
  radius: 2pt,
  text(font: "Liberation Mono", size: 10pt, fill: rgb("cc0000"))[#body]
)

// ── Title ──────────────────────────────────────────────────────────────────

// Title as a tagged H1 heading
#show heading.where(level: 1): it => align(center)[
  #block(above: 0em, below: 1em)[
    #text(size: 16pt, weight: "bold")[#it.body]
  ]
]

= Honors Class05 Activity: Practice Quiz Questions

#v(1em)
*Team Members:* #blank(width: 9cm)
#v(0.3em)
#line(length: 100%, stroke: 0.5pt)

// ── Learning Objectives ────────────────────────────────────────────────────

== Learning Objectives

- Test your understanding
- Prepare for Quiz 1

This activity is practice for the first quiz. Answer the questions based on your programming
experience. If you are stuck, talk with a team member. If you are _really_ stuck, then try
the code in a Jupyter notebook, but keep in mind that you won't be able to do this on the
quiz.

// ── Problems 1–10 ──────────────────────────────────────────────────────────

==== Problem 1: What is the output?

```python
a = "I'm not arguing."
b = "I'm just explaining why I'm right."
print(a + b)
```
#answer-space()

==== Problem 2: What is the output?

```python
winter_months = ["December", "January", "February", "March"]
print(winter_months[3])
```
#answer-space()

==== Problem 3: What is the output?

```python
x = 2**3 / 8 + 3
print(x)
```
#answer-space()

==== Problem 4: What is the output?

```python
# What do you call a fish with no eyes?
answer = "fish".replace("i","")
answer
```
#answer-space()

==== Problem 5: Explain the error.

```python
my_tuple = ("Dr. Nyquist", "Geophysicist", "CST")
my_tuple[2] = "Earth & Environmental Science"
```
#error-msg[TypeError: 'tuple' object does not support item assignment]
#answer-space()

==== Problem 6: What is the output?

```python
import numpy as np
a = 3
b = 4
c = np.sqrt(a**2 + b**2)
```
#answer-space()

==== Problem 7: What is the output?

```python
np.arange(1, 7)
```
#answer-space()

==== Problem 8: What is the output?

```python
len("Data Science")
```
#answer-space()

==== Problem 9: What is the output?

```python
from datascience import *

x = make_array(1, -3, 12, -7, 0, -50)
max(abs(x))
```
#answer-space()

==== Problem 10: What is the output?

```python
colors = ["red", "blue", "green"]
colors.append("yellow")
print(colors)
```

// ── Page 2: Table Problems ──────────────────────────────────────────────────

#pagebreak()

==== The next 5 questions are based on the following data table named `dice_results`.

#v(0.5em)

#set table(
  stroke: 0.5pt + luma(180),
  inset: (x: 8pt, y: 5pt),
  align: center,
)

#show table.cell.where(y: 0): it => {
  set text(weight: "bold", size: 10pt)
  set table(fill: luma(225))
  it
}

#figure(
  table(
    columns: (3cm, 2cm, 3cm, 3cm, 2.5cm),
    fill: (_, y) => if y == 0 { luma(225) } else if calc.odd(y) { luma(248) } else { white },
    table.header(
      [Team], [Rolls], [Average Sum], [Number of 7s], [Avg − 7],
    ),
    [Team A], [50], [6.4], [7],  [−0.6],
    [Team B], [50], [7.1], [9],  [0.1],
    [Team C], [50], [6.8], [8],  [−0.2],
    [Team D], [50], [7.3], [11], [0.3],
    [Team E], [50], [6.6], [6],  [−0.4],
    [Team F], [50], [7.0], [8],  [0.0],
    [Team G], [50], [7.5], [12], [0.5],
    [Team H], [50], [6.9], [9],  [−0.1],
  ),
  caption: [Simulated dice roll results for eight teams, each rolling 50 times],
  numbering: none,
)

#v(0.8em)

==== Problem 11: What is the output?

```python
import numpy as np

np.max(dice_results.column("Number of 7s"))
```
#answer-space()

==== Problem 12: What is the output?

```python
dice_results.take(2)
```
#answer-space()

==== Problem 13: What is the output?

```python
dice_results.where("Average Sum", are.below(6.5))
```
#answer-space()

==== Problem 14:

Write Python code to find the average number of 7s.
#answer-space(height: 1.8cm)

==== Problem 15:

Write Python code to sort the table by Avg − 7.

// ── Design Your Own ────────────────────────────────────────────────────────

#pagebreak()

== Design Your Own Quiz Questions

Work with your team to design up to five quiz questions. If you design good ones, you may
see them on the actual quiz!
