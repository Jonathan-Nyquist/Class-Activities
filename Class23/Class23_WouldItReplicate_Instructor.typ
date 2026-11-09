#set document(title: "Honors Class 23 Instructor Notes: Would It Replicate?", author: "Elements of Data Science")
#set page(paper: "us-letter", margin: (x: 1in, y: 1in))
#set par(justify: true, leading: 0.65em)
#set heading(numbering: none)
#set text(font: "Liberation Serif", size: 11pt, lang: "en", region: "us")

#show raw.where(block: true): it => block(
  fill: rgb("#f2f2f2"), inset: 8pt, radius: 3pt, width: 100%, breakable: false,
  text(font: "Liberation Mono", size: 9.5pt, it),
)
#show raw.where(block: false): it => text(font: "Liberation Mono", size: 9.5pt, it)
#show table: set par(justify: false)
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

= Class 23: Would It Replicate? — Instructor Notes

#align(center)[#text(style: "italic")[After Class 19 (confidence intervals) · one 75-min class · handout + skeleton notebook + slides · no data files]]

#v(0.2cm)

*The idea.* Three claims about p-values, all in one simulated creek whose truth students know.
(1) A significant result does not predict a significant repeat: Team A's p = 0.03 replicates
about half the time, and the original p makes no difference. (2) A significant result isn't
necessarily real: how often "p < 0.05" comes from a creek with no excess depends on the number of
sites and on how many creeks really have one. (3) A significant result isn't necessarily big:
20,000 logger readings per side make a 2 mg/L excess overwhelmingly significant.

*What students produce.* Committed predictions; a measured replication rate (overall and
conditional on 0.01 ≤ p < 0.05); one point on a class power curve; a whole-count table of true and
false discoveries; CI/p counts for twenty surveys; a judgment of whether a significant excess is
worth acting on, against a threshold they committed to in Part 1.
*What this does not claim to teach:* power formulas, sample-size planning, Cohen's d, Bayesian
replication probabilities, false-discovery-rate procedures, or anything about real Pennypack
chloride. The world is simulated, and the handout and notebook both say so.

*New material:* the word "power," defined in plain terms (the fraction of repeated surveys that
catch a real difference). The null distribution is built from the known creek SD rather than by
shuffling. This is legitimate only because we built the world; with real data you shuffle
(Class 15), and the notebook says so.

*Materials.* Handout, skeleton notebook, slide deck (Part 3 reveal, Part 5 recap, Part 7). The
board needs a 4-column table for Part 4 (sites per side 6 / 12 / 24 / 48).

*Source.* Tidy Ecology, "What a p-value tells you, and what it does not" (28 Sept 2026,
tidyecology.com/posts/what-a-p-value-tells-you). It uses a fenced/grazed seedling experiment with
12 plots per side and power ≈ 0.53. This activity keeps that arc with these changes: a chloride creek;
a simulated null on the difference in means instead of the Welch t-test; percentile bootstrap CIs
(Class 19) instead of t intervals; a class-built power curve; and a large-n segment the article does
not have. Further reading: Goodman (1992), _Statistics in Medicine_ 11(7):875–879; Cumming (2008),
_Perspectives on Psychological Science_ 3(4):286–300.

== Timing (75 min firm)

#table(
  columns: (1fr, 1.3cm, 3fr),
  inset: 5pt, stroke: 0.5pt + rgb("#888888"),
  [*Segment*], [*Min*], [*What happens*],
  [Part 1], [4], [Read Team A's report; Q1 individually, then compare; Q2; Q3 (commit a threshold). Stop bar. Collect a few Q1 numbers on the board.],
  [Part 2], [5], [2.1–2.2 run; 2.3 a few times; loop at 10, Q4 prediction, 1000; log histogram.],
  [Part 3], [7], [Pairs at 10 then 1000; Q5 prediction; fill the filter; Q6; cutoff; Q7. Replication slide.],
  [Part 4], [12], [Assign sites per side; 4.1–4.2; Q8 prediction; 4.3 at 10 then 1000; teams post to the board; Q9.],
  [Part 5], [7], [Q10 table from board numbers; Q11; recap slide.],
  [Part 6], [5], [Run the prebuilt cell; Q12 and its follow-up.],
  [Part 7], [7], [Three slides, a prediction before each; Q13.],
  [Close], [3], [Q14 out loud; return to the board numbers from Q1.],
)
That is 50 planned minutes against 75. Your class runs long, so plan on using the slack.

