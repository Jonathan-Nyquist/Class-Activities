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

#align(center)[#text(style: "italic")[Class 13 · replacement, convenience sampling, bias vs. precision · handout + skeleton notebook]]

#v(0.2cm)

*The idea.* How a sample is drawn matters more than how big it is. Part 1 shows it with one keyword:
`replace=True` almost halves the chance of winning the marble contest. Part 2 shows it with geography.
A crew that samples only where it can park collects three times the data and gets estimates twice as
tight, and it is wrong nearly every time, because in this stream access and chloride are linked through
the road bridges.

*What students produce.* Two simulated win probabilities, a repeat rate, a comparison of two sampling
designs, an interpretation of a two-humped histogram, and three discussion answers. *What this does not
claim to teach:* stratified or systematic designs, the finite-population correction, or anything about
real chloride in a real creek (the stream is simulated, and the handout says so).

*Materials.* Handout, skeleton notebook, `data/stream_sim.csv`. The notebook reads from `data/`, but
the CSV was sitting loose in the class folder, so I copied it into a new `data/` subfolder. Upload it that
way on the hub.

== Timing (50 min)

#table(
  columns: (1fr, 1.3cm, 3fr),
  inset: 5pt,
  stroke: 0.5pt + rgb("#888888"),
  [*Segment*], [*Min*], [*What happens*],
  [Part 1], [12], [Predict, simulate both ways, 1.3 and the tank callback.],
  [Part 2], [22], [Truth, random samples, the replacement default, predict, then the thousand-season comparison.],
  [Part 3], [8], [The two humps; histogram vs. box plot.],
  [Discussion], [8], [D1 and D2 in the room; D3 if time allows, otherwise take it home.],
)

#warn[The 50-minute budget is an estimate. Part 2 is long. If a team is behind at minute 30, give them
the convenience loop (Appendix) so they reach the comparison table. The table and 2.6 are the core; 2.3
can be a show of hands.]

#warn[*Question numbers don't match.* Notebook 1.1 and 1.2 are the two simulations (handout 1.1 is the
prediction and 1.2 records both results). Notebook 2.4 builds the convenience loop (handout 2.4 is
the prediction). Notebook 3.1 and 3.2 run the histogram and the box plot, and notebook 3.3 is handout
3.1. Same fix as Classes 11 and 12 if you want it.]

== The numbers

All computed in the local `ds313` environment from `stream_sim.csv` (240 reaches).

#table(
  columns: (2.6fr, 3fr),
  inset: 5pt,
  stroke: 0.5pt + rgb("#888888"),
  [Marble contest, exact], [with replacement $6\/27 = 0.222$; without $48\/120 = bold(0.400)$],
  [True mean chloride], [*90.2* mg/L (population SD 36.9, range 18.4–189.4)],
  [Access], [87 `easy`, 153 `hard` (36% easy); easy mean 111.6, hard mean 78.0],
  [P(repeat) in `creek.sample(12)`], [exact 0.244; one run of 1000 gave 0.255],
  [Easy box plot], [median *121.5*, IQR *72.8* (Q1 73.4, Q3 146.2); hard median 80.6, IQR 34.6],
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
#text(size: 9pt)[One run of 1000 each. Theory agrees: the SE for random $n = 12$ is 10.4; for convenience
$n = 40$ drawn without replacement from 87 reaches, 5.0. The bias is $111.6 - 90.2 = 21.4$ mg/L, about
twice the random design's SD. The third row is what a team gets if it forgets `with_replacement=False`
in the convenience loop.]
]

#part-heading([Part 1. Two Words That Change the Answer], minutes: 12)

#ans[1.1][Anything, committed. Guesses tend to cluster around 1\/3 or "about 1\/4."]

#ans[1.2][Replaced about 0.22; kept out about 0.40 (one run: 0.2224 / 0.3952). The notebook blank is
`three_different_colors(False)`.]

#ans[1.3][KEPT OUT: you reach into a bag and keep what you draw. `np.random.choice` samples _with_ replacement by default
(`replace=True`), and has all semester. The default cut the answer from 0.40 to 0.22, almost in
half. Why: without replacement, once a red is drawn only one red is left among five marbles, so a second
red is less likely. With replacement the bag never "remembers." Exact: $(6 dot 4 dot 2)\/(6 dot 5 dot 4) =
2\/5$ vs. $3!\/3^3 = 6\/27$.]

#note[Dice and coins are _supposed_ to be sampled with replacement, since a die can't run out of sixes.
That's why the default never mattered before. It bites the moment the population is a set of physical things.]

#ans[1.4][A captured tank is in your yard. You can't capture it again or read its serial a second time.
Sampling without replacement is a property of the physical process, not a coding choice. (Class 11's
notebook said `replace=False` explicitly; this is why.)]

#part-heading([Part 2. A Stream With No Name], minutes: 22)

#ans[2.1][90.2 mg/L (90.15).]

#ans[2.2][Varies. The middle 90% of random-12 estimates runs from 73 to 108 (5,000 simulated samples).
Teams should see their three estimates differ by 10 or more.]

#ans[2.3][About 0.24–0.26. `Table.sample` also defaults to `with_replacement=True`. A repeat means you walked
to the same reach twice and wrote its number down twice. That spot counts double in the average, and you
visited 11 places while reporting 12. Strong answers note that it also makes the sample _look_ bigger
than it is (Class 12's duplicated rows, on a small scale).]

#ans[2.4][TOO HIGH: access means roads, roads cross at bridges, and bridges are where road salt
enters. Accept any answer with a mechanism. TOO LOW ("parks are cleaner") is a reasonable prediction and
worth hearing; the data says otherwise.]

