#set document(title: "Honors Class Instructor Notes: Would It Replicate?", author: "Elements of Data Science")
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
#let note(body) = block(width: 100%, inset: 8pt, radius: 3pt,
  fill: rgb("#eef4fb"), stroke: (left: 2pt + rgb("#3a6ea5")), [*Note.* #body])
#let warn(body) = block(width: 100%, inset: 8pt, radius: 3pt,
  fill: rgb("#fdf1e6"), stroke: (left: 2pt + rgb("#c0661a")), [*Watch out.* #body])
#let ans(label, body) = block(width: 100%, inset: (left: 8pt, top: 3pt, bottom: 3pt),
  stroke: (left: 2pt + rgb("#4a4a4a")), [*#label* #h(0.3em) #body])

= Would It Replicate? — Instructor Notes

#align(center)[#text(style: "italic")[After the Pennypack project and Class 19 (confidence intervals) · 30 min firm, ≈ 22 min planned · handout + skeleton notebook · no data files]]

#v(0.2cm)

*The idea.* Team A reports p = 0.03. Students guess the chance that an exact repeat also gives
p < 0.05. Many will say something like 95–97%, reading p as "a 3% chance the result was a fluke."
They then run a simulated creek whose truth they know. About half of all surveys give p < 0.05.
Keeping only the surveys that came out like Team A's changes nothing, because a replicate never
sees the original. The p-value is a property of one dataset, not of the creek. A plot of 20 surveys
with bootstrap CIs then shows the same creek producing p from 0.0002 to 0.79.

*What students produce.* A committed prediction, a measured replication rate (overall and
conditional on 0.01 ≤ p < 0.05), an explanation of that rate from the significance cutoff and the
true difference, and a one-sentence statement of what p = 0.03 does and does not predict.
*What this does not claim to teach:* power as a formula, sample-size planning, Bayesian
replication probabilities, or anything about real Pennypack chloride. The world is simulated, and the
handout says so in a box at the top and again in the notebook.

*New material:* none beyond a log-scale histogram. The null distribution is built *once*, by
simulating a no-difference creek 10,000 times, and reused for every p-value. This is legitimate only
because we built the world and know its SD. With real data you shuffle (Class 15), and the
notebook says so.

*Materials.* Handout, skeleton notebook. No data files.

*Source.* Tidy Ecology, "What a p-value tells you, and what it does not" (28 Sept 2026,
tidyecology.com/posts/what-a-p-value-tells-you). It uses a fenced/grazed seedling experiment with
12 plots per side, power ≈ 0.53, and an original p in the 0.01–0.05 window. This activity keeps that
arc with three deliberate changes: a chloride creek instead of the grazing experiment; a simulated null
on the difference in means instead of the Welch t-test, matching our course toolbox; and percentile
bootstrap CIs (Class 19) instead of t intervals. The article cites Goodman (1992), _Statistics in
Medicine_ 11(7):875–879, and Cumming (2008), _Perspectives on Psychological Science_ 3(4):286–300.
Both are good further reading for Honors students.

== Timing (30 min firm)

#table(
  columns: (1fr, 1.3cm, 3fr),
  inset: 5pt, stroke: 0.5pt + rgb("#888888"),
  [*Segment*], [*Min*], [*What happens*],
  [Part 1], [3], [Read Team A's report; Q1 individually, then compare; Q2. Stop bar. Collect a few Q1 numbers on the board.],
  [Part 2], [6], [2.1–2.2 run (null takes about 1 s); Q3; loop at 10, Q4 prediction, 1000; log histogram.],
  [Part 3], [7], [Pairs at 10 then 1000; Q5 prediction; fill the filter; Q6; cutoff; Q7.],
  [Part 4], [4], [Run the prebuilt cell; Q8–9 from the plot.],
  [Close], [2], [Q10 out loud; return to the board numbers from Q1.],
)
That leaves 8 minutes of slack against the firm 30. Your class runs long, so plan on using it.

#warn[Never cut Part 3, because it carries the answer to Q1. If teams are still in Part 2 at minute 9, have them
skip Q3 after one run and go straight to the 1000-survey loop. If you are short at the end, cut Q9
and keep Q8 and Q10.]

#note[*Class 15 overlap.* Class 15 Part 3.4 already showed a world with power ≈ 0.5 (effect 5 days,
SD 6, n = 12: z = 2.04). Part 2 here is deliberately a callback to it, with a log axis added. The new
content is Part 3 (conditioning on the original's p) and Part 4 (p next to CIs). If you want more
time for those, skip the prediction in Q4.]

== The simulated creek and the numbers

Upstream mean 150 mg/L, downstream 183 mg/L (true difference 33), SD 40 at every site, 12 sites per
side. Statistic: downstream mean − upstream mean, two-sided (`np.abs`, as in Class 15). All numbers
below come from running the notebook code locally (`datascience` env: datascience 0.17.6,
NumPy 1.26.3, Python 3.10) plus vectorized checks with 200,000–400,000 simulated surveys.

#table(
  columns: (2.3fr, 3fr),
  inset: 5pt, stroke: 0.5pt + rgb("#888888"),
  [Standard error of the difference], [$40 sqrt(2 slash 12) = 16.33$; true difference is 2.02 SE],
  [Null distribution (10,000)], [SD ≈ 16.4; the 95th percentile of $|"diff"|$ (cell 3.3) is about *32* (31.6–32.5 across runs)],
  [Power, $P(p < 0.05)$], [*0.52* (simulation 0.521–0.527; normal theory 0.524)],
  [Fraction p < 0.05 in 1000 surveys], [5th–95th percentile 0.50–0.55],
  [p = 0 (beyond every null survey)], [about 1.5–2.5% of surveys; plotted at 0.0001],
  [p-value percentiles (10th / 50th / 90th)], [0.0012 / 0.043 / 0.45 (article: 0.0016 / 0.042 / 0.39)],
  [Pairs kept (0.01 ≤ p < 0.05) of 1000], [typically 210–270 (median ≈ 240)],
  [Their replicates with p < 0.05], [*≈ 0.52*: 0.47–0.58 for 90% of runs (30 full notebook runs: 0.41–0.60). Large simulation: 0.525 conditional vs 0.524 overall.],
  [Team A's 35 mg/L], [gives p ≈ 0.03 against this null (36 → 0.028, 34 → 0.037)],
)

#note[*Why one half, and why conditioning does nothing.* A survey is significant when its
difference exceeds about 32 mg/L. Differences are centred on the truth, 33, so just over half land
above 32. A replicate is a fresh draw from the same creek, so the original's p-value cannot change
its chances. The conditional and overall rates agree to within simulation noise. That is the whole
lesson of Part 3, and Q7 asks students to say it.]

