#set document(
  title: "Honors Class Activity: Would It Replicate?",
  author: "Elements of Data Science",
  keywords: ("data science", "honors", "p-value", "replication", "confidence interval", "activity"),
)

#set page(paper: "us-letter", margin: (x: 1in, y: 0.75in))
#set par(justify: true, leading: 0.6em, spacing: 0.85em)
#set heading(numbering: none)
#set text(font: "Liberation Serif", size: 11pt, lang: "en", region: "us")

#show raw.where(block: true): it => block(
  fill: rgb("#f2f2f2"), inset: 8pt, radius: 3pt, width: 100%,
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
#let blank(width: 2.5cm) = box(width: width, height: 0.9em, stroke: (bottom: 0.5pt + black))
#let answer-space(height: 2cm) = block(height: height, width: 100%)
#let stopbar(body) = block(
  width: 100%, inset: 7pt,
  stroke: (top: 1.5pt + black, bottom: 1.5pt + black),
  align(center, text(weight: "bold", body)),
)

= Would It Replicate?

*Team Members:* #h(0.2cm) #blank(width: 4.2cm) #h(0.3cm) #blank(width: 4.2cm) #h(0.3cm) #blank(width: 4.2cm)

#v(0.3cm)
#h(2.85cm) #blank(width: 4.2cm) #h(0.3cm) #blank(width: 4.2cm)

#v(0.1cm)
#block(width: 100%, inset: 7pt, fill: rgb("#f2f2f2"), radius: 3pt)[
  *Everything in this activity is simulated.* The creek, its sampling sites and every chloride
  value come from a random number generator. It is set up like your Pennypack upstream/downstream
  chloride comparison, but it is *not* the Pennypack data and says nothing about your Pennypack result.
]

== Part 1 --- The Report

#block(width: 100%, inset: 10pt, stroke: 0.75pt + black, radius: 3pt)[
  *Team A:* We measured chloride at 12 randomly chosen sites upstream of a stormwater outfall
  and 12 randomly chosen sites downstream. Downstream sites averaged *35 mg/L higher*. A test of
  the difference in means gives *p = 0.03*.
]

Team B will now repeat the survey exactly: same creek, same season, 12 sites on each side, with
a new random choice of sites.

#question[
1. What is the chance that Team B's survey *also* comes out with p < 0.05? Each team member
  writes a number on their own, then compare.
]

#h(0.6cm) Me: #blank(width: 1.8cm) % #h(1.2cm) Teammates: #blank(width: 1.8cm) % #h(0.3cm) #blank(width: 1.8cm) % #h(0.3cm) #blank(width: 1.8cm) %

#question[
2. What did you use to get your number?
]

#h(0.6cm) #blank(width: 14.5cm)

#v(0.15cm)
#stopbar[STOP. Every team member answers 1 and 2 before anyone opens the notebook.]

== Part 2 --- Run the Creek

In the notebook you can do something no field team can: survey the same creek as many times as
you like. You also know the creek's truth. Downstream sites average *33 mg/L* more chloride than
upstream sites, and individual sites scatter around their average with an SD of 40 mg/L.

#question[
3. _After 2.3:_ Run one survey three times.
]

#align(center)[
  #table(
    columns: (2.2cm, 4.2cm, 3.2cm, 2.6cm),
    align: center, inset: 5.5pt,
    table.header([*Survey*], [*Difference (mg/L)*], [*p-value*], [*p < 0.05?*]),
    [1], [], [], [],
    [2], [], [], [],
    [3], [], [], [],
  )
]

#question[
4. _After 2.4 at 10, before you change it to 1000:_ Predict what fraction of 1000 surveys of
  this creek will give p < 0.05.
]

#h(0.6cm) Prediction: #blank(width: 1.6cm) #h(0.4cm) _After 2.5:_ actual #blank(width: 1.6cm) #h(0.4cm) smallest p #blank(width: 1.6cm) #h(0.3cm) largest p #blank(width: 1.6cm)

