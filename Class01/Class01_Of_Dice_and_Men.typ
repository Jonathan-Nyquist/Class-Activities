#set document(
  title: "Honors Class01 Activity: Of Dice and Men",
  author: "Elements of Data Science",
  keywords: ("data science", "honors", "probability", "activity"),
)

#set page(
  paper: "us-letter",
  margin: (x: 1in, y: 1in),
)

#set text(font: "Liberation Serif", size: 11pt, lang: "en", region: "US")
#set par(justify: true, leading: 0.65em)
#set heading(numbering: none)

// ── Heading styles ─────────────────────────────────────────────────────────

// Level 1: document title — centered, large
#show heading.where(level: 1): it => align(center)[
  #block(above: 0em, below: 1em)[
    #text(size: 16pt, weight: "bold")[#it.body]
  ]
]

// Level 2: section heading
#show heading.where(level: 2): it => block(
  below: 0.6em,
  above: 1.2em,
)[#text(weight: "bold", size: 11pt)[#it.body]]

// ── Helpers ────────────────────────────────────────────────────────────────

// Inline answer blank
#let blank(width: 5cm) = box(
  width: width,
  stroke: (bottom: 0.5pt),
  inset: (bottom: 2pt),
  []
)

#let answer-space(height: 1.2cm) = block(
  width: 100%,
  height: height,
  []
)

// Numbered question
#let q(num, body) = block(above: 0.9em, below: 0em)[
  #grid(
    columns: (1.5em, 1fr),
    gutter: 0.3em,
    [#num.], body
  )
]

// ── Title ──────────────────────────────────────────────────────────────────

= Honors Class01 Activity: Of Dice and Men

*Team Members:* #blank(width: 9cm)

#line(length: 100%, stroke: 0.5pt)

#v(0.5em)

Each team will receive a pair of dice. Roll the dice 50 times and record the total for each roll
in the table on the back of this page along with the running grand total.

#v(0.5em)

#q[1][Grand total of all 50 rolls here: #blank(width: 5cm)]

#q[2][Divide the sum by 50 to calculate the average: #blank(width: 4.5cm)]

#q[3][What is the expected value of the average? Explain.]
#answer-space(height: 1.4cm)

#q[4][How much does your average differ from this expected value? #blank(width: 3.5cm)]

#q[5][Do you think this difference is plausible given you only rolled the dice 50 times?]
#answer-space(height: 1.4cm)

#q[6][If you wanted to be very confident the dice were fair, how many rolls would you want to
do? Explain your reasoning (even if it's not exact math).]
#answer-space(height: 1.4cm)

#q[7][The probability of rolling a 12 is $1\/36$. Out of 50 rolls, how many 12s would you
expect on average?]
#answer-space(height: 1.4cm)

#q[8][How many 12s did you roll and does this seem to be in agreement with the odds?]
#answer-space(height: 1.4cm)

#q[9][Suppose a classmate claims your dice are unfair because you didn't get any 12s. What
evidence would you use to argue for or against this claim?]
#answer-space(height: 1.4cm)

#q[10][Based on this activity, write one sentence that summarizes what you learned about
randomness and averages.]
#answer-space(height: 1.4cm)

// ── Page 2: Data Table ─────────────────────────────────────────────────────

#pagebreak()

#v(1fr)

// Two proper tables side by side rather than a single table with a spacer column.
// Each has a marked header row for accessibility.
#let roll-table(start) = table(
  columns: (2.5em, 4em, 5em),
  inset: (x: 6pt, y: 7pt),
  stroke: 0.5pt,
  align: center,

  table.header(
    table.cell(fill: luma(230))[*Roll \#*],
    table.cell(fill: luma(230))[*Dice Sum*],
    table.cell(fill: luma(230))[*Running Total*],
  ),

  ..range(start, start + 25).map(i => (
    [#i], [], [],
  )).flatten()
)

#align(center)[
  #grid(
    columns: (auto, 2em, auto),
    roll-table(1),
    [],
    roll-table(26),
  )
]

#v(1fr)

