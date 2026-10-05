#set document(
  title: "Honors Class 13 Activity: Where You Can Park",
  author: "Elements of Data Science",
  keywords: ("data science", "honors", "sampling", "replacement", "convenience sample", "bias", "activity"),
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

= Where You Can Park

#set par(justify: false)
*Team Members:* #blank(width: 3.4cm) #h(0.2cm) #blank(width: 3.4cm) #h(0.2cm) #blank(width: 3.4cm)

#v(0.2cm)
#h(2.55cm) #blank(width: 3.4cm) #h(0.2cm) #blank(width: 3.4cm)
#set par(justify: true)

#v(0.2cm)

Every number you have computed this semester came from a sample of something. Today is
about how the sample got drawn, and about two ways that goes wrong: an argument you never
typed, and a stretch of ground you could not walk to. Open
`Class13_Where_You_Can_Park_Skeleton.ipynb`.

== Part 1. Two Words That Change the Answer

The marble contest from Lab 05. A bag holds two red, two green, and two blue marbles. You
draw three. You win if all three are different colors.

#question[
  #set par(justify: false)
  1.1 #emph[Predict first.] Your team's estimate of the probability of winning:
  #blank(width: 2.5cm)
]

#question[
  #set par(justify: false)
  1.2 Ten thousand simulated contests, each way. \
  #v(0.05cm)
  #h(0.4cm) marble replaced before the next draw: #blank(width: 2.5cm) \
  #v(0.05cm)
  #h(0.4cm) marble kept out of the bag: #blank(width: 2.5cm)
]

#question[
  #set par(justify: false)
  1.3 Which one matches the contest as described? #h(0.4cm) REPLACED #h(0.8cm) KEPT OUT \
  #v(0.05cm)
  #set par(justify: true)
  You never told `np.random.choice` which you wanted. Which has it been doing all semester?
]

#answer-space(height: 1.4cm)

== Part 2. A Stream With No Name

A bag of marbles is a population you can hold. Now one you cannot: a stream, where the
choice is not whether the marble goes back but which stretch of bank you can stand on.

Everything that follows is invented — no such creek, no measurements, numbers straight out
of a random number generator. That is on purpose: you can only study a sampling method in a
case where the true answer is already known. The notebook holds all 240 hundred-metre
reaches along a 24 km stretch of this stream, each with its true chloride concentration.
Chloride in real urban streams does come largely from road salt washing off pavement, and
that part is not invented. The `access` column says whether a crew could park and walk to
the water.

#question[
  #set par(justify: false)
  2.1 True mean chloride across all 240 reaches: #blank(width: 2.5cm) mg/L
]

#question[
  #set par(justify: false)
  2.2 #emph[Predict first.] Nobody wades 24 km of creek. You park where you can park, and
  the pull-offs are at road bridges. Before you run anything: a sample drawn only from the
  `easy` reaches will be \
  #v(0.05cm)
  #h(0.4cm) TOO HIGH #h(1.2cm) TOO LOW #h(1.2cm) ABOUT RIGHT #h(1.2cm) — because:
]

#answer-space(height: 1.6cm)

#question[
  2.3 A thousand honest random samples of twelve, against a thousand convenience samples of
  forty.
]

#v(0.2cm)
#align(center)[
  #table(
    columns: (4.6cm, 3.4cm, 3.2cm, 3.4cm),
    inset: 7pt,
    align: center,
    stroke: 0.5pt + rgb("#888888"),
    [], [*centre of the \ estimates*], [*SD of the \ estimates*], [*fraction within \ 10 of the truth*],
    align(left)[random, n = 12], [], [], [],
    align(left)[convenience, n = 40], [], [], [],
  )
]
#v(0.2cm)

#question[
  2.4 The convenience survey visited more than three times as many sites, and the spread of
  its estimates is about half as wide. By every measure of precision it is the better
  survey. Say plainly what is wrong with it, and what would happen if the field crew doubled
  its effort again.
]

#answer-space(height: 2.6cm)

== Discussion

#question[
  In 1936 the #emph[Literary Digest] mailed ten million ballots and got 2.4 million back,
  one of the largest polls ever run. It predicted Landon over Roosevelt by about 57 to 43.
  Roosevelt took roughly 61% of the vote. George Gallup called it correctly with about fifty
  thousand. Connect this to your answer to 2.4 in one sentence.
]

#answer-space(height: 2.4cm)
