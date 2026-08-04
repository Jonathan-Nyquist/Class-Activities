#set document(
  title: "Honors ClassNN Activity: Two True Stories",
  author: "Elements of Data Science",
  keywords: ("data science", "honors", "grouping", "aggregation", "confounding", "activity"),
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

= Two True Stories

*Team Members:* #blank(width: 4cm) #h(0.3cm) #blank(width: 4cm) #h(0.3cm) #blank(width: 4cm)

*Team Role (circle one):*  #h(0.4cm) THE REGISTRAR #h(0.8cm) THE LEARNING CENTER

== The Situation

Last year both sections of Elements of Data Science offered an optional review session
before Quiz 2, and the Provost's office wants to know whether it was worth the money. Every
student who took Quiz 2 is counted below. Each had already taken Quiz 1; those who scored
below 70 on Quiz 1 are listed as *Struggling*, the rest as *Strong*.

#align(center)[
#table(
  columns: 5,
  align: (center, left, left, right, right),
  stroke: 0.5pt,
  inset: 4pt,
  table.header(
    [*Section*], [*Quiz 1 group*], [*Review session*], [*Students*], [*Passed Quiz 2*],
  ),
  [A], [Strong], [Attended], [12], [11],
  [B], [Strong], [Attended], [8], [7],
  [A], [Strong], [Did not attend], [44], [37],
  [B], [Strong], [Did not attend], [36], [31],
  [A], [Struggling], [Attended], [28], [15],
  [B], [Struggling], [Attended], [32], [15],
  [A], [Struggling], [Did not attend], [9], [4],
  [B], [Struggling], [Did not attend], [11], [4],
)
]

Your team has a client, and your client has already decided what they believe. Your job is
to *find it in this table.*

#block(
  inset: (left: 8pt, top: 2pt, bottom: 2pt),
  stroke: (left: 2pt + rgb("#4a4a4a")),
)[
*THE REGISTRAR* wants to cancel the sessions: _"Students who attend review sessions do worse."_

*THE LEARNING CENTER* wants to expand them: _"Review sessions help students."_
]

No row may be dropped, no number invented, no student ignored. The only thing you may
choose is *how to group.*

== Part 1: Build Your Table (5 minutes)

Decide which rows belong together, combine them, and compute a pass rate for each group.
Write the table you would hand your client.

#align(center)[
#table(
  columns: 4,
  align: (left, right, right, right),
  stroke: 0.5pt,
  inset: 6pt,
  table.header([*Group*], [*Students*], [*Passed*], [*Pass rate*]),
  [], [], [], [],
  [], [], [], [],
  [], [], [], [],
  [], [], [], [],
)
]

== Part 2: The Other Team (4 minutes)

#question[When the other side reads their headline and their table: did they cheat? Point to
the step where they went wrong --- or explain why you cannot.]
#answer-space(height: 2.0cm)

#pagebreak(weak: true)

= Discussion Questions

Both tables are correct. Every number in both of them can be recomputed from the data you
were given, and neither team dropped a single student.

#question[If two contradictory conclusions can both be honestly derived from one dataset,
what decides which one is right? Notice that the answer is not in the data.]
#answer-space(height: 2.5cm)

Both teams combined Section A with Section B and nothing happened. Only one team combined
Strong with Struggling --- and the answer reversed.

#question[Both moves were the same operation. What is different about the two columns? State
the property a column must have before collapsing it can change your conclusion.]
#answer-space(height: 2.5cm)

Look again at the counts. Sixty of the eighty students who attended were already struggling;
only twenty of the hundred who skipped it were.

#question[Why did that happen, and what does it tell you about what the overall comparison
is actually comparing?]
#answer-space(height: 2.5cm)

Suppose Quiz 1 scores had never been recorded.

#question[Would anyone have been able to detect the problem? A grouped table always looks
like a summary of the data. When is it better described as an argument about the data?]
#answer-space(height: 2.5cm)
