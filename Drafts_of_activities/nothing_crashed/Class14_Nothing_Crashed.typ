#set document(
  title: "Honors Class 14 Activity: Nothing Crashed",
  author: "Elements of Data Science",
  keywords: ("data science", "honors", "debugging", "sampling", "hypothesis test", "activity"),
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

#show heading.where(level: 3): it => [
  #set text(size: 11pt, weight: "bold", style: "italic")
  #block(above: 10pt, below: 5pt, it.body)
]

= Nothing Crashed

*Team Members:* #h(0.2cm) #blank(width: 4.2cm) #h(0.3cm) #blank(width: 4.2cm) #h(0.3cm) #blank(width: 4.2cm)

#v(0.3cm)
#h(2.85cm) #blank(width: 4.2cm) #h(0.3cm) #blank(width: 4.2cm)

== Part 1 --- The Report

Riverton is an invented city, and its bus system and data are invented too. A summer intern
analyzed every trip Riverton Transit ran in 2025 and turned in this report:

#block(width: 100%, inset: 10pt, stroke: 0.75pt + black, radius: 3pt)[
  *Riverton Transit --- 2025 Performance Summary (draft)*

  + The Blue Line is our worst line. It had more late trips (more than 5 minutes behind
    schedule) than any other line.
  + Riverton Transit advertises that 80% of trips arrive within 5 minutes of schedule. In a
    sample of 80 trips, only 51 did. A simulation gives a p-value of 0.0, so the 80% claim is
    false.
]

#question[
1. Before you see any code: which claim do you trust *least*? Each team member circles one
  on their own, then compare.
]

#h(0.6cm) Me: #h(0.4cm) 1 #h(0.6cm) 2 #h(1.5cm) Teammates chose: #blank(width: 5cm)

#question[
2. For the claim you circled, name one specific thing that could have gone wrong.
]

#h(0.6cm) #blank(width: 14.5cm)

#v(0.15cm)
#stopbar[STOP. Every team member answers 1 and 2 before anyone opens the notebook.]

== Part 2 --- The Intern's Notebook

The notebook has the intern's code exactly as written. Every cell runs without an error.
*Write each prediction before you run the cell it is about.*

=== Exhibit A --- Claim 1

```
late_trips = trips.where('minutes late', are.above(5))
late_trips.group('line')
```

#question[
3. _Predict:_ The output will give a count of late trips for each line. Give a reason one line
  could have the largest count without being the worst line.
]

#h(0.6cm) #blank(width: 14.5cm)

#question[
4. _A.3, by hand:_ Blue's fraction late #h(0.3cm) $=$ #h(0.2cm) #blank(width: 1.5cm) late trips $div$ #blank(width: 1.5cm) total trips $=$ #blank(width: 1.8cm)
]

#h(0.6cm) _Then from the notebook,_ the fraction late for every line:


#h(0.6cm) Blue #blank(width: 1.8cm) #h(0.4cm) Red #blank(width: 1.8cm) #h(0.4cm) Green #blank(width: 1.8cm) #h(0.4cm) Gold #blank(width: 1.8cm)

#v(0.2cm)
#h(0.6cm) Claim 1: #h(0.3cm) STANDS #h(0.8cm) FALLS #h(1cm) The worst line is #blank(width: 3.5cm)

#pagebreak()

=== Exhibit B --- Claim 2, the sample

```
sample = trips.take(np.arange(80))
observed = np.count_nonzero(sample.column('minutes late') <= 5)
```

#question[
5. _Predict:_ The table is sorted by date and covers all 12 months. Roughly which dates will
  the intern's 80 trips come from? Why would that matter for a bus system?
]

#h(0.6cm) #blank(width: 14.5cm)

#question[
6. _After B.2 and B.3:_ The intern's sample ran from #blank(width: 2.5cm) to #blank(width: 2.5cm).
]

#h(0.6cm) `with_replacement =` #h(0.3cm) TRUE #h(0.6cm) FALSE #h(0.8cm) because #blank(width: 7cm)

#v(0.15cm)
#h(0.6cm) Your random sample: #blank(width: 1.5cm) of 80 trips on time.

=== Exhibit C --- Claim 2, the test

```
simulated = make_array()
for i in np.arange(10000):
    one = claim.sample_from_distribution('Chance', 80).column('Chance sample').item(0)
simulated = np.append(simulated, one)

p_value = np.count_nonzero(simulated <= observed) / 10000
```

#question[
7. _Trace before you run (after C.1):_ Here is the intern's loop shrunk to 3 repetitions.
  Suppose the three simulated on-time counts come out 63, then 66, then 61. Fill in what
  `simulated` holds at each moment.
]

#align(center)[
  #table(
    columns: (4.6cm, 2.2cm, 5.2cm),
    align: center,
    inset: 5.5pt,
    table.header([*Moment*], [*`one`*], [*`simulated`*]),
    [before the loop], [---], [`[ ]` (empty)],
    [after repetition `i = 0`], [63], [],
    [after repetition `i = 1`], [66], [],
    [after repetition `i = 2`], [61], [],
    [after the `np.append` line], [61], [],
  )
]

#h(0.6cm) So with 10,000 repetitions, `simulated` will hold #blank(width: 2cm) number(s).

#question[
8. _After C.4:_ Your team's p-value with the loop fixed:
]

#h(0.6cm) p-value: #blank(width: 2.5cm) #h(1.5cm) Claim 2: #h(0.3cm) STANDS #h(0.8cm) FALLS

#pagebreak()

== Part 3 --- The Verdict

#question[
9. As the intern wrote it, what is the _largest_ p-value the test in Exhibit C could ever
  produce? What does that tell you about every conclusion that code could have reached?
  #linebreak() #text(weight: "regular")[_Hint:_ `simulated` holds one number. How many of
  its values can be `<= observed`? Then divide by 10000.]
]

#h(0.6cm) #blank(width: 14.5cm)
#v(0.3cm)
#h(0.6cm) #blank(width: 14.5cm)

#question[
10. Rewrite Claim 2 as one honest sentence, using your team's numbers.
]

#h(0.6cm) #blank(width: 14.5cm)
#v(0.3cm)
#h(0.6cm) #blank(width: 14.5cm)

== If You Finish Early

#question[
A. Every team drew a different random sample. Compare your p-value with another team's. If
  one team in the room got a p-value below 0.05, what should the class conclude about Claim 2?
]

#answer-space(height: 1.6cm)

#question[
B. The intern's table holds *every* trip Riverton ran in 2025. To check Claim 2, do you need
  a sample --- or a hypothesis test --- at all? If a test still makes sense, what question is
  it answering?
]

#answer-space(height: 1.6cm)
