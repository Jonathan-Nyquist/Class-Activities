#set document(
  title: "Honors Class 14 Activity: Thirty-Five Worlds",
  author: "Elements of Data Science",
  keywords: ("data science", "honors", "hypothesis testing", "permutation test", "p-value", "activity"),
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

= Thirty-Five Worlds

#set par(justify: false)
*Team Members:* #blank(width: 3.4cm) #h(0.2cm) #blank(width: 3.4cm) #h(0.2cm) #blank(width: 3.4cm)

#v(0.2cm)
#h(2.55cm) #blank(width: 3.4cm) #h(0.2cm) #blank(width: 3.4cm)
#set par(justify: true)

#v(0.2cm)

Seven patients. Three got nothing, four got the new treatment, and we recorded how many days
each took to recover.

#v(0.15cm)
#align(center)[
  #table(
    columns: (2.6cm, 3.4cm, 3.4cm),
    inset: 6pt,
    align: (left, center, center),
    stroke: 0.5pt + rgb("#888888"),
    [], [*Control* (3)], [*Treated* (4)],
    [recovery, days], [22, 33, 40], [19, 22, 25, 26],
    [mean], [31.67], [23.00],
  )
]
#v(0.15cm)

The treated group recovered 8.67 days sooner on average. That looks like a result. But one
untreated patient recovered in 22 days, as fast as anyone who was treated, and with seven
people the whole thing could be an accident of who landed in which group.

#emph[Null hypothesis: the treatment did nothing.] If that is true, then these seven
recovery times were going to be what they were regardless, and which three people we called
"control" was arbitrary. So look at every way it could have come out.

== Part 1. Thirty-Five Worlds #h(1fr) #text(size: 9pt, style: "italic", weight: "regular")[20 minutes]

There are exactly 35 ways to pick 3 patients out of 7. Your slip has some of them. Between
you, the room has all of them — every world the null hypothesis allows.

#question[
  #set par(justify: false)
  1.1 Your team's sums, from the slip: \
  #v(0.1cm)
  #h(0.4cm) #blank(width: 1.7cm) #h(0.35cm) #blank(width: 1.7cm) #h(0.35cm) #blank(width: 1.7cm)
  #h(0.35cm) #blank(width: 1.7cm) #h(0.35cm) #blank(width: 1.7cm) #h(0.35cm) #blank(width: 1.7cm)
]

#question[
  #set par(justify: false)
  1.2 #emph[Class check before anything else.] Every patient appears in exactly 15 of the 35
  splits, so all 35 sums must total #box(stroke: 0.5pt, inset: 3pt)[15 × 187 = 2,805]. \
  #v(0.1cm)
  #h(0.4cm) Board total: #blank(width: 2.4cm) #h(1cm) Match? #h(0.4cm) YES #h(0.8cm) NO — find the error before going on.
]

Each sum $S$ is the total recovery time of a control group. Turning it into a difference in
means takes no more arithmetic than this:

#v(0.1cm)
#align(center)[
  $ "difference" = S/3 - (187 - S)/4 = (7S - 561)/12 $
]
#v(0.1cm)

#question[
  #set par(justify: false)
  1.3 The real experiment had control patients P1, P2, P3, so $S = 95$. Check that the
  formula returns the observed difference: #blank(width: 2.4cm) \
  #v(0.1cm)
  #set par(justify: true)
  Somebody's slip contains the actual experiment. Whose? #blank(width: 2.5cm) \
  #v(0.1cm)
  Say why it #emph[has] to appear among the 35, and what that means about where the observed
  result sits relative to the null distribution.
]

#answer-space(height: 2.2cm)

#question[
  #set par(justify: false)
  1.4 A difference is at least as extreme as the one we saw when it is 8.67 or more, or
  #sym.minus 8.67 or less. Rearranged, that is $S >= 95$ or $S <= 63$. Go through the board. \
  #v(0.1cm)
  #h(0.4cm) Splits with $S >= 95$: #blank(width: 1.6cm) #h(0.8cm) Splits with $S <= 63$: #blank(width: 1.6cm)
  #h(0.8cm) Total: #blank(width: 1.6cm) \
  #v(0.1cm)
  #h(0.4cm) #text(size: 12pt)[$p = $ #blank(width: 1.2cm) $\/ 35 = $ #blank(width: 2cm)]
]

