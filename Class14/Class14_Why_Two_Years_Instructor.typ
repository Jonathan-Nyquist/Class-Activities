#set document(
  title: "Honors Class 14 Instructor Notes: Why Two Years?",
  author: "Elements of Data Science",
  keywords: ("data science", "honors", "trend", "Mann-Kendall", "sign test", "instructor notes"),
)

#set page(
  paper: "us-letter",
  margin: (x: 1in, y: 0.85in),
)

#set par(justify: true, leading: 0.62em, spacing: 0.9em)
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

#let note(body) = block(
  width: 100%,
  fill: rgb("#f7f4ec"),
  inset: 8pt,
  radius: 3pt,
  body,
)

#let warn(body) = block(
  width: 100%,
  fill: rgb("#f7efef"),
  inset: 8pt,
  radius: 3pt,
  body,
)

= Why Two Years?

#align(center)[*Class 14 Instructor Notes* #h(0.5cm) | #h(0.5cm) Quiz 2 day #h(0.5cm) | #h(0.5cm) 12 minutes #h(0.5cm) | #h(0.5cm) Two-page handout, no laptops]

== Placement and purpose

Runs after Lab 7 is submitted and immediately before the Pennypack Creek project. Nothing new
is introduced from scratch --- the segment reinterprets a statistic students already computed,
which is what makes it survivable in the time left after a quiz.

*The one idea:* the statistic students wrote in Lab 7 Part 2 is one slice of Mann-Kendall.
They counted increases minus decreases at a lag of two years; Mann-Kendall adds that same
quantity up at *every* lag. On the handout they discover that the choice of lag decides the
answer, that adding all the lags removes the choice, and that doing so exposes an error their
Lab 7 null simulation was already making.

#note[
*Why it earns the slot before Pennypack.* Mann-Kendall and its Seasonal Kendall extension are
the standard trend tests in water-quality monitoring. Students are about to analyze exactly
the kind of data these tests were built for.
]

== Timing

#table(
  columns: (1.2cm, 1fr),
  stroke: none,
  inset: (x: 3pt, y: 3.5pt),
  [*1 min*], [Hand out, set up, point at the `2`],
  [*3 min*], [Part 1 --- commit, then poll the room],
  [*4 min*], [Part 2 --- teams fill the table; you circulate],
  [*3 min*], [Part 3 --- transitivity, and the two p-values on the board],
  [*1 min*], [Close],
)

== Answer key

#align(center)[
  #table(
    columns: (1.4cm, 2.2cm, 1.8cm, 1.8cm, 1.6cm, 5cm),
    align: (center, center, center, center, center, left),
    inset: 5pt,
    table.header([*Lag*], [*Comps*], [*Inc*], [*Dec*], [*Net*], [*Differences*]),
    [1], [6], [3], [3], [*0*], [#text(size: 8.5pt)[−.1 −.5 +.9 +.7 −.6 +.4]],
    [2], [5], [3], [2], [*1*], [#text(size: 8.5pt)[−.6 +.4 +1.6 +.1 −.2]],
    [3], [4], [4], [0], [*4*], [#text(size: 8.5pt)[+.3 +1.1 +1.0 +.5]],
    [4], [3], [3], [0], [*3*], [#text(size: 8.5pt)[+1.0 +.5 +1.4]],
    [5], [2], [2], [0], [*2*], [#text(size: 8.5pt)[+.4 +.9]],
    [6], [1], [1], [0], [*1*], [#text(size: 8.5pt)[+.8]],
  )
]

*Q6 total: $S = 11$*, out of 21 comparisons. *Q4:* Lab 7's lag found 3 increases out of 5
comparisons, net 1. *Q5:* lag 3 --- every comparison an increase. *Q7:* which lag to use.
*Q8:* year 7 must be warmer than year 3; the comparison is forced, not observed. *Q9:*
the comparisons are not independent, and ignoring that makes you *too confident*.

== 1 min --- Setup

Hand out. Read nothing aloud except: "Look at the `2` in that function. That is the only thing
we are going to talk about today." Then start them on Part 1.

== 3 min --- Part 1: commit, then poll

The handout has a STOP bar after question 2. Enforce it --- the entire segment depends on
students committing to a lag before they see what different lags do.

After about ninety seconds, poll by show of hands: lag 1, lag 2, lag 5, lag 10, bigger. The
spread is the point. Nobody in the room can defend their own number.

=== What to listen for

- *"It doesn't matter, the trend is obvious."* True of the Lab 7 dataset, and worth conceding.
  Ask whether they would have said so *before* running the test, or only after.
- *"Longer lags see more warming."* Correct, and the seed of everything that follows.
- *"Try them all and report the smallest p-value."* #strong[Do not correct this.] Write it on
  the board as *Option A* and leave it there. It is the trap, and the close returns to it.
  It is also handout extension B, so a fast team may write the answer for you.

== 4 min --- Part 2: the table

Circulate. The arithmetic is one-decimal subtraction; teams that get stuck are usually
misreading the lag as "skip $k$ years" rather than "compare to $k$ years earlier."

Two moments to watch for, and let teams reach them on their own:

#note[
*Lag 1 gives net zero.* Not weak evidence --- *no* evidence. A student who wrote "1" in
question 1 would have concluded there is no trend at all.

*Lag 3 and beyond give a perfect score.* Every comparison an increase.

Same seven numbers. This is the whole activity, and it is more persuasive than anything you
could say, because they computed both.
]

When most teams reach question 6, stop them and take the total ($S = 11$) out loud. *Then*
name it: adding the statistic over every lag is the Mann-Kendall statistic (Mann 1945;
Kendall 1975), and it is the standard trend test in water-quality monitoring. Put the
identity on the board:

$ S = sum_(k=1)^(n-1) ["increases" - "decreases at lag" k] = sum_(i < j) "sign" (x_j - x_i) $

Naming it *after* they build it is the point. Do not introduce the name earlier.

== 3 min --- Part 3: the two p-values

Question 8 is fast: if year 3 < year 5 and year 5 < year 7, the third comparison is forced.
It was never free to be a coin flip.

Question 9 is where you spend the time. Put both numbers on the board:

#align(center)[
  #table(
    columns: (7.5cm, 3.2cm),
    align: (left, center),
    inset: 6pt,
    table.header([*How the null distribution was built*], [*p-value for $S = 11$*]),
    [Shuffle the seven years, recompute $S$], [0.068],
    [Flip 21 independent coins, one per comparison], [0.013],
  )
]

Ask what happened at $alpha = 0.05$. The wrong method does not merely shade the answer --- it
*reverses the decision*, on seven numbers they just added up by hand. Then the callback:

#question[
What did your Lab 7 `simulate_under_null` assume about its lag-2 comparisons?
]