#warn[Never cut Part 3; it carries the answer to Q1. If short on time, cut in this order: Part 6
(show the twenty-survey plot on screen for one minute instead), then Q9 (fold it into the board
discussion), then Part 5 becomes the recap slide only.]

#note[*Class 15 overlap.* Class 15 Part 3 showed p-values under no effect (about 5% significant) and
a power ≈ 0.5 world (Q3.4: "what would you change?"). Part 2 here is a deliberate callback with a log
axis. Part 4 answers Class 15's Q3.4 by actually changing the number of sites.]

== The simulated creek and the numbers

Upstream mean 150 mg/L, downstream 183 mg/L (true difference 33), SD 40 at every site, 12 sites per
side unless Part 4 changes it. Statistic: downstream mean − upstream mean, two-sided (`np.abs`, as
in Class 15). All numbers below were run in ds313 (Python 3.13.11, datascience 0.18.1, NumPy 2.4.1):
the filled notebook at every sites value, plus vectorized checks with 200,000–400,000 simulated
surveys. Scripts and logs are in `_scratch/`.

#table(
  columns: (2.3fr, 3fr),
  inset: 5pt, stroke: 0.5pt + rgb("#888888"),
  [Standard error of the difference], [$40 sqrt(2 slash 12) = 16.33$; true difference is 2.02 SE],
  [Null distribution (10,000)], [SD 16.1–16.6; the 95th percentile of $|"diff"|$ (cell 3.3) is about *32* (31.3–32.7 across runs)],
  [Power, $P(p < 0.05)$], [*0.52* (0.524 in 400,000 surveys; one team's 1000 surveys: 0.50–0.55)],
  [p-value percentiles (10th / 50th / 90th)], [0.0009 / 0.043 / 0.45 (article: 0.0016 / 0.042 / 0.39)],
  [Pairs kept (0.01 ≤ p < 0.05) of 1000], [median 236 (5th–95th: 207–263)],
  [Their replicates with p < 0.05], [*≈ 0.52*: 0.47–0.57 for 90% of team runs. Large simulation: flat at 0.52 in every original-p band],
  [Team A's 35 mg/L], [gives p ≈ 0.03 against this null (34 → 0.037, 35 → 0.032, 36 → 0.027)],
  [Notebook run time], [Each null build (10,000 surveys) 0.1 s locally; every 1000-survey loop under 1 s. Hub not yet timed.],
)

#note[*Why one half, and why conditioning does nothing.* A survey is significant when its
difference exceeds about 32 mg/L. Differences are centred on the truth, 33, so just over half land
above 32. A replicate is a fresh draw from the same creek, so the original's p-value cannot change
its chances. That is the whole lesson of Part 3, and Q7 asks students to say it.]

#block(breakable: false)[#note[*Goodman's number is not the answer, even though it looks close.* Goodman (1992) assumes the
true effect equals the observed one. Under that assumption a replicate of a p = 0.03 result reaches
p < 0.05 with probability *0.59* (p = 0.05 → 0.50, p = 0.01 → 0.73). That is _observed power_, a
function of p alone. The replicate's real chance is the power at the *true* effect, which p cannot
reveal. The two agree here only by coincidence (p near 0.05, true power near 0.5). Pooling 200,000
originals by p band:
#v(0.2em)
#align(center)[#table(columns: 6, inset: 4pt, stroke: 0.5pt + rgb("#888888"), align: center,
  [original p], [< 0.001], [0.001–0.01], [0.01–0.05], [0.05–0.2], [> 0.2],
  [replicates p < 0.05], [0.519], [0.526], [0.524], [0.528], [0.527],
  [Goodman (avg.)], [0.96], [0.82], [0.62], [0.38], [0.14],
)]
If a student brings up "observed power," this table is the answer.]]

#part-heading([Part 1. The Report], minutes: 4)

#ans[1][Any committed number. Expect 95–97% (reading p as "the chance it was a fluke"), with some
guesses around 70–80%. Write the spread on the board; you come back to it at the close.]

#ans[2][Common answers are "1 − p" and "it was significant, so it's real." Both are fine to commit to.
Don't correct them yet.]

#ans[3][Any number with a reason. There is no right answer. Insist that every student writes one
before the notebook opens; Part 7 depends on it. Note the class's smallest value for later.]

#part-heading([Part 2. Run the Creek], minutes: 5)

