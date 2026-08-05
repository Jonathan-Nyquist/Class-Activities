#set document(
  title: "Honors Class 12 Activity: Grouping and Pivoting",
  author: "Elements of Data Science",
  keywords: ("data science", "honors", "group", "pivot", "aggregation", "confounding", "activity"),
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

= Grouping and Pivoting

#set par(justify: false)
*Team Members:* #blank(width: 3.4cm) #h(0.2cm) #blank(width: 3.4cm) #h(0.2cm) #blank(width: 3.4cm)

#v(0.2cm)
#h(2.55cm) #blank(width: 3.4cm) #h(0.2cm) #blank(width: 3.4cm)
#set par(justify: true)

#v(0.2cm)

The same 1,025 cardiac patients you wrote a diagnostic rule for in Class 09. Today you get
two methods that summarize an entire table at once, and then spend the rest of the period
finding out what they hide. Open `Class12_Grouping_and_Pivoting.ipynb`.

== Part 1. The Long Way #h(1fr) #text(size: 9pt, style: "italic", weight: "regular")[8 minutes]

#question[
  #set par(justify: false)
  1.1 Split the patients at the median age. Median age: #blank(width: 2cm) \
  #v(0.05cm)
  Average cholesterol — younger: #blank(width: 2.2cm) #h(0.5cm) older: #blank(width: 2.2cm) \
  #v(0.05cm)
  Average resting blood pressure — younger: #blank(width: 2.2cm) #h(0.5cm) older: #blank(width: 2.2cm)
]

#question[
  #set par(justify: false)
  1.2 Lines of code your team wrote to answer 1.1: #blank(width: 1.5cm)
]

== Part 2. `group()` #h(1fr) #text(size: 9pt, style: "italic", weight: "regular")[14 minutes]

#question[
  #set par(justify: false)
  2.1 Redo 1.1 using `group()`. Lines of code now: #blank(width: 1.5cm) \
  #v(0.05cm)
  #set par(justify: true)
  In Class 09 you split a table with `where` and a boolean. `group()` splits it on every
  distinct value at once. Say what `group()` does that a boolean condition cannot.
]

#answer-space(height: 2.2cm)

#question[
  2.2 We named our collect function `value_range` rather than `range`. Suppose a classmate
  names theirs `range` in cell 20, everything works, and in cell 45 they write a `for` loop
  over `range(10)`. Describe what they will see, and why this class of bug is worse than one
  that stops the program immediately.
]

#answer-space(height: 2.2cm)

== Part 3. `pivot()` #h(1fr) #text(size: 9pt, style: "italic", weight: "regular")[10 minutes]

#question[
  3.1 #emph[Predict first.] `slope` takes values 0, 1, 2 and `target` takes 0, 1. Sketch
  `heart.pivot('slope', 'target')` below — label the rows, label the columns, say in words
  what one cell contains. Then run it and check.
]

#answer-space(height: 2.8cm)

#question[
  3.2 The empty cells in the age-by-disease pivot came back as `0`, and those zeros plotted
  as real data points. Name one other place in data analysis where a missing value gets
  silently written as a number, and say what you would rather the software do.
]

#answer-space(height: 2.2cm)

#pagebreak()

== Part 4. The Cholesterol Paradox #h(1fr) #text(size: 9pt, style: "italic", weight: "regular")[12 minutes]

Patients with heart disease in this table do #emph[not] have higher cholesterol than
patients without it.

#question[
  #set par(justify: false)
  4.1 Mean cholesterol — disease: #blank(width: 2.2cm) #h(0.5cm) no disease: #blank(width: 2.2cm) \
  #v(0.05cm)
  Median cholesterol — disease: #blank(width: 2.2cm) #h(0.5cm) no disease: #blank(width: 2.2cm)
]

#question[
  4.2 #emph[Before running anything else]: your team's explanation. You will be held to it.
]

#answer-space(height: 2.2cm)

#question[
  4.3 In Class 09 you computed P(disease | female) and found it far above P(disease | male).
  Women also tend to have higher cholesterol. That suggests the whole paradox is a
  composition effect. Test it: fill in the four cells of mean cholesterol.
]

#v(0.2cm)
#align(center)[
  #table(
    columns: (3.6cm, 3.6cm, 3.6cm),
    inset: 8pt,
    align: center,
    [], [*no disease* (0)], [*disease* (1)],
    [*women* (sex = 0)], [], [],
    [*men* (sex = 1)], [], [],
  )
]
#v(0.2cm)

#question[
  #set par(justify: false)
  4.4 Compare the gap within each row to the overall gap in 4.1. Circle one, then explain in
  one sentence what the sex difference was doing to the aggregate comparison. \
  #v(0.05cm)
  #h(0.5cm) SHRINKS #h(1.2cm) WIDENS #h(1.2cm) NO CHANGE
]

#answer-space(height: 2.2cm)

#question[
  #set par(justify: false)
  4.5 Two explanations we cannot test with the columns we have. Name the one column each
  would require. \
  #v(0.1cm)
  #emph[Treatment] — the cholesterol on file may be cholesterol after a statin. #blank(width: 5cm) \
  #v(0.1cm)
  #emph[Selection] — everyone here was referred for catheterization. #blank(width: 6.6cm)
]

== Part 5. Do You Trust This Table? #h(1fr) #text(size: 9pt, style: "italic", weight: "regular")[6 minutes]

#question[
  #set par(justify: false)
  5.1 The metadata is wrong in at least two places. \
  #v(0.1cm)
  `thal` — documented: #blank(width: 2.8cm) #h(0.4cm) found: #blank(width: 3.2cm) \
  #v(0.1cm)
  `ca` — documented: #blank(width: 2.8cm) #h(0.4cm) found: #blank(width: 3.2cm)
]

#question[
  #set par(justify: false)
  5.2 Rows in the file: #blank(width: 1.8cm) #h(0.4cm) Distinct rows: #blank(width: 1.8cm)
  #h(0.4cm) Patients in the original UCI study: 303 \
  #v(0.1cm)
  In one sentence, what was done to this file before it was posted?
]

#answer-space(height: 1.6cm)

#question[
  5.3 Duplicating each patient several times barely moves a mean, but it multiplies the
  apparent sample size. Later in the semester you will judge a result by how much variation
  chance alone could produce — and sample size is what sets that. What would this file do to
  such a judgment? Be specific about the direction of the error.
]

#answer-space(height: 2.2cm)

#pagebreak()

= If You Finish Early

Nothing to hand in. These are the two best questions on the sheet — take them if your team
gets through Part 5 with time left, or argue them out with the room at the end.

#question[
  E1. The scatter plot of median cholesterol against age has 41 points, one per age, built
  from 1,025 rows. Someone looks at it and says, "so cholesterol rises with age in this
  population." What claim is that plot evidence for, and what claim is it #emph[not]
  evidence for?
]

#answer-space(height: 4.4cm)

#question[
  E2. `group()` turned five lines into one, and every summary you made today discarded
  information in exchange for legibility. Name one thing you learned today that you could
  only have learned by looking at the raw rows, and one thing you could only have learned by
  aggregating them.
]

#answer-space(height: 4.4cm)
