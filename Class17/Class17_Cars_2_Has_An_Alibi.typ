#set document(
  title: "Honors Class 17 Activity: Cars 2 Has an Alibi",
  author: "Elements of Data Science",
  keywords: ("data science", "honors", "EDA", "box plot", "quartiles", "correlation", "standard units", "activity"),
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

= Cars 2 Has an Alibi

#set par(justify: false)
*Team Members:* #blank(width: 3.4cm) #h(0.2cm) #blank(width: 3.4cm) #h(0.2cm) #blank(width: 3.4cm)

#set par(justify: true)

#v(0.2cm)

Twenty-one Pixar films, each rated by three different services. Today you will accuse a movie
of ruining the data. The evidence against it is real --- but the test you run will not convict it,
and working out why is the point.

Open `Class17_Cars_2_Has_An_Alibi_Skeleton.ipynb`. Answer here, on paper.

== Part 1. One Variable at a Time #h(1fr) #text(size: 9pt, style: "italic", weight: "regular")[18 minutes]

Before comparing two variables you have to understand each one alone. The `stats()` method
gives you six numbers per column.

#question[
  #set par(justify: false)
  1.1 Fill in from the notebook: \
  #v(0.15cm)
  #align(center)[
    #table(
      columns: (3.2cm, 2.4cm, 2.4cm, 2.4cm),
      inset: 6pt,
      align: (left, center, center, center),
      stroke: 0.5pt + rgb("#888888"),
      [], [*rotten#linebreak()tomatoes*], [*metacritic*], [*critics#linebreak()choice*],
      [mean], [], [], [],
      [median], [], [], [],
      [mean − median], [], [], [],
    )
  ]
]

#question[
  1.2 One of those three columns has a mean far below its median; the other two barely differ.
  Which one, and what does a mean well below the median tell you about the shape of a
  distribution? (Sketch the shape if it helps.)
]

#answer-space(height: 1.4cm)

Now some vocabulary you need before the next plot. Order the values low to high and cut them
into quarters. #emph[Q1] is the median of the lower half, #emph[Q2] is the median, #emph[Q3]
is the median of the upper half. The distance from Q1 to Q3 is the #emph[interquartile range],
or IQR.

#question[
  #set par(justify: false)
  1.3 #emph[By hand, no code.] For these twelve numbers: \
  #v(0.1cm)
  #align(center)[#text(size: 12pt)[24, 25, 26, 27, 30, 32, 40, 44, 50, 52, 55, 57]]
  #v(0.1cm)
  #h(0.4cm) Q1 = #blank(width: 1.6cm) #h(1cm) Q2 = #blank(width: 1.6cm) #h(1cm)
  Q3 = #blank(width: 1.6cm) #h(1cm) IQR = #blank(width: 1.6cm)
]

A #emph[box plot] draws exactly that: a box from Q1 to Q3 with a line at the median. The
whiskers reach the farthest point within 1.5 × IQR of the box, and anything past a whisker is
drawn as a separate dot — a #emph[flier].

#question[
  #set par(justify: false)
  1.4 Run `rmc.boxplot()`. \
  #v(0.1cm)
  #h(0.4cm) Which service gives the most favorable ratings overall? #blank(width: 3.2cm) \
  #v(0.1cm)
  #h(0.4cm) The least favorable? #blank(width: 3.2cm) \
  #v(0.1cm)
  #h(0.4cm) How many fliers appear in the whole plot? #blank(width: 1.4cm)
  #h(0.6cm) On which service? #blank(width: 3.2cm)
]

#question[
  1.5 Find that film in the table and write down its name and its three ratings. Judging only
  by the box plot, would you call it an outlier? Say why.
]

#answer-space(height: 1.3cm)

== Part 2. Two Variables at a Time #h(1fr) #text(size: 9pt, style: "italic", weight: "regular")[18 minutes]

#question[
  2.1 Look at the scatter plot of `metacritic` against `critics_choice`. Is there a
  correlation? Positive or negative? Strong, moderate, or weak? Commit to an answer before you
  compute anything.
]

#answer-space(height: 1.2cm)

Standardizing turns any measurement into standard units — how many SDs from its own mean:

#v(0.1cm)
#align(center)[
  $ z = (x - macron(x)) / sigma $
]
#v(0.1cm)

#question[
  2.2 Plot the standardized ratings against each other. Compare the shape of the cloud to the
  unstandardized version. What changed, and what did not? Why?
]

