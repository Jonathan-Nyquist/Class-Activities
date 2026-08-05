#set document(
  title: "Honors Class 09 Activity: The Same Word Twice",
  author: "Elements of Data Science",
  keywords: ("data science", "honors", "booleans", "conditionals", "conditional probability", "activity"),
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
  #block(above: 14pt, below: 6pt, it.body)
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

= The Same Word Twice

#set par(justify: false)
*Team Members:* #blank(width: 3.4cm) #h(0.2cm) #blank(width: 3.4cm) #h(0.2cm) #blank(width: 3.4cm)

#v(0.2cm)
#h(2.55cm) #blank(width: 3.4cm) #h(0.2cm) #blank(width: 3.4cm)
#set par(justify: true)

#v(0.2cm)

Today you learn two things that share a name. A *conditional statement* in Python is an
`if`: do this when a condition holds. A *conditional probability* is a chance computed when
a condition holds. That is not a coincidence, and by the end of class you should be able to
say exactly what the two have in common.

== Part 1. Predicate Golf

Here are twelve patients. Four of them are marked.

#v(0.2cm)
#align(center)[
  #table(
    columns: (1.9cm, 1.9cm, 1.9cm, 1.9cm, 2.4cm),
    inset: 5.5pt,
    align: center,
    stroke: 0.5pt + rgb("#888888"),
    [*patient*], [*age*], [*sex*], [*cp*], [*thalach*],
    [1], [62], [M], [0], [165],
    table.cell(fill: rgb("#dcdcdc"))[*2*], table.cell(fill: rgb("#dcdcdc"))[*41*], table.cell(fill: rgb("#dcdcdc"))[*F*], table.cell(fill: rgb("#dcdcdc"))[*2*], table.cell(fill: rgb("#dcdcdc"))[*172*],
    [3], [58], [M], [1], [143],
    [4], [45], [M], [0], [148],
    [5], [67], [F], [3], [132],
    table.cell(fill: rgb("#dcdcdc"))[*6*], table.cell(fill: rgb("#dcdcdc"))[*52*], table.cell(fill: rgb("#dcdcdc"))[*F*], table.cell(fill: rgb("#dcdcdc"))[*2*], table.cell(fill: rgb("#dcdcdc"))[*168*],
    [7], [71], [M], [0], [125],
    table.cell(fill: rgb("#dcdcdc"))[*8*], table.cell(fill: rgb("#dcdcdc"))[*49*], table.cell(fill: rgb("#dcdcdc"))[*M*], table.cell(fill: rgb("#dcdcdc"))[*1*], table.cell(fill: rgb("#dcdcdc"))[*155*],
    [9], [54], [F], [0], [139],
    [10], [60], [M], [2], [158],
    table.cell(fill: rgb("#dcdcdc"))[*11*], table.cell(fill: rgb("#dcdcdc"))[*44*], table.cell(fill: rgb("#dcdcdc"))[*F*], table.cell(fill: rgb("#dcdcdc"))[*3*], table.cell(fill: rgb("#dcdcdc"))[*176*],
    [12], [56], [M], [1], [151],
  )
]
#v(0.2cm)

Write a boolean expression that selects the four marked patients — all of them, and nobody
else. Use column names, comparisons, and `&` (and), `|` (or), `~` (not). Parentheses around
each comparison are required: `(age < 50) & (thalach > 160)`.

*Scoring: fewest characters wins, spaces not counted.* No single comparison can do it, so
do not waste time looking for one.

#question[
  #set par(justify: false)
  1.1 Your expression: \
  #v(0.15cm)
  #blank(width: 14cm) \
  #v(0.15cm)
  Character count: #blank(width: 2cm) #h(1cm) Winning count in the room: #blank(width: 2cm)
]

#question[
  1.2 Another team's expression selects the same four patients but looks nothing like
  yours — theirs is built from `~` and yours is not, or the other way round. Write theirs
  here and explain why both are correct.
]

#answer-space(height: 2.4cm)

#question[
  1.3 In Python, `and` works on single values and `&` works on arrays. You will get an error
  today if you mix them up. What does that tell you about what `heart.column('age') > 55`
  actually *is* — one answer, or many?
]

#answer-space(height: 1.6cm)

== Part 2. Thirty-Six Outcomes

Roll two dice, one at a time. The row is the first die, the column is the second, and the
cell is the total. All thirty-six cells are equally likely.

#v(0.25cm)
#align(center)[
  #table(
    columns: (1.5cm,) * 7,
    rows: (0.85cm,) * 7,
    inset: 5pt,
    align: center + horizon,
    stroke: 0.5pt + rgb("#888888"),
    table.cell(fill: rgb("#eeeeee"))[], table.cell(fill: rgb("#eeeeee"))[*1*], table.cell(fill: rgb("#eeeeee"))[*2*], table.cell(fill: rgb("#eeeeee"))[*3*], table.cell(fill: rgb("#eeeeee"))[*4*], table.cell(fill: rgb("#eeeeee"))[*5*], table.cell(fill: rgb("#eeeeee"))[*6*],
    table.cell(fill: rgb("#eeeeee"))[*1*], [2], [3], [4], [5], [6], [7],
    table.cell(fill: rgb("#eeeeee"))[*2*], [3], [4], [5], [6], [7], [8],
    table.cell(fill: rgb("#eeeeee"))[*3*], [4], [5], [6], [7], [8], [9],
    table.cell(fill: rgb("#eeeeee"))[*4*], [5], [6], [7], [8], [9], [10],
    table.cell(fill: rgb("#eeeeee"))[*5*], [6], [7], [8], [9], [10], [11],
    table.cell(fill: rgb("#eeeeee"))[*6*], [7], [8], [9], [10], [11], [12],
  )
  #v(-0.1cm)
  #text(size: 9pt, style: "italic")[rows: first die #h(1cm) columns: second die]
]
#v(0.2cm)

