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
about how the sample got drawn — and about two ways that goes wrong. The first is an
argument you never typed. The second is a stretch of ground you could not walk to. Open
`Class13_Where_You_Can_Park_Skeleton.ipynb`.

== Part 1. Two Words That Change the Answer #h(1fr) #text(size: 9pt, style: "italic", weight: "regular")[12 minutes]

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
  And how much did that unstated default change the answer?
]

#answer-space(height: 2cm)

#question[
  1.4 In Class 11 you captured five German tanks and read their serial numbers. That sampling
  had to be without replacement, and not because anyone chose an argument. Why not?
]

#answer-space(height: 1.8cm)

== Part 2. A Stream With No Name #h(1fr) #text(size: 9pt, style: "italic", weight: "regular")[22 minutes]

A bag of marbles is a population you can hold. Now one you cannot: a stream, where the
choice is not whether the marble goes back but which stretch of bank you can stand on.

Everything that follows is invented — no such creek, no measurements, numbers straight out
of a random number generator. That is on purpose: you can only study a sampling method in a
case where the true answer is already known, which is why the tank problem invented an enemy
with exactly 1000 tanks.

The notebook holds all 240 hundred-metre reaches along a 24 km stretch of this stream, each
with its true chloride concentration. Chloride in real urban streams
does come largely from road salt washing off pavement, and that part is not invented. The
`access` column says whether a crew could park and walk to the water.

You have the whole population, which never happens in the field. That is the only reason
today works.

#question[
  #set par(justify: false)
  2.1 True mean chloride across all 240 reaches: #blank(width: 2.5cm) mg/L
]

#question[
  #set par(justify: false)
  2.2 Three separate random samples of twelve reaches. Estimates: \
  #v(0.05cm)
  #h(0.4cm) #blank(width: 2.4cm) #h(0.6cm) #blank(width: 2.4cm) #h(0.6cm) #blank(width: 2.4cm)
]

#question[
  #set par(justify: false)
  2.3 Now the careless version — `creek.sample(12)` with no arguments. A single run almost
  always looks fine, so count across a thousand of them. \
  #v(0.05cm)
  #h(0.4cm) Fraction of careless samples containing a repeated reach: #blank(width: 2.2cm) \
  #v(0.05cm)
  #set par(justify: true)
  In the field, what would a repeat have meant you did?
]

#answer-space(height: 1.6cm)

#question[
  #set par(justify: false)
  2.4 #emph[Predict first.] Nobody wades 24 km of creek. You park where you can park, and
  the pull-offs are at road bridges. Before you run anything: a sample drawn only from the
  `easy` reaches will be \
  #v(0.05cm)
  #h(0.4cm) TOO HIGH #h(1.2cm) TOO LOW #h(1.2cm) ABOUT RIGHT #h(1.2cm) — because:
]

#answer-space(height: 1.8cm)

#question[
  2.5 A thousand honest random samples of twelve, against a thousand convenience samples of
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
  2.6 The convenience survey visited more than three times as many sites, and the spread of
  its estimates is about half as wide. By every measure of precision it is the better
  survey. Say plainly what is wrong with it, and what would happen if the field crew doubled
  its effort again.
]

#answer-space(height: 2.8cm)

== Part 3. What the Shapes Say #h(1fr) #text(size: 9pt, style: "italic", weight: "regular")[8 minutes]

#question[
  3.1 The histogram of the `easy` reaches has two humps. Using `km downstream`, work out what
  each hump is. They are not the same kind of place.
]

#answer-space(height: 2.4cm)

#question[
  #set par(justify: false)
  3.2 On the box plot, the `easy` reaches are one box. \
  #v(0.05cm)
  #h(0.4cm) median #blank(width: 2cm) #h(0.6cm) IQR #blank(width: 2cm) \
  #v(0.05cm)
  #set par(justify: true)
  Name one thing the histogram showed you that the box plot cannot, and one thing the box
  plot makes easier than the histogram does.
]

#answer-space(height: 2.4cm)

== Discussion #h(1fr) #text(size: 9pt, style: "italic", weight: "regular")[8 minutes]

#question[
  D1. A man is on his hands and knees under a streetlight. A passer-by asks what he lost. His
  keys. Did you lose them here? No, over there in the park — but this is where the light is.

  #v(0.15cm)
  Statisticians call this the streetlight effect, and the man's search is hopeless: the keys
  are not under the light and he knows it. Your field crew was not doing that. The accessible
  reaches are real creek and the chloride they measured is real.

  #v(0.15cm)
  (a) State the crew's mistake precisely. It is not that they looked in the wrong place.

  #v(0.15cm)
  (b) Sampling only where you can park is not always an error. Name a question about this
  stream that the forty accessible reaches would answer #emph[better] than twelve random ones.
]

#answer-space(height: 2.8cm)

#question[
  D2. In 1936 the #emph[Literary Digest] mailed ten million ballots and got 2.4 million back,
  one of the largest polls ever run. It predicted Landon over Roosevelt by about 57 to 43.
  Roosevelt took roughly 61% of the vote. George Gallup called it correctly with about fifty
  thousand. Connect this to your answer to 2.6 in one sentence.
]

#answer-space(height: 2.6cm)

#question[
  D3. Today's stream was rigged so that access and chloride were linked. That is a real
  hazard in field science, but it is not automatic — plenty of surveys are designed
  specifically to defeat it, by fixing the sites in advance along the whole length of a
  stream rather than stopping wherever the crew can pull over.

  #v(0.15cm)
  So: for any field dataset you are handed, what would you ask about how the sites were
  chosen, and what would you look for in the data itself to check the answer you were given?
]

#answer-space(height: 3cm)