#ans[4][Actual fraction about 0.50–0.55. The smallest p is usually 0 (shown at 0.0001) and the largest
is above 0.98. The p-values span four orders of magnitude for one unchanging creek. _What changed:_
which 24 sites got sampled, so the means, so the difference, so the p.]

#note[The log histogram uses half-decade bins. With a 10,000-survey null, every p-value is a
multiple of 0.0001. The red 0.05 line falls inside the bin from 0.032 to 0.1, so students should
read the fraction from the printed output, not from the bars.]

#part-heading([Part 3. Only the Surveys Like Team A's], minutes: 7)

#ans[5][Most teams circle HIGHER ("those were already significant"). The answer is ABOUT THE SAME.]

#ans[6][Kept about 236 of 1000. Their replicates: about 0.52 (one team may see 0.47 or 0.57). All
replicates: about 0.52. The two fractions differ only by noise.]

#ans[7][Cutoff ≈ 32 mg/L. (a) Observed differences scatter around the true 33, and 33 sits just above
the cutoff, so a bit more than half of surveys clear it. (b) The replicate draws new sites. It
"doesn't know" the original's p, so its chance of clearing 32 is the same as any survey's.]

#warn[If a team leaves the filter as `are.between(..., ...)`, the cell errors, which is fine. If
they type `are.between(0.01, 0.5)`, the conditional fraction is still about 0.52, which accidentally
makes the point. Check that they typed 0.05.]

*Slide: replication.* Repeat rate by original-p band (the table above, without the Goodman row).
Ask for a show of hands on Q5 before revealing it.

#part-heading([Part 4. More Sites], minutes: 12)

Assign one sites-per-side value to each team: *6, 12, 24, 48*. The 12-site team reproduces
Part 2 with a fresh null, which is a useful check on the others. Name the real-creek fraction
"power" once teams post it.

#ans[8][Verified values (one team's 1000 surveys falls in the range shown 90% of the time):
#v(0.2em)
#align(center)[#table(columns: 5, inset: 4pt, stroke: 0.5pt + rgb("#888888"), align: center,
  [sites per side], [6], [12], [24], [48],
  [cutoff (mg/L)], [45.4], [31.9], [22.6], [16.0],
  [real creek: p < 0.05], [0.30 (0.27–0.33)], [0.53 (0.50–0.55)], [0.82 (0.79–0.84)], [0.98 (0.97–0.99)],
  [no-excess creek: p < 0.05], [0.050 (0.04–0.06)], [0.051 (0.04–0.06)], [0.050 (0.04–0.06)], [0.050 (0.04–0.06)],
)]
Full notebook runs gave real/no-excess fractions of 0.273/0.056 (6), 0.497/0.064 (12),
0.809/0.039 (24), and 0.981/0.045 (48).]

#ans[9][The real-creek row climbs from about 0.3 to nearly 1; the no-excess row stays near 0.05.
More sites narrow the null, so the cutoff drops (45 → 16 mg/L). The true 33 doesn't move, so it
clears a lower bar more often. A no-excess creek's differences shrink by the same factor as the
cutoff, so 5% of them still clear it: the cutoff _is_ the 95th percentile of that creek's surveys.]

#note[If a student asks why not always use 48 sites: cost. Every site is a sample, a trip and a lab
analysis. Choosing the number of sites before going out is what "power" is used for in practice.
This activity does not teach the calculation.]

#part-heading([Part 5. How Many Discoveries Are False?], minutes: 7)

#ans[10][Using the verified powers (students' board numbers will differ slightly):
#v(0.2em)
#align(center)[#table(columns: 3, inset: 4pt, stroke: 0.5pt + rgb("#888888"), align: (left, center, center),
  [], [6 sites], [48 sites],
  [real creeks with p < 0.05], [30], [98],
  [no-excess creeks with p < 0.05], [45], [45],
  [total with p < 0.05], [75], [143],
  [share with no real excess], [*60%*], [*31%*],
)]]

#ans[11][No. The 5% is the false-alarm rate _among no-excess creeks_. Among significant results,
60% (6 sites) or 31% (48 sites) came from no-excess creeks. Few sites makes it worse because real
creeks rarely reach significance. The other lever is how common real excesses are: if half the creeks
had one, the false share would be about 14% (6 sites) or 5% (48 sites). Even perfect power leaves
about 31% false when only 1 in 10 creeks has a real excess.]