#block(breakable: false)[#note[*Goodman's number is not the answer, even though it looks close.* Goodman (1992) assumes the
true effect equals the observed one. Under that assumption a replicate of a p = 0.03 result reaches
p < 0.05 with probability *0.58* (p = 0.05 → 0.50, p = 0.01 → 0.73). That is _observed power_, a
function of p alone. The replicate's real chance is the power at the *true* effect, which p cannot
reveal. The two agree here only by coincidence (p near 0.05, true power near 0.5). Pooling all
400,000 originals by p band shows the difference:
#v(0.2em)
#align(center)[#table(columns: 6, inset: 4pt, stroke: 0.5pt + rgb("#888888"), align: center,
  [original p], [< 0.001], [0.001–0.01], [0.01–0.05], [0.05–0.2], [> 0.2],
  [replicates p < 0.05], [0.527], [0.520], [0.521], [0.522], [0.522],
  [Goodman (avg.)], [0.96], [0.82], [0.62], [0.37], [0.13],
)]
The replicates follow the true power whatever the original p was; Goodman's number follows p. The
Tidy Ecology article reports the same pattern for its grazing design (0.525–0.552 vs 0.95–0.14).
If a student brings up "observed power," this table is the answer.]]

#part-heading([Part 1. The Report], minutes: 3)

#ans[1][Any committed number. Expect 95–97% (reading p as "the chance it was a fluke"), with some
guesses around 70–80%. Write the spread on the board; you come back to it at the close.]

#ans[2][Common answers are "1 − p" and "it was significant, so it's real." Both are fine to commit to.
Don't correct them yet.]

#part-heading([Part 2. Run the Creek], minutes: 6)

#ans[3][Varies. Three runs will often include both a p < 0.05 and a p > 0.05 survey.]