#answer-space(height: 1.3cm)

The correlation coefficient $r$ is the #emph[average of the product] of the two variables in
standard units. It has no units and always falls between $-1$ and $+1$.

#question[
  #set par(justify: false)
  2.3 Think about the product $z_x times z_y$ for a single film before you compute anything.
  Fill in each cell with *positive* or *negative*: \
  #v(0.15cm)
  #align(center)[
    #table(
      columns: (4.4cm, 3.2cm, 3.2cm),
      inset: 6pt,
      align: (left, center, center),
      stroke: 0.5pt + rgb("#888888"),
      [], [*$z_y$ above average*], [*$z_y$ below average*],
      [$z_x$ above average], [], [],
      [$z_x$ below average], [], [],
    )
  ]
  #v(0.1cm)
  #set par(justify: true)
  Using that table, explain in one sentence why $r$ comes out large and positive when the two
  variables track each other, and near zero when they do not.
]

#answer-space(height: 1.3cm)

#question[
  #set par(justify: false)
  2.4 Compute $r$ for all three pairs and rank them. \
  #v(0.15cm)
  #h(0.4cm) `rotten_tomatoes` & metacritic #h(0.4cm) $r = $ #blank(width: 2cm) \
  #v(0.1cm)
  #h(0.4cm) `rotten_tomatoes` & `critics_choice` #h(0.4cm) $r = $ #blank(width: 2cm) \
  #v(0.1cm)
  #h(0.4cm) metacritic & `critics_choice` #h(0.4cm) $r = $ #blank(width: 2cm) \
  #v(0.15cm)
  #set par(justify: true)
  Which two services agree with each other most closely? Does that match what you guessed in
  2.1?
]

#answer-space(height: 1.2cm)

== Part 3. The Alibi #h(1fr) #text(size: 9pt, style: "italic", weight: "regular")[14 minutes]

The film from Part 1 sticks out on the box plot and sticks out on the scatter plot. It is the
obvious candidate for the point distorting your correlation. Put it on trial.

#question[
  #set par(justify: false)
  3.1 For `rotten_tomatoes` vs. `metacritic`: \
  #v(0.15cm)
  #h(0.4cm) $r$ with all 21 films #blank(width: 2cm) #h(1.2cm)
  $r$ with Cars 2 removed #blank(width: 2cm) \
  #v(0.15cm)
  #set par(justify: true)
  Removing the worst-looking point should have weakened the correlation. Which direction did it
  actually move?
]

#answer-space(height: 1.2cm)

#question[
  #set par(justify: false)
  3.2 The notebook removes each film one at a time and reports how much $r$ changes. \
  #v(0.1cm)
  #h(0.4cm) Largest effect: #blank(width: 3cm) #h(0.5cm) change #blank(width: 1.8cm)
  #h(1cm) Cars 2's change #blank(width: 1.8cm) \
  #v(0.15cm)
  #set par(justify: true)
  Find that film on the scatter plot and mark it. Describe where it sits compared to Cars 2.
]

#answer-space(height: 1.4cm)

Cars 2 scored 57 on metacritic. The other low-rated films suggest a score near *46* would have
been in keeping with the pattern. The notebook tries that hypothetical.

#question[
  #set par(justify: false)
  3.3 Record all three: \
  #v(0.15cm)
  #h(0.4cm) $r$ as observed #blank(width: 1.8cm) #h(0.8cm)
  $r$ if Cars 2 had scored 46 #blank(width: 1.8cm) #h(0.8cm)
  $r$ with Cars 2 removed #blank(width: 1.8cm) \
  #v(0.2cm)
  #set par(justify: true)
  Being out of line was worth about $0.06$ of correlation. But *removing* Cars 2 gained only
  about $0.02$. Roughly $0.04$ went somewhere. Compare the spread of `rotten_tomatoes` with and
  without Cars 2, and explain where it went.
]

#answer-space(height: 2.4cm)

#question[
  3.4 So: is Cars 2 an unusual point? Is it the point that most affects $r$? Explain how both
  answers can be what they are, in one or two sentences.
]

#answer-space(height: 1.8cm)

Four small data sets, all with the same means, the same standard deviations, and the same
correlation, $r approx 0.816$ --- close to the correlation you found in 2.4.

#question[
  3.5 Plot all four. Which of them would you be comfortable summarizing with a correlation
  coefficient alone, and which would be actively misleading? Give a reason for each one you
  rule out.
]

#answer-space(height: 2.6cm)