#v(0.15cm)
#h(0.6cm) The creek never changed. What did? #blank(width: 8.5cm)

#pagebreak()

== Part 3 --- Only the Surveys Like Team A's

The notebook now runs the creek in pairs: an _original_ survey and a _replicate_ of it. Then it
keeps only the pairs whose original came out like Team A's, with p between 0.01 and 0.05.

#question[
5. _Predict, before 3.2:_ Among the replicates of those kept pairs, the fraction with p < 0.05
  will be (circle one) compared with your answer to question 4:
]

#h(0.6cm) HIGHER #h(1cm) ABOUT THE SAME #h(1cm) LOWER #h(1cm) because #blank(width: 5.5cm)

#question[
6. _After 3.2:_
]

#h(0.6cm) Pairs kept: #blank(width: 1.6cm) of 1000 #h(1cm) Their replicates with p < 0.05: #blank(width: 2cm)

#v(0.15cm)
#h(0.6cm) All 1000 replicates with p < 0.05: #blank(width: 2cm)

#question[
7. _After 3.3:_ A survey gets p < 0.05 when its observed difference is more than
  #box[#blank(width: 1.6cm) mg/L] from zero. The creek's true difference is 33 mg/L. Use those
  two numbers to explain (a) the fraction you found in question 4, and (b) why an original
  p = 0.03 does not change the replicate's chances.
]

#h(0.6cm) (a) #blank(width: 14cm)
#v(0.3cm)
#h(0.6cm) #blank(width: 14.5cm)
#v(0.3cm)
#h(0.6cm) (b) #blank(width: 14cm)
#v(0.3cm)
#h(0.6cm) #blank(width: 14.5cm)

== Part 4 --- Twenty Surveys, Twenty Intervals

The last cell runs twenty surveys of the same creek. Each one gets a 95% bootstrap confidence
interval (Class 19) and a p-value. Every team sees the same twenty surveys. Answer from the plot
and table only; you do not need to read the code.

#question[
8. Count, out of 20:
]

#h(0.6cm) Intervals containing 33: #blank(width: 1.2cm) #h(0.5cm) p < 0.05: #blank(width: 1.2cm) #h(0.5cm) intervals entirely above 0: #blank(width: 1.2cm)

#v(0.15cm)
#h(0.6cm) One survey's interval and p-value disagree about whether there is a difference. Which? #blank(width: 1.2cm)

#question[
9. Compare survey 3 and survey 13. Write each one's observed difference, interval and p-value.
  A report that only says "significant" or "not significant" would describe them as opposites. Is
  that a fair description of what the two surveys found?
]

#h(0.6cm) Survey 3: #blank(width: 12.5cm)
#v(0.3cm)
#h(0.6cm) Survey 13: #blank(width: 12.2cm)
#v(0.3cm)
#h(0.6cm) #blank(width: 14.5cm)

#block(breakable: false)[
#question[
10. Back to Part 1. In one or two sentences, tell Team B what Team A's p = 0.03 does and does
  not tell them about their own survey.
]

#h(0.6cm) #blank(width: 14.5cm)
#v(0.3cm)
#h(0.6cm) #blank(width: 14.5cm)
#v(0.3cm)
#h(0.6cm) #blank(width: 14.5cm)
]

== If You Finish Early

#question[
A. The average observed difference among the _significant_ surveys was #box(blank(width: 1.6cm))
  mg/L. The truth is 33. Suppose a journal only prints surveys with p < 0.05. What happens to the
  differences readers see in print?
]

#answer-space(height: 1.4cm)

#question[
B. With a true difference of 60 mg/L: pairs kept #box(blank(width: 1.4cm)), their replicates with
  p < 0.05 #box(blank(width: 1.6cm)). Why didn't the null distribution need to be rebuilt? What
  does this tell you about whether "the chance a p = 0.03 result replicates" has one answer?
]

#answer-space(height: 1.4cm)