#ans[4][Actual fraction about 0.50–0.55. The smallest p is usually 0 (shown at 0.0001) and the largest is
above 0.99. The p-values span four orders of magnitude for one unchanging creek. _What changed:_
which 24 sites got sampled, so the means, so the difference, so the p.]

#note[The log histogram uses half-decade bins. With a 10,000-survey null, every p-value is a
multiple of 0.0001, and finer bins near $10^(-4)$ show spikes that are only discreteness. The red
0.05 line falls inside the bin from 0.032 to 0.1, so students should read the fraction from the
printed output, not from the bars.]

#part-heading([Part 3. Only the Surveys Like Team A's], minutes: 7)

#ans[5][Most teams circle HIGHER ("those were already significant"). The answer is ABOUT THE SAME.]

#ans[6][Kept about 240 of 1000. Their replicates: about 0.52 (one team may see 0.45 or 0.58). All
replicates: about 0.52. The two fractions differ only by noise.]

#ans[7][Cutoff ≈ 32 mg/L. (a) Observed differences scatter around the true 33, and 33 sits just above
the cutoff, so a bit more than half of surveys clear it. (b) The replicate draws new sites. It
"doesn't know" the original's p, so its chance of clearing 32 is the same as any survey's.]

#warn[If a team leaves the filter as `are.between(..., ...)`, the cell errors, which is fine. If
they type `are.between(0.01, 0.5)`, the conditional fraction is still about 0.52, which accidentally
makes the point. Check that they typed 0.05.]

#part-heading([Part 4. Twenty Surveys, Twenty Intervals], minutes: 4)

The prebuilt cell uses `np.random.seed(120)`. NumPy's legacy seeded stream is stable across versions,
so every team and the hub should draw the same twenty surveys. The p-values come from each team's
own null, so they differ in about the third decimal place. The values below use a 200,000-survey null.
The seed was chosen from 120 candidates to be typical: 9–12 significant, 18–20 intervals
covering 33, and one or two CI/p disagreements, with no p-value within 0.04–0.06 that a team's
null could push across 0.05.

#block(breakable: false)[
#table(
  columns: (1fr, 1fr, 1.6fr, 1fr, 1fr, 1fr, 1.6fr, 1fr),
  inset: 3.5pt, align: center, stroke: 0.5pt + rgb("#888888"),
  [*\#*], [*diff*], [*95% CI*], [*p*], [*\#*], [*diff*], [*95% CI*], [*p*],
  [1], [25.9], [−9.2, 62.2], [0.113], [11], [35.3], [11.0, 59.8], [*0.030*],
  [2], [49.0], [19.8, 77.7], [*0.003*], [12], [62.6], [27.4, 98.4], [*0.0002*],
  [3], [29.4], [−5.6, 67.7], [0.072], [13], [34.2], [6.8, 64.0], [*0.036*],
  [4], [4.7], [−17.1, 26.1], [0.772], [14], [40.9], [10.4, 68.9], [*0.013*],
  [5], [15.7], [−18.4, 45.7], [0.337], [15], [20.2], [−9.3, 48.2], [0.218],
  [6], [46.5], [12.6, 82.1], [*0.005*], [16], [44.6], [13.8, 73.5], [*0.006*],
  [7], [44.3], [17.1, 70.8], [*0.007*], [17], [37.3], [7.7, 68.4], [*0.022*],
  [8], [22.3], [−6.3, 53.0], [0.174], [18], [37.6], [3.3, 66.4], [*0.021*],
  [9], [4.3], [−28.1, 36.2], [0.790], [19], [24.7], [−3.3, 52.9], [0.130],
  [10], [39.3], [9.4, 70.4], [*0.016*], [20], [27.7], [1.7, 54.0], [0.090],
)
]

#ans[8][Contain 33: *19* (survey 4 misses). p < 0.05: *11*. Entirely above 0: *12*. The disagreement
is *survey 20*: its interval [1.7, 54.0] excludes 0, but p ≈ 0.09.]

#ans[9][Survey 3: 29.4 mg/L, [−5.6, 67.7], p ≈ 0.07. Survey 13: 34.2 mg/L, [6.8, 64.0], p ≈ 0.04. The
estimates are 5 mg/L apart, the intervals overlap almost entirely, and both contain the truth. Calling
them opposites is not fair. They found nearly the same thing, and the 0.05 line split them.]

