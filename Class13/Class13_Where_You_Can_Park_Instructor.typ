#set document(
  title: "Honors Class 13 Instructor Notes: Where You Can Park",
  author: "Elements of Data Science",
)

#set page(paper: "us-letter", margin: (x: 1in, y: 1in))
#set par(justify: true, leading: 0.65em)
#set heading(numbering: none)
#set text(font: "Liberation Serif", size: 11pt, lang: "en", region: "us")

#show raw.where(block: true): it => block(
  fill: rgb("#f2f2f2"), inset: 8pt, radius: 3pt, width: 100%, breakable: false,
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

#let part-heading(title, minutes: none) = heading(level: 2)[
  #title #if minutes != none [#h(1fr) #text(weight: "regular", size: 10pt)[(≈ #minutes min)]]
]

#let note(body) = block(
  width: 100%, inset: 8pt, radius: 3pt,
  fill: rgb("#eef4fb"), stroke: (left: 2pt + rgb("#3a6ea5")),
  [*Note.* #body],
)
#let warn(body) = block(
  width: 100%, inset: 8pt, radius: 3pt,
  fill: rgb("#fdf1e6"), stroke: (left: 2pt + rgb("#c0661a")),
  [*Watch out.* #body],
)
#let ans(label, body) = block(
  width: 100%, inset: (left: 8pt, top: 3pt, bottom: 3pt),
  stroke: (left: 2pt + rgb("#4a4a4a")),
  [*#label* #h(0.3em) #body],
)

= Where You Can Park — Instructor Notes

#align(center)[#text(style: "italic")[Class 13 · replacement, convenience sampling, bias vs. precision · 20 min · handout + skeleton notebook]]

#v(0.2cm)

*The idea.* How a sample is drawn matters more than how big it is. Part 1 shows it with one keyword:
`replace=True` almost halves the chance of winning the marble contest. Part 2 shows it with geography.
A crew that samples only where it can park collects three times the data and gets estimates twice as
tight, and it is wrong nearly every time, because in this stream access and chloride are linked through
the road bridges.

*What students produce.* Two simulated win probabilities, a prediction and a comparison of two sampling
designs, and one discussion answer. *What this does not claim to teach:* stratified or systematic designs,
the finite-population correction, or anything about real chloride in a real creek (the stream is
simulated, and the handout says so).

*Materials.* Handout, skeleton notebook, `data/stream_sim.csv`. The notebook reads from `data/`, so
upload it that way on the hub.

== Timing (20 min)

#table(
  columns: (1fr, 1.3cm, 3fr),
  inset: 5pt,
  stroke: 0.5pt + rgb("#888888"),
  [*Segment*], [*Min*], [*What happens*],
  [Part 1], [5], [Predict, simulate both ways, 1.3.],
  [Part 2], [11], [Truth, predict, convenience loop, comparison table, 2.4.],
  [Discussion], [4], [_Literary Digest_, whole class.],
)

#warn[Part 2 is the core. If a team hasn't reached the convenience loop by minute 9, give them the
sampling line from the Appendix so they get to the table and 2.4. Part 1 can shrink to a
show of hands on 1.3 if the room is slow to start.]

#note[*Cut for time (October 2026).* The full 50-minute version also had the tank callback (1.4), three
hand-drawn random samples, the careless-repeat count with `creek.sample(12)`, Part 3 (the two-humped
histogram and the box plot), the streetlight question and the field-dataset question. It's in git
history (commit `f22088e`) if you want to reuse any of it.]

Handout and notebook question numbers now match.

== The numbers

All computed in the local `ds313` environment from `stream_sim.csv` (240 reaches).

#table(
  columns: (2.6fr, 3fr),
  inset: 5pt,
  stroke: 0.5pt + rgb("#888888"),
  [Marble contest, exact], [with replacement $6\/27 = 0.222$; without $48\/120 = bold(0.400)$],
  [True mean chloride], [*90.2* mg/L (population SD 36.9, range 18.4–189.4)],
  [Access], [87 `easy`, 153 `hard` (36% easy); easy mean 111.6, hard mean 78.0],
)

