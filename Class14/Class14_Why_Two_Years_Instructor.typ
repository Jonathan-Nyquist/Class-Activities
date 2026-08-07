#set document(
  title: "Honors ClassNN Instructor Notes: Why Two Years?",
  author: "Elements of Data Science",
  keywords: ("data science", "honors", "trend", "Mann-Kendall", "sign test", "instructor notes"),
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
  #block(above: 12pt, below: 6pt, it.body)
]
#show heading.where(level: 3): it => [
  #set text(size: 11pt, weight: "bold", style: "italic")
  #block(above: 10pt, below: 4pt, it.body)
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

#let note(body) = block(
  width: 100%,
  fill: rgb("#f7f4ec"),
  inset: 8pt,
  radius: 3pt,
  body,
)

= Why Two Years?

#align(center)[*Instructor Discussion Notes* #h(0.6cm) | #h(0.6cm) Quiz 2 day #h(0.6cm) | #h(0.6cm) 12 minutes #h(0.6cm) | #h(0.6cm) No handout, no laptops]

== Placement and purpose

Runs after students have submitted Lab 7 and immediately before the Pennypack Creek
project. Nothing new is introduced from scratch --- the whole segment reinterprets a
statistic students have already computed. That makes it survivable in the ten to fifteen
minutes left after a quiz.

*The one idea:* the test statistic students wrote in Lab 7 Part 2 is one slice of
Mann-Kendall. They computed increases minus decreases at a lag of two years. Mann-Kendall
adds up that same quantity at *every* lag. Students discover that the "2" was never
justified, that removing it costs them nothing, and that summing over all lags creates a
brand-new trap that Lab 7's null simulation was already falling into.

#note[
*Why it earns the slot before Pennypack.* Mann-Kendall and its Seasonal Kendall
extension are the standard trend tests in water-quality monitoring. Students are about to
analyze exactly the kind of data these tests were built for. This is the handoff.
]

== Timing

#table(
  columns: (1.2cm, 1fr),
  stroke: none,
  inset: (x: 3pt, y: 4pt),
  [*2 min*], [Setup: recall the Lab 7 statistic],
  [*3 min*], [Question 1 --- commit before reveal],
  [*2 min*], [The reveal: it's one slice of a famous test],
  [*3 min*], [Question 2 --- the transitivity trap],
  [*2 min*], [Question 3 --- what is still broken],
)

== Setup (2 min)

Put the Lab 7 statistic on the board without comment:

```
def changes(array, years = 2):
    "Increases minus decreases after two years."
```

Remind them what they concluded: far more increases than decreases across all countries
and years, a p-value indistinguishable from zero, null rejected, planet warming. Then say
only this: "I want to look at one character in that function."

Circle the `2`.

== Question 1 --- Commit before reveal (3 min)

#question[
Why two years? Write down on a scrap of paper: (a) the lag *you* would have chosen, and
(b) whether you think the conclusion would change if we had used it.
]

Insist on the writing. Ten seconds of silence is enough. Then poll by show of hands:
lag 1, lag 2, lag 5, lag 10, something bigger. The spread is the point --- there is no
consensus, and no one in the room can defend their own number.

=== What to listen for

- *"It doesn't matter, the trend is obvious."* True here, and worth conceding. Ask
  whether they would have said that before running the test, or only after.
- *"Longer lags see more warming."* Correct and the seed of everything that follows.
  Write it on the board.
- *"Just try them all and report the one with the smallest p-value."* #strong[Do not
  correct this.] Write it on the board as Option A. It is the trap, and you will come
  back to it in the close.

== The reveal (2 min)

You do not have to choose a lag. Add up the statistic at every lag:

$ S = sum_(k=1)^(n-1) [ "increases" - "decreases at lag" k ] = sum_(i < j) "sign" (x_j - x_i) $

The right-hand form says: compare every year to every other year and count which
direction each pair points. That is the Mann-Kendall statistic (Mann 1945; Kendall 1975).

Give them the payoff table. Simulated annual series, interannual SD $0.30 degree$C,
permutation null for both tests, $alpha = 0.05$:

#table(
  columns: (2.6cm, 3.4cm, 2.8cm, 2.8cm),
  align: (center, center, center, center),
  inset: 6pt,
  table.header([*Record*], [*Trend*], [*Lag-2 test*], [*Mann-Kendall*]),
  [35 years], [0.009 #sym.degree\C/yr], [0.18], [0.53],
  [80 years], [0.009 #sym.degree\C/yr], [0.18], [1.00],
  [165 years], [0.009 #sym.degree\C/yr], [0.19], [1.00],
  [35 years], [0.020 #sym.degree\C/yr], [0.33], [0.98],
  [165 years], [0.020 #sym.degree\C/yr], [0.52], [1.00],
)

Let them sit with the left column. *The lag-2 test barely improves as the record grows
from 35 years to 165 years.* A lag-2 comparison sees two years of signal against a full
two years of noise no matter how long the record is; lengthening the record buys more
comparisons, not better ones. Mann-Kendall's distant pairs see a century of signal
against the same noise.

== Question 2 --- The transitivity trap (3 min)

This is the heart of the segment. Set it up as a straightforward extension.

#question[
Mann-Kendall uses every pair of years, so for 165 years that's 13,530 comparisons instead
of about 163. To build the null distribution, can we simulate 13,530 independent coin
flips?
]

Most of the room will say yes. Let them. Then ask for three years' temperatures where
$x_1 < x_2$ and $x_2 < x_3$, and ask what the third comparison must be.

The comparisons are not free. Transitivity forces them. Treating them as independent coin
flips understates the variance badly:

#table(
  columns: (2cm, 3.2cm, 3.2cm, 2.6cm),
  align: (center, center, center, center),
  inset: 6pt,
  table.header([*n*], [*Coin-flip Var*], [*True Var*], [*Understated*]),
  [35], [595], [4,958], [8.3#sym.times],
  [165], [13,530], [503,617], [37#sym.times],
)

The true variance is $n(n-1)(2n+5) \/ 18$, which Kendall worked out. The naive figure is
$n(n-1) \/ 2$.

=== The callback that makes this land

#question[
Look back at your Lab 7 simulation. What did `simulate_under_null` assume about the
lag-2 comparisons?
]

It sampled independent Increase/Decrease draws --- the same error, at a smaller lag and
therefore a smaller magnitude, but the same error. Overlapping lag-2 differences chain
through shared years, and country temperatures are spatially correlated on top of that.
Lab 7's conclusion survives because the signal is enormous. Its stated confidence does
not.

== Question 3 --- What Mann-Kendall does not fix (2 min)

#question[
We've fixed the arbitrary lag. Is the test now correct?
]

Draw the distinction explicitly, because students will otherwise merge these into one
vague sense that "the old test was bad":

#table(
  columns: (4.6cm, 1fr),
  stroke: none,
  inset: (x: 3pt, y: 5pt),
  [*Arbitrary lag choice*], [Fixed. Mann-Kendall uses all of them.],
  [*Dependence between observations*],
  [#strong[Not fixed.] #h(2pt) Transitivity is handled by Kendall's variance formula, but serial
   autocorrelation in the temperature series is not. Warm years follow warm years.
   Mann-Kendall is anti-conservative under positive autocorrelation, which is why
   hydrologists apply variance corrections or prewhitening.],
  [*Only monotone trends*],
  [#strong[Not fixed.] #h(2pt) Against a step change or a cooling-then-warming pattern,
   Mann-Kendall does poorly. It is not a general trend detector.],
)

If a strong student asks whether Mann-Kendall is simply the best test: no. Against a
genuinely linear trend with well-behaved noise, fitting a slope beats it. Mann-Kendall
trades a little power for robustness to outliers and to non-normal data --- which is
exactly the trade you want in environmental monitoring, where a single instrument failure
can produce an absurd value.

== Close (1 min)

Return to Option A on the board --- "try every lag and report the smallest p-value."

That is not a variant of Mann-Kendall. Mann-Kendall commits to using all lags *before*
seeing the data and pays for it with a variance formula that accounts for all of them.
Option A looks at the data first and then selects the analysis that produced the answer
it liked. Same set of numbers examined; completely different epistemic status.

The one-sentence version to leave on the board:

#align(center)[
  #block(inset: 6pt)[
    *A defensible analysis fixes its choices before it sees the results.*
  ]
]

#note[
*Optional callback* if the Silberzahn multi-analyst study has already come up: twenty-nine
teams analyzing one dataset produced odds ratios spanning 0.89 to 2.93. The spread came
from analytic choices across the board --- which is what a room full of students choosing
different lags just simulated in miniature.
]

== If the segment runs short

Ask what "trend" would even mean for a series that rises, falls, and rises again to the
same height. Mann-Kendall would report nothing. Whether that is a failure of the test or a
failure of the question is a genuinely open discussion and can absorb five minutes.

== If the quiz runs long

Cut Question 3. Setup, Question 1, the reveal, and Question 2 stand on their own in about
eight minutes. Do not cut the close --- it is the only part that generalizes beyond this
one statistic.

== Instructor reference

Power figures come from simulation: 4,000 replicates per cell, permutation-based critical
values from 8,000 shuffles, one-sided at $alpha = 0.05$, Gaussian noise with
SD $0.30 degree$C. These describe a *single* series; Lab 7 pools across countries, which
raises power but also aggravates the dependence problem, since the dataset mixes
individual countries with continental aggregates.

Sources if students want them: Mann, H.B. (1945), _Econometrica_ 13, 245--259;
Kendall, M.G. (1975), _Rank Correlation Methods_, 4th ed.; Hirsch, Slack & Smith (1982),
_Water Resources Research_ 18(1), 107--121, for the Seasonal Kendall test used in water
quality work; Hamed & Rao (1998), _Journal of Hydrology_ 204, 182--196, for the
autocorrelation correction.