#ans[2.5][See _The numbers_. Random: centre about 90, SD about 10, within 10 of truth about 0.68. Convenience: centre about 112,
SD about 5, within 10 of truth about 0.01.]

#warn[*Convenience-loop bugs, by symptom.*
- Centre about 90 instead of 112: the sample was drawn from `creek`, not `easy`.
- SD about 7 instead of 5: `easy.sample(40)` without `with_replacement=False`. That's Part 1 again;
  point it out rather than just fixing it.
- `np.mean(s)` fails: `s` is a table. It needs `s.column('Cl (mg/L)')`.
- 2000 estimates or a column-length mismatch: the estimates were appended to `random_estimates`. The notebook's check cell names this.]

#ans[2.6][It's biased. Every convenience sample comes from the part of the stream next to roads, which is
saltier than the stream as a whole, so it misses by about 21 mg/L in the same direction every time.
Precision measures how well the estimates agree with each other, not whether they agree with the truth. Doubling effort to 80
reaches (almost all 87 easy ones) drives the SD down to about 1.4 and leaves the centre at 111.6
(both from 5,000 simulated samples). The survey becomes more confident and exactly as wrong. The only fix
is changing _where_ you sample, not how much.]

#note[This is Class 11 in reverse. There, the unbiased estimator had the larger SD and still won on
"within 20%." Here the biased design has the smaller SD and almost never lands within 10.]

#part-heading([Part 3. What the Shapes Say], minutes: 8)

#ans[3.1][The easy reaches come in clusters, one per road crossing (18 in all). In each cluster the first
reach is just upstream of the bridge and the next few are just downstream. *High hump* (about 110–190): the
reaches immediately _below_ a bridge, where salt runoff enters. That's about 53 reaches, peaking at the
crossing and decaying downstream. *Low hump* (about 30–90): reaches at the creek's background level. These are the reach just
_above_ each bridge, plus three longer accessible stretches away from a crossing (km 6.3–6.9, 12.4–12.9
and 18.5–18.9) that look like a trail or park, about 34 reaches in all. The two humps are "creek downstream of
a road" and "creek the road hasn't reached yet."]

#warn[Notebook 3.3 says "the locations of the road crossings will tell you," but the table has no
crossings column. Students have to infer crossings from the clusters in `km downstream`. That's fine, and
worth a nudge: `easy.sort('km downstream').show(20)` makes the pattern visible within the first few
clusters.]

#ans[][Background chloride also rises downstream: the hard-reach mean is 50, 74, 90 and 103 mg/L in successive 6 km blocks.
So "low" at km 22 is higher than "low" at km 1, which blurs both humps. Mention it if a team notices;
it isn't required.]

#ans[3.2][Median 121.5, IQR 72.8 (seaborn's quartiles match `np.percentile`). The histogram shows the
two humps and the thin gap near 100. The box plot hides both: its median sits _in_ the upper hump, and
its wide box spans the gap as if values were spread evenly across it. The box plot makes it easier to
compare centre and spread across groups at a glance (easy vs. hard medians 121.5 vs. 80.6), which is hard
to read off overlaid histograms.]

== Discussion

#ans[D1(a)][They measured real creek correctly, then generalized to the whole creek from a subset that
differs from it systematically. Accessibility is correlated with the thing being measured, because roads
bring both parking and salt. The error is in the inference, not the measurement. "The mean at
accessible reaches is 112" is true; "the creek's mean is 112" is not.]

#ans[D1(b)][Anything about the roads' effect: how much chloride a crossing adds, how fast it decays
downstream, which bridges are worst. The accessible reaches bracket every bridge, upstream and downstream,
which makes them a ready-made before/after design. Twelve random reaches would rarely land at a bridge.
Whether a sample is biased depends on the question you're asking.]

#ans[D2][A huge sample shrinks the spread, not the bias. The _Digest_ poll was the convenience-40 survey on a
national scale: extremely precise and aimed at the wrong population.]

#note[*Keep the history precise.* The usual story is that the _Digest_ drew names from telephone books
and car registrations, which skewed wealthy. Later analysis (Squire, _Public Opinion Quarterly_, 1988,
using a 1937 Gallup survey) found *non-response* was at least as important: Landon supporters were more
likely to mail the ballot back. Both are "where you can park" failures. The sampling frame is who you can reach;
non-response is who reaches back. Gallup called the winner with a far smaller sample but also
underestimated Roosevelt's share, so don't present his poll as exact.]

#ans[D3][Questions to ask: were the sites fixed before anyone went to the field, and on what basis, or chosen on the day?
What made a site reachable? Were any planned sites dropped, and why? Things to look for in the data: how the sites are
spread along the stream (clusters vs. even coverage, which `km downstream` revealed here); whether they sit
near roads, outfalls or bridges that might drive the variable; and whether a systematically chosen subset
gives the same answer. Strong answers pair each question with a check in the data, as the prompt asks.]

#pagebreak()

== Appendix: solution code (instructor only)

```python
# 1.2
wins = 0
for i in np.arange(10000):
    if three_different_colors(False):
        wins = wins + 1
wins / 10000                                        # about 0.40

# 2.4
convenience_estimates = make_array()
for i in np.arange(1000):
    s = easy.sample(40, with_replacement=False)
    convenience_estimates = np.append(convenience_estimates,
                                      np.mean(s.column('Cl (mg/L)')))

# 3.3: see the clusters
easy.sort('km downstream').show(20)
```