#warn[*Survey 20, and why CIs and p disagree here.* With n = 12, the percentile bootstrap runs
narrow. (The article's Welch t intervals covered the truth in all 20 of its repeats. The difference
here comes from the method, not from bad luck.) Over 4,000 simulated surveys its 95% intervals covered
33 only *92.4%* of the time. Their
median width was 59.8 mg/L, against 64.0 from normal theory with the known SD. They exclude 0 in 57.8%
of surveys, while p < 0.05 occurs in 51.9%, and the two calls disagree in *9.7%* of surveys. So
"interval excludes 0 ⇔ p < 0.05" is only approximate here. The intervals come from resampling
12 values each; the null uses the creek's true SD. Don't present the equivalence as exact. If a
student asks why, this is the reason. It is also a preview of why small-sample bootstrap intervals
deserve caution.]

#note[*Survey 4* (diff 4.7, p = 0.77) is worth ten seconds if there's time. The effect is real, and this
survey's interval still misses 33. Nobody made a mistake; that is what "95%" (here closer to 92%)
allows. A team that ran only survey 4 and wrote "no downstream excess" would have been wrong without
doing anything wrong.]

#part-heading([Close], minutes: 2)

#ans[10][Example: "Our p = 0.03 says a difference this big would be unusual if there were no
downstream excess. It does not give you a 97% chance of agreeing. Your chance is set by how big the
true excess is and how many sites you sample, and our p-value can't tell you that. In the simulated
creek it was about one in two." Push back on "assume the truth equals our 35 mg/L": that is Goodman's
observed power, which only restates p (see the note under Part 1).]

#note[Go back to the Q1 numbers on the board. Ask what 1 − p actually is. It is the chance that a
*no-difference* creek gives a smaller difference than Team A's, which says nothing about Team B.]

== If You Finish Early

#ans[A][About *45* mg/L (44.6–46.1 across runs of 1000), against a truth of 33. About 64% of the
significant surveys report 40 or more. Printing only p < 0.05 inflates published effects (the
"winner's curse"). Surveys with p ≥ 0.05 average about 19 mg/L.]

#ans[B][With truth 60, about 80–110 pairs are kept and about *0.96* of their replicates (and of all
replicates) give p < 0.05. The null distribution describes a creek with *no* difference, so it doesn't
depend on the truth. The same p = 0.03 replicates about 52% of the time in one creek and 96% in
another. "The chance it replicates" has no single answer without knowing the truth.]

== Optional extensions (cut from the main arc)

*More sites (n = 12 → 48).* Change both 12s in `sample_creek` and rebuild the null. Verified: the null
SD falls to 8.1, the cutoff to 15.9 mg/L, and power rises to *0.98*. Replication becomes nearly certain.
That is the "adapt" step that was cut for time.

*How often is there no effect behind it? (false-positive tree).* Imagine many creeks like this one.
In some fraction (the "prior") the excess is really 33 mg/L; in the rest it is 0. Among surveys that
end significant, what share came from a no-effect creek? This creek has power 0.52, a null p < 0.05
rate of 0.050, and a window (0.01 ≤ p < 0.05) rate of 0.245 for the real effect against 0.041 for the null.
#v(0.2em)
#align(center)[#table(columns: 4, inset: 4pt, stroke: 0.5pt + rgb("#888888"), align: center,
  [prior (share real)], [0.10], [0.25], [0.50],
  [false share among p < 0.05], [46%], [22%], [9%],
  [false share among 0.01 ≤ p < 0.05], [60%], [33%], [14%],
)]
The article gets 45/21/8% and 57/31/13% for its design. The window is worse because it excludes the
tiny p-values that real effects produce and nulls rarely do. On the board: 1000 creeks at prior 0.10
gives 100 real × 0.52 = 52 true positives and 900 × 0.05 = 45 false, so 46% of "discoveries" are false.
A 5% cutoff does not mean 5% of significant findings are wrong.

== Appendix: solution code (instructor only)

```
# 2.4 and 3.1: change np.arange(10) to np.arange(1000)

# 3.2
like_team_a = pairs.where('original p', are.between(0.01, 0.05))

# Finish early B: 3.1 with sample_creek(60) in both lines, then 3.2
```
