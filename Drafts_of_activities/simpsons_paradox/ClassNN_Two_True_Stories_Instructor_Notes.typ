#set document(
  title: "Instructor Notes --- Two True Stories",
  author: "Elements of Data Science",
  keywords: ("data science", "honors", "grouping", "instructor notes"),
)

#set page(paper: "us-letter", margin: (x: 1in, y: 1in))
#set par(justify: true, leading: 0.65em)
#set heading(numbering: none)
#set text(font: "Liberation Serif", size: 11pt, lang: "en", region: "us")

#show raw.where(block: true): it => block(
  fill: rgb("#f2f2f2"), inset: 8pt, radius: 3pt, width: 100%,
  text(font: "Liberation Mono", size: 9pt, it),
)
#show raw.where(block: false): it => text(font: "Liberation Mono", size: 9pt, it)

#show heading.where(level: 1): it => [
  #set align(center)
  #set text(size: 15pt, weight: "bold")
  #block(above: 0pt, below: 10pt, it.body)
]
#show heading.where(level: 2): it => [
  #set text(size: 12pt, weight: "bold")
  #block(above: 10pt, below: 5pt, it.body)
]

= Instructor Notes --- Two True Stories

*Runs 15 minutes.* No computers required. Print half the worksheets marked THE REGISTRAR and
half marked THE LEARNING CENTER, or let teams circle their role as you hand them out.

The data are handed out at a finer grain than either client needs --- Section, Quiz 1 group,
and attendance --- so *both* teams must aggregate to answer their question. That is the point.
Neither side gets to be the team that leaves the data alone.

== Timing

#table(
  columns: 2, stroke: 0.5pt, inset: 5pt, align: (left, left),
  [0:00 -- 0:02], [Hand out. Read the situation aloud. Say only: your client is already sure, go find it.],
  [0:02 -- 0:07], [Teams compute. Circulate. Do not confirm anyone's answer.],
  [0:07 -- 0:11], [One Registrar team and one Learning Center team read headline and table.],
  [0:11 -- 0:15], [Reveal that both are arithmetically correct. Take discussion question 2.],
)

== Answer Key

*The Registrar* collapses Section and Quiz 1 group, keeping only attendance:

#table(
  columns: 4, stroke: 0.5pt, inset: 4pt, align: (left, right, right, right),
  table.header([Group], [Students], [Passed], [Pass rate]),
  [Attended], [80], [48], [60%],
  [Did not attend], [100], [76], [76%],
)

*The Learning Center* collapses Section only:

#table(
  columns: 4, stroke: 0.5pt, inset: 4pt, align: (left, right, right, right),
  table.header([Group], [Students], [Passed], [Pass rate]),
  [Strong, attended], [20], [18], [90%],
  [Strong, did not attend], [80], [68], [85%],
  [Struggling, attended], [60], [30], [50%],
  [Struggling, did not attend], [20], [8], [40%],
)

Attending is better in *both* subgroups and worse overall. This is Simpson's paradox, but do
not name it before the reveal --- the name lets students file it away as a curiosity instead
of feeling it.

== The Reveal

The line that lands: *nobody cheated.* Ask the room to find the fraudulent step. There isn't
one. The Registrar's table is a true summary of the data and a false answer to the question,
because students sorted themselves into the review session by the very variable that
predicts the outcome.

Then press on discussion question 2, which is the real payload. Both teams performed the
same operation on Section and it changed nothing; one team performed it on Quiz 1 group and
the conclusion reversed. Push until someone states the condition: collapsing a column matters
only when that column is related both to who attended and to who passed. That is a definition
of confounding, and they will have derived it rather than received it.

== Optional Live Demo

`review_sessions.csv` has one row per student, columns `Section`, `Quiz1Group`, `Review`,
`Passed`. Run this after the reveal so students see all three groupings as one line each:

```python
q = Table.read_table('review_sessions.csv')

def rate(passed):
    return np.round(np.count_nonzero(passed == 'Yes') / len(passed), 3)

q.select('Section', 'Passed').group('Section', rate)
q.select('Review', 'Passed').group('Review', rate)
q.select('Quiz1Group', 'Review', 'Passed').group(['Quiz1Group', 'Review'], rate)
```

Sections A and B come out at 72% and 65.5% --- not identical, which is worth showing. Section
differs on the outcome and still does not matter, because it does not differ on attendance
(43% vs. 46%). Association with the outcome alone is not enough.

== Watch For

Teams computing rates on the wrong denominator, or reporting the paradox backwards --- harmless,
let them present. Teams that finish early: ask them to write down the question their table
actually answers. Teams that stall: point at the Students column and ask who showed up.

== Connects To

Lab 07, where `.group` and `.pivot` arrive as hints inside the climate analysis; the causality
week; and the Pennypack mini-project, where site groupings are chosen rather than given.