#note[In the article's terms the 100-of-1000 is the "prior." Students don't need the word. The
48-site column is the surprise: power alone can't fix a low base rate. Large-simulation check (12
sites): 46.4% false at 10% real, 22.4% at 25%, 8.8% at 50%.]

*Slide: recap.* The two columns as a stacked bar (real hits vs false alarms), 6 vs 48 sites.

#part-heading([Part 6. Twenty Surveys, Twenty Intervals], minutes: 3)

The prebuilt cell uses `np.random.seed(120)`. The twenty surveys reproduce exactly in ds313
(NumPy 2.4.1) as in the original draft environment (NumPy 1.26.3). The p-values come from each
team's own null, so they differ in about the third decimal place. Values below use a
200,000-survey null.

#block(breakable: false)[
#table(
  columns: (1fr, 1fr, 1.6fr, 1fr, 1fr, 1fr, 1.6fr, 1fr),
  inset: 3.5pt, align: center, stroke: 0.5pt + rgb("#888888"),
  [*\#*], [*diff*], [*95% CI*], [*p*], [*\#*], [*diff*], [*95% CI*], [*p*],
  [1], [25.9], [−9.2, 62.2], [0.112], [11], [35.3], [11.0, 59.8], [*0.030*],
  [2], [49.0], [19.8, 77.7], [*0.003*], [12], [62.6], [27.4, 98.4], [*0.0001*],
  [3], [29.4], [−5.6, 67.7], [0.072], [13], [34.2], [6.8, 64.0], [*0.036*],
  [4], [4.7], [−17.1, 26.1], [0.774], [14], [40.9], [10.4, 68.9], [*0.012*],
  [5], [15.7], [−18.4, 45.7], [0.338], [15], [20.2], [−9.3, 48.2], [0.217],
  [6], [46.5], [12.6, 82.1], [*0.004*], [16], [44.6], [13.8, 73.5], [*0.006*],
  [7], [44.3], [17.1, 70.8], [*0.007*], [17], [37.3], [7.7, 68.4], [*0.022*],
  [8], [22.3], [−6.3, 53.0], [0.174], [18], [37.6], [3.3, 66.4], [*0.021*],
  [9], [4.3], [−28.1, 36.2], [0.791], [19], [24.7], [−3.3, 52.9], [0.130],
  [10], [39.3], [9.4, 70.4], [*0.016*], [20], [27.7], [1.7, 54.0], [0.089],
)
]

#ans[12][Contain 33: *19* (survey 4 misses). p < 0.05: *11*. Entirely above 0: *12*. The disagreement
is *survey 20*: its interval [1.7, 54.0] excludes 0, but p ≈ 0.09.

_Follow-up:_ survey 20's difference, 27.7 mg/L, is below the 32 mg/L cutoff, so the test calls it
not significant. The test's cutoff comes from the creek's true SD and is the same for every survey.
The interval sees only survey 20's 24 sites, which happened to be less spread out than the creek
(sample SDs 30.6 upstream and 37.0 downstream, against a true 40). So its half-width is only about
26 mg/L, and the interval just clears 0. Accept any answer that names the two different sources of
spread: the model's true SD versus this sample's own spread.]

#warn[*Survey 20, and why CIs and p disagree here.* With n = 12 the percentile bootstrap runs
narrow. Over 4,000 simulated surveys its 95% intervals covered 33 only *92.1%* of the time; median
width 60.0 mg/L against 64.0 from normal theory with the known SD. Intervals exclude 0 in 57.9% of
surveys while p < 0.05 occurs in 53.7%, and the two calls disagree in *9.3%*. So "interval excludes
0 ⇔ p < 0.05" is only approximate here; don't present it as exact.

If a student asks whether a permutation test (Class 15) would fix this: no. A permutation p-value
paired with the same bootstrap intervals still disagreed in *8.9%* of 3,000 surveys (10.9% for the
known-SD null in the same run). The test spreads under "no excess" by pooling both sides; the interval
resamples each side around the observed difference. They answer different questions, so they
disagree near the cutoff (`_scratch/verify_perm_vs_boot.py`).]