#v(0.2cm)
#block(breakable: false)[
#align(center)[
#table(
  columns: (4.6cm, 2.4cm, 2.2cm, 3cm),
  inset: 5pt, align: center, stroke: 0.5pt + rgb("#888888"),
  [], [*centre*], [*SD*], [*within 10 of truth*],
  align(left)[random, n = 12], [90.2], [10.3], [0.68],
  align(left)[convenience, n = 40], [111.6], [5.1], [0.013],
  align(left)[#text(size: 9pt)[convenience, n = 40, _with_ replacement]], [#text(size: 9pt)[111.5]], [#text(size: 9pt)[7.0]], [#text(size: 9pt)[0.05]],
)]
#text(size: 9pt)[One run of 1000 each; another run gave 90.1 / 10.3 / 0.667 and 111.6 / 4.9 / 0.006.
Theory agrees: the SE for random $n = 12$ is 10.4; for convenience $n = 40$ drawn without replacement
from 87 reaches, 5.0. The bias is $111.6 - 90.2 = 21.4$ mg/L, about twice the random design's SD. The
third row is what a team gets if it forgets `with_replacement=False` in the convenience loop.]
]

#part-heading([Part 1. Two Words That Change the Answer], minutes: 5)

#ans[1.1][Anything, committed. Guesses tend to cluster around 1\/3 or "about 1\/4."]

#ans[1.2][Replaced about 0.22; kept out about 0.40 (one run: 0.2225 / 0.3956). The notebook blank is
`three_different_colors(False)`.]

#ans[1.3][KEPT OUT: you reach into a bag and keep what you draw. `np.random.choice` samples _with_ replacement by default
(`replace=True`), and has all semester. The default cut the answer from 0.40 to 0.22, almost in
half. Why: without replacement, once a red is drawn only one red is left among five marbles, so a second
red is less likely. With replacement the bag never "remembers." Exact: $(6 dot 4 dot 2)\/(6 dot 5 dot 4) =
2\/5$ vs. $3!\/3^3 = 6\/27$.]

#note[Dice and coins are _supposed_ to be sampled with replacement, since a die can't run out of sixes.
That's why the default never mattered before. It bites the moment the population is a set of physical things.]

#part-heading([Part 2. A Stream With No Name], minutes: 11)

#ans[2.1][90.2 mg/L (90.15).]

#ans[2.2][TOO HIGH: access means roads, roads cross at bridges, and bridges are where road salt
enters. Accept any answer with a mechanism. TOO LOW ("parks are cleaner") is a reasonable prediction and
worth hearing; the data says otherwise.]

#ans[2.3][See _The numbers_. Random: centre about 90, SD about 10, within 10 of truth about 0.68. Convenience: centre about 112,
SD about 5, within 10 of truth about 0.01.]

#warn[*Convenience-loop bugs, by symptom.*
- Centre about 90 instead of 112: the sample was drawn from `creek`, not `easy`.
- SD about 7 instead of 5: `easy.sample(40)` without `with_replacement=False`. That's Part 1 again;
  point it out rather than just fixing it.
- 2000 estimates or a column-length mismatch: the estimates were appended to `random_estimates`. The notebook's check cell names this.]

#ans[2.4][It's biased. Every convenience sample comes from the part of the stream next to roads, which is
saltier than the stream as a whole, so it misses by about 21 mg/L in the same direction every time.
Precision measures how well the estimates agree with each other, not whether they agree with the truth. Doubling effort to 80
reaches (almost all 87 easy ones) drives the SD down to about 1.4 and leaves the centre at 111.6
(both from 5,000 simulated samples). The survey becomes more confident and exactly as wrong. The only fix
is changing _where_ you sample, not how much.]

#note[This is Class 11 in reverse. There, the unbiased estimator had the larger SD and still won on
"within 20%." Here the biased design has the smaller SD and almost never lands within 10.]

== Discussion

#ans[D][A huge sample shrinks the spread, not the bias. The _Digest_ poll was the convenience-40 survey on a
national scale: extremely precise and aimed at the wrong population.]

#note[*Keep the history precise.* The usual story is that the _Digest_ drew names from telephone books
and car registrations, which skewed wealthy. Later analysis (Squire, _Public Opinion Quarterly_, 1988,
using a 1937 Gallup survey) found *non-response* was at least as important: Landon supporters were more
likely to mail the ballot back. Both are "where you can park" failures. The sampling frame is who you can reach;
non-response is who reaches back. Gallup called the winner with a far smaller sample but also
underestimated Roosevelt's share, so don't present his poll as exact.]

== Appendix: solution code (instructor only)

```python
# 1.2
wins = 0
for i in np.arange(10000):
    if three_different_colors(False):
        wins = wins + 1
wins / 10000                                        # about 0.40

# 2.3 convenience loop: the blank is the sampling line
convenience_estimates = make_array()
for i in np.arange(1000):
    s = easy.sample(40, with_replacement=False)
    convenience_estimates = np.append(convenience_estimates,
                                      np.mean(s.column('Cl (mg/L)')))
```
