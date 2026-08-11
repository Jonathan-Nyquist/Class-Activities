#set document(
  title: "Honors Class 14 Activity: Why Two Years?",
  author: "Elements of Data Science",
  keywords: ("data science", "honors", "trend", "sign test", "lag", "activity"),
)

#set page(
  paper: "us-letter",
  margin: (x: 1in, y: 0.75in),
)

#set par(justify: true, leading: 0.6em, spacing: 0.85em)
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

#let stopbar(body) = block(
  width: 100%,
  inset: 7pt,
  stroke: (top: 1.5pt + black, bottom: 1.5pt + black),
  align(center, text(weight: "bold", body)),
)

= Why Two Years?

*Team Members:* #h(0.2cm) #blank(width: 4.2cm) #h(0.3cm) #blank(width: 4.2cm) #h(0.3cm) #blank(width: 4.2cm)

#v(0.3cm)
#h(2.85cm) #blank(width: 4.2cm) #h(0.3cm) #blank(width: 4.2cm)

== Part 1 --- Before we look at anything

In Lab 7 you tested for a temperature trend by counting how many times the temperature went
*up* two years later versus how many times it went *down*. Here is the function you wrote:

```
def changes(array, years = 2):
    "Increases minus decreases after two years."
```

You found far more increases than decreases, got a p-value near zero, and rejected the null.
Look at the `2`.

#question[
1. What lag would *you* have chosen? Each team member write your own answer, then compare.
]

#h(0.6cm) My lag: #blank(width: 2cm) #h(1cm) Others on my team chose: #blank(width: 6.5cm)

#question[
2. If we ran the same test using your lag instead of 2, would the conclusion change?
  Circle one and give a one-sentence reason.
]

#h(0.6cm) YES #h(1.2cm) NO #h(1.2cm) NOT SURE

#v(0.1cm)
#blank(width: 15.4cm)
#v(0.3cm)
#blank(width: 15.4cm)

#v(0.15cm)
#stopbar[STOP. Do not go on until every member of your team has answered 1 and 2.]

== Part 2 --- Seven years, checked by hand

Below are seven consecutive years of average annual temperature. These numbers are invented,
not measured --- they are small enough that you can check every claim yourself.

#align(center)[
  #table(
    columns: (1.5cm,) * 8,
    align: center,
    inset: 5pt,
    table.header([*Year*], [1], [2], [3], [4], [5], [6], [7]),
    [*Temp*], [12.4], [12.3], [11.8], [12.7], [13.4], [12.8], [13.2],
  )
]

At a lag of 1 year, the six differences are $-0.1, -0.5, +0.9, +0.7, -0.6, +0.4$: three
increases, three decreases, net $0$. That row is filled in for you as a model.

#question[
3. Complete the table for lags 2 through 6.
]

#block(breakable: false)[
#align(center)[
  #table(
    columns: (1.8cm, 3.2cm, 2.6cm, 2.6cm, 3.2cm),
    align: center,
    inset: 5.5pt,
    table.header([*Lag*], [*Comparisons*], [*Increases*], [*Decreases*], [*Net (Inc #sym.minus Dec)*]),
    [1], [6], [3], [3], [0],
    [2], [5], [], [], [],
    [3], [4], [], [], [],
    [4], [3], [], [], [],
    [5], [2], [], [], [],
    [6], [1], [], [], [],
  )
]
]

#question[
4. Circle the row that matches the lag Lab 7 used. Out of the comparisons it made, how many
  pointed toward warming?
]

#h(0.6cm) #blank(width: 14.5cm)

#question[
5. Which lag gives the strongest evidence of warming? Is it the lag you wrote down in
  question 1?
]

#h(0.6cm) #blank(width: 14.5cm)

#question[
6. Add up the Net column for all six lags. What is the total?
]

#h(0.6cm) Total: #blank(width: 2.5cm)

#question[
7. You just combined every lag into one number. What decision did that let you avoid making?
]

#h(0.6cm) #blank(width: 14.5cm)
#v(0.3cm)
#h(0.6cm) #blank(width: 14.5cm)

== Part 3 --- Counting what you actually have

Adding up every lag is the same thing as comparing *every year to every other year*. Check
that: your Comparisons column should total $6 + 5 + 4 + 3 + 2 + 1 = 21$, and there are
exactly 21 ways to pick two years out of seven. To decide whether a total like the one in question 6 is surprising, Lab 7's
approach was to build a null distribution by flipping a fair coin for each comparison ---
Increase or Decrease --- and seeing how large the total got by chance.

#question[
8. Suppose year 3 is colder than year 5, and year 5 is colder than year 7. Before doing any
  arithmetic: what *must* the comparison between year 3 and year 7 be?
]

#h(0.6cm) #blank(width: 14.5cm)

#question[
9. Based on your answer to question 8, what is wrong with simulating the 21 comparisons as 21
  independent coin flips --- and does that error leave you too cautious about the trend, or
  too confident?
]

#h(0.6cm) #blank(width: 14.5cm)
#v(0.3cm)
#h(0.6cm) #blank(width: 14.5cm)

== If You Finish Early

#question[
A. You have 21 comparisons but fewer than 21 independent pieces of information. Roughly how
  many independent pieces do you think there are? Defend any number you like --- there is a
  real answer, but the argument matters more than the number.
]

#answer-space(height: 1.6cm)

#question[
B. Here is a different strategy: compute a p-value separately at each of the six lags, then
  report the smallest one. Explain why this is *not* the same as adding all the lags
  together, even though both use all six.
]

#answer-space(height: 2.1cm)