#note[*Can students use a CI instead of a permutation test?* Approximately: "0 outside the 95%
bootstrap interval ⇒ the means differ at about the 5% level." Inferential Thinking presents this method,
and the interval also gives the size of the difference. The approximation is poor with small samples.
In this creek (SD 40), with *no* real difference, the CI rule raised a false alarm in 11.2% of surveys at
6 sites per side, 8.0% at 12, 6.2% at 24 and 6.6% at 48 (4,000 surveys each). The permutation test stayed
at 5.0–5.9%. With a true difference of 2 standard errors at every size, the two verdicts disagreed in
17% of surveys at 6 sites, 8.5% at 12, 4.8% at 24 and 3.7% at 48 (2,000 each), nearly always in the
direction "interval says different, test doesn't." The cause is the percentile bootstrap: a small
sample understates its population's spread, so the interval runs narrow. Survey 20 is that case.
The textbook's duality is still correct: "reject if x is outside the 95% CI" is exact by construction, and
it rejects a true null 5% of the time whenever the interval really covers 95%; the percentile bootstrap
only approximately does. A bias-corrected (BCa) interval does not fix this, because these data have no
bias or skew to correct (11.4% false alarms at 6 sites, 7.0% at 12), whereas a bootstrap-t or Welch t
interval accounts for the uncertain spread and holds about 5% at every size
(`_scratch/verify_ci_methods.log`).
Guidance for students: with roughly 20 or more per group, testing with the interval is fine and more
informative; with fewer, use the permutation test for the yes/no question and read the interval as a
somewhat-too-narrow estimate of size. Either way, a borderline result is reported as borderline. Scripts:
`_scratch/verify_perm_vs_boot_byN.log`, `_scratch/verify_ci_false_alarm.log`.]

#part-heading([Part 7. A Very Big Survey (slides)], minutes: 7)

Same SD (40 mg/L); true excess *2 mg/L* (0.05 SD); 20,000 readings per side. Figures are in
the `fig_B*.png` files and come from `_scratch/partB_figures.py`. Show B1, take the Q13(a) vote; show B2, take
(b); show B3, have students copy the interval and compare it with their Q3 number.

#table(
  columns: (2.3fr, 3fr),
  inset: 5pt, stroke: 0.5pt + rgb("#888888"),
  [Observed difference], [2.01 mg/L (0.050 SD)],
  [Null (10,000 surveys)], [SD 0.40 mg/L; largest |difference| 1.52 mg/L],
  [p-value], [*p < 0.0001*: none of the 10,000 null surveys was as extreme (normal theory z = 5.0)],
  [95% bootstrap CI], [*1.25 to 2.78 mg/L* (the figure label rounds to 1.3 to 2.8)],
  [How typical], [This design gives p < 0.05 in 99.9% of surveys and p < 0.001 in 97%],
)

#ans[13][(a) Most say NO or CAN'T TELL; the histograms are visually identical. (b) TINY. (c) 1.3 to
2.8 mg/L. Unless someone committed to a threshold under about 3 mg/L in Q3, the excess is real and
not worth acting on. "Significant" answers _is it zero?_, not _is it big?_]

#warn[*Disclose the seed if asked.* Seed 1905 was chosen from 60 candidates so the observed
difference (2.01) sits near the truth; a random seed would also give a tiny p almost every time.
*Logger caveat:* real logger readings are autocorrelated, so 20,000 readings carry far less
information than 20,000 independent sites. Treating them as independent overstates certainty. The
simulation draws them independently; say so if a student who knows loggers objects.]

#part-heading([Close], minutes: 3)

#ans[14][Example: "Our p = 0.03 says a difference this big would be unusual if there were no
downstream excess. It doesn't give you a 97% chance of agreeing: your chance is set by the true excess
and your number of sites, and our p-value can't tell you either. It also doesn't say how big the
excess is. For that, look at our interval." Push back on "assume the truth equals our 35 mg/L": that
is Goodman's observed power, which only restates p.]

#note[Go back to the Q1 numbers on the board. Ask what 1 − p actually is. It is the chance that a
*no-difference* creek gives a smaller difference than Team A's, which says nothing about Team B.]

== If You Finish Early

#ans[A][About *45* mg/L (45.2 in a full notebook run; 45.4 in 400,000 surveys), against the
true 33. About 64% of the significant surveys report 40 or more; non-significant surveys average about
19 mg/L. Printing only p < 0.05 inflates published effects (the "winner's curse").]

== Appendix: solution code (instructor only)

```
# 2.4, 3.1, 4.3: change np.arange(10) to np.arange(1000)

# 3.2
like_team_a = pairs.where('original p', are.between(0.01, 0.05))

# 4.1
sites = 6    # or 12, 24, 48 as assigned
```