#question[
  #set par(justify: false)
  2.1 Circle every cell containing a 7. \
  #v(0.05cm)
  #h(0.4cm) P(sum is 7) = #blank(width: 1.2cm)\/36 = #blank(width: 1.8cm)
]

#question[
  #set par(justify: false)
  2.2 Now cover everything except one row — you have been told what the first die was.
  Count the 7s in each row. \
  #v(0.1cm)
  #h(0.4cm) first die 1: #blank(width: 1cm)\/6 #h(0.5cm) 2: #blank(width: 1cm)\/6
  #h(0.5cm) 3: #blank(width: 1cm)\/6 #h(0.5cm) 4: #blank(width: 1cm)\/6
  #h(0.5cm) 5: #blank(width: 1cm)\/6 #h(0.5cm) 6: #blank(width: 1cm)\/6 \
  #v(0.1cm)
  #set par(justify: true)
  Knowing the first die changes your answer by how much? This is what *independence* looks
  like on paper.
]

#question[
  #set par(justify: false)
  2.3 In craps you win immediately on a 7 or an 11. Put a box around the 11s as well. \
  #v(0.1cm)
  P(win) = #blank(width: 1.2cm) \/ 36 = #blank(width: 1.8cm)
]

#question[
  #set par(justify: false)
  2.4 Cover everything but one row again. \
  #v(0.1cm)
  #h(0.4cm) P(win | first die is 3) = #blank(width: 1cm)\/6 #h(1.2cm)
  P(win | first die is 5) = #blank(width: 1cm)\/6 \
  #v(0.1cm)
  #set par(justify: true)
  Those are not equal, and neither equals your answer to 2.3. Something changed between 2.2
  and 2.4 — the dice did not. What did?
]

#answer-space(height: 2cm)

#question[
  #set par(justify: false)
  2.5 Now condition the other way. Of the winning cells, how many have a first die of 5? \
  #v(0.1cm)
  #h(0.4cm) P(first die is 5 | win) = #blank(width: 1cm)\/#blank(width: 1cm) = #blank(width: 1.6cm)
  #h(1.2cm) compare with 2.4: #blank(width: 1.6cm) \
  #v(0.1cm)
  #set par(justify: true)
  Same cells on top. Different cells underneath. Say in one sentence what the denominator of
  a conditional probability is.
]

#answer-space(height: 2cm)

== Part 3. Write a Diagnostic Rule

Open `Class09_Same_Word_Twice_Skeleton.ipynb`. The table holds 1,025 patients referred for
cardiac testing; `target` is 1 if they turned out to have heart disease.

#question[
  #set par(justify: false)
  3.1 P(disease) for the whole table: #blank(width: 2.5cm) — an *unconditional* probability.
]

#question[
  #set par(justify: false)
  3.2 P(disease | female) = #blank(width: 2.2cm) #h(1cm) P(female | disease) = #blank(width: 2.2cm) \
  #v(0.1cm)
  #set par(justify: true)
  Which of these is the grid from Part 2 again, and which cells changed?
]

#answer-space(height: 1.8cm)

Now the `if` statements. Your rule looks at a patient and returns `'flag'` — send them for
further testing — or `'clear'`. Then you grade it two ways.

#question[
  #set par(justify: false)
  3.3 The mediocre `example_rule` in the notebook: \
  #v(0.1cm)
  #h(0.4cm) P(flag | disease) = #blank(width: 2.2cm) #h(1.2cm) P(disease | flag) = #blank(width: 2.2cm)
]

#question[
  #set par(justify: false)
  3.4 The rule that flags everybody: \
  #v(0.1cm)
  #h(0.4cm) P(flag | disease) = #blank(width: 2.2cm) #h(1.2cm) P(disease | flag) = #blank(width: 2.2cm) \
  #v(0.1cm)
  #set par(justify: true)
  One of those is perfect. Explain in one sentence why that rule is nevertheless useless,
  and which of the two numbers caught it out.
]

#answer-space(height: 2cm)

#question[
  3.5 Write your team's best rule here — the conditions, in words or in code — along with
  its two scores.
]

#answer-space(height: 3cm)

#question[
  #set par(justify: false)
  3.6 Whose rule is best? Before the room votes, your team has to say which of the two
  numbers it is competing on, and why. \
  #v(0.1cm)
  #h(0.4cm) We are competing on: #h(0.4cm) P(flag | disease) #h(1cm) P(disease | flag)
]

#answer-space(height: 1.8cm)

== Discussion

#question[
  D1. An `if` statement in Python and the phrase "given that" in a probability are the same
  idea in two notations. Say what the idea is, using the word *subset*.
]

#answer-space(height: 2.4cm)

#question[
  D2. A lab reports that its heart disease test is "95% accurate." A patient gets a positive
  result and wants to know the chance they are sick. Which conditional probability is the
  lab quoting, which one does the patient want, and what else would you need to know to get
  from one to the other?
]

#answer-space(height: 2.8cm)

#question[
  D3. You tuned your rule by testing it on the same 1,025 patients you used to grade it.
  What would you expect to happen to your two scores if we ran your rule on a thousand
  patients from a different hospital, and why?
]

#answer-space(height: 2.8cm)