#question[
  1.5 That is not an estimate. It is the exact probability of a difference this large if the
  treatment did nothing, and you computed it by adding three numbers at a time. At
  $alpha = 0.05$, what do you conclude — and say it in a sentence that does not use the word
  "proves."
]

#answer-space(height: 2.4cm)

#pagebreak()

== Part 2. Why Bother Simulating? #h(1fr) #text(size: 9pt, style: "italic", weight: "regular")[12 minutes]

Open `Class14_Thirty_Five_Worlds_Skeleton.ipynb`. You just did by hand what the notebook is
about to do three ways.

#question[
  #set par(justify: false)
  2.1 Exhaustive enumeration, in code. Does it agree with the board? #blank(width: 2.2cm) \
  #v(0.1cm)
  2.2 Five thousand random shuffles instead. $p approx$ #blank(width: 2.2cm) \
  #v(0.1cm)
  Run it twice more: #blank(width: 2.2cm) #h(0.5cm) #blank(width: 2.2cm)
]

#question[
  #set par(justify: false)
  2.3 The same trial with 70 patients, 30 control and 40 treated. Number of possible splits: \
  #v(0.1cm)
  #h(0.4cm) #blank(width: 6cm) \
  #v(0.1cm)
  #set par(justify: true)
  At a million splits per second, roughly how long would the exhaustive version take? You do
  not need a precise answer — an order of magnitude and a unit anyone can picture.
]

#answer-space(height: 1.8cm)

== Part 3. What a p-value Does When Nothing Is Happening #h(1fr) #text(size: 9pt, style: "italic", weight: "regular")[13 minutes]

The notebook now runs 500 complete experiments in which the treatment genuinely does
nothing — no effect, by construction — and records the p-value from each.

#question[
  #set par(justify: false)
  3.1 #emph[Predict first.] Most of those 500 p-values will be: \
  #v(0.1cm)
  #h(0.4cm) NEAR 1 #h(1.2cm) NEAR 0.5 #h(1.2cm) NEAR 0 #h(1.2cm) SPREAD EVENLY
]

#question[
  #set par(justify: false)
  3.2 Describe the histogram you got in one sentence. \
  #v(0.1cm)
  #h(0.4cm) Fraction of the 500 with $p < 0.05$: #blank(width: 2.2cm)
]

#answer-space(height: 1.6cm)

#question[
  3.3 Nothing was wrong with any of those 500 experiments. No bad data, no mistakes, no
  cheating. Explain, in terms of the histogram, where those significant results came from.
]

#answer-space(height: 2.2cm)

#question[
  #set par(justify: false)
  3.4 Now the same 500 experiments with a real effect present. \
  #v(0.1cm)
  #h(0.4cm) Fraction with $p < 0.05$: #blank(width: 2.2cm) \
  #v(0.1cm)
  #set par(justify: true)
  A real effect was there every single time, and the test still missed it in a good fraction
  of the runs. Which type of error is that, and what would you change to make it rarer?
]

#answer-space(height: 2.2cm)

== Discussion #h(1fr) #text(size: 9pt, style: "italic", weight: "regular")[5 minutes]

#question[
  D1. Thirty-three groundhogs predict the weather and Essex Ed comes out significant. You
  have now seen the machinery that produces an Ed. Using your Part 3 histogram, explain to
  someone who has not taken this course why finding one significant groundhog out of
  thirty-three is not evidence of anything.
]

#answer-space(height: 3cm)

#question[
  D2. Our seven-patient trial did not reach significance. A colleague writes up the result as
  "the treatment was shown to have no effect." Two things are wrong with that sentence. Name
  both.
]

#answer-space(height: 3cm)