The same thing. Independent Increase/Decrease draws, when overlapping lag-2 differences chain
through shared years and country temperatures are correlated with each other besides. Lab 7's
*conclusion* survives because the real signal is enormous. Its *stated confidence* does not.

== 1 min --- Close

Return to Option A on the board.

Mann-Kendall commits to using every lag *before* seeing the data, and pays for that commitment
with a variance formula that accounts for all of them. Option A looks first and then picks the
analysis that produced the answer it liked. Same numbers examined; completely different
epistemic status.

#align(center)[
  #block(inset: 5pt)[*A defensible analysis fixes its choices before it sees the results.*]
]

#note[
*Optional callback* if the Silberzahn multi-analyst study has come up: twenty-nine teams
analyzing one dataset produced odds ratios spanning 0.89 to 2.93. The spread came from
analytic choices across the board --- which is what a room full of students picking different
lags just reproduced in miniature.
]

== Watch for this on extension A

#warn[
Extension A asks how many independent pieces of information sit behind 21 comparisons. The
answer you want is *seven* --- there are only seven numbers, and 21 comparisons cannot carry
more information than the data they were computed from.

A sharp student may instead try to back out an "equivalent number of coin flips" from the
variance. That route gives $"Var"(S) = 7(6)(19)\/18 = 44.3$, which is *larger* than 21, and
they will conclude they somehow have more information than they started with. Head this off:
positive dependence between comparisons makes the total *more* variable, not less. Fewer
independent observations and larger variance are the same fact stated two ways, and the naive
simulation gets both wrong in the same direction.
]

== If it comes up: what Mann-Kendall does not fix

Only if a student raises it --- there is no handout question on this and no time budgeted.

#table(
  columns: (4.4cm, 1fr),
  stroke: none,
  inset: (x: 3pt, y: 4pt),
  [*Arbitrary lag choice*], [Fixed. Mann-Kendall uses all of them.],
  [*Dependence in time*],
  [#strong[Not fixed.] #h(2pt) Transitivity is handled by Kendall's variance formula, but
   serial autocorrelation is not. Warm years follow warm years. Mann-Kendall is
   anti-conservative under positive autocorrelation, which is why hydrologists apply variance
   corrections or prewhitening.],
  [*Only monotone trends*],
  [#strong[Not fixed.] #h(2pt) Against a step change or a cooling-then-warming pattern it does
   poorly. It is not a general trend detector.],
)

And if asked whether Mann-Kendall is simply the best test: no. Against a genuinely linear trend
with well-behaved noise, fitting a slope beats it. Mann-Kendall trades a little power for
robustness to outliers and non-normal data --- the right trade in environmental monitoring,
where one instrument failure can produce an absurd value.

== If the quiz runs long

Cut Part 3 questions 8 and 9 from discussion and simply put the two p-values on the board with
one sentence. Do not cut the close --- it is the only part that generalizes past this statistic.

== If the segment runs short

Expect "seven years is a toy --- does this matter on real records?" It gets worse, not better.
Power against a warming trend, simulated annual series, interannual SD $0.30 degree$C,
permutation null for both, one-sided $alpha = 0.05$:

#align(center)[
  #table(
    columns: (2.6cm, 3.4cm, 2.8cm, 2.8cm),
    align: center,
    inset: 5pt,
    table.header([*Record*], [*Trend*], [*Lag-2 test*], [*Mann-Kendall*]),
    [35 years], [0.009 #sym.degree\C/yr], [0.18], [0.53],
    [80 years], [0.009 #sym.degree\C/yr], [0.18], [1.00],
    [165 years], [0.009 #sym.degree\C/yr], [0.19], [1.00],
  )
]

The lag-2 test barely improves as the record grows from 35 years to 165. A lag-2 comparison
sees two years of signal against two years of noise no matter how long the record is;
lengthening it buys more comparisons, not better ones.

== Instructor reference

The seven-year series on the handout is invented, and labeled as such on the page. It was
chosen so that lag 1 returns exactly zero while lags 3 through 6 return a perfect score --- a
real record of that length rarely separates so cleanly.

p-values from 200,000 shuffles. Power figures from 4,000 replicates per cell with critical
values from 8,000 shuffles; these describe a *single* series, whereas Lab 7 pools across
countries, which raises power but also aggravates the dependence problem, since that dataset
mixes individual countries with continental aggregates.

Sources: Mann, H.B. (1945), _Econometrica_ 13, 245--259; Kendall, M.G. (1975), _Rank
Correlation Methods_, 4th ed.; Hirsch, Slack & Smith (1982), _Water Resources Research_ 18(1),
107--121, for Seasonal Kendall; Hamed & Rao (1998), _Journal of Hydrology_ 204, 182--196, for
the autocorrelation correction.
