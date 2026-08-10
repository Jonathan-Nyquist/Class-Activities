#set document(
  title: "Honors Class 16 Instructor Notes: Compared to What?",
  author: "Elements of Data Science",
  keywords: ("data science", "honors", "normal distribution", "central limit theorem", "standardization", "standard error", "instructor notes"),
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

= Compared to What?

#align(center)[*Class 16 Instructor Notes* #h(0.5cm) | #h(0.5cm) 50 minutes #h(0.5cm) | #h(0.5cm) Four-page handout #h(0.5cm) | #h(0.5cm) Laptops, teams of 2--3]

== Placement and purpose

Runs while the Pennypack mini-project is open but before it is due. It uses the mini-project
data and assumes #emph[no] progress on it --- a student who has not opened the project loses
nothing, and a student who finished Part 5 last night gets an explanation for something they
already saw.

*The one idea:* a z-score is only as good as the distribution you compare against. Part 1
applies the 2-SD rule to a spatial gradient and gets the wrong answer. Part 2 builds the
sampling distribution of the mean. Part 3 standardizes against it. The closing demo
standardizes a test statistic against a null distribution --- the same move, third time.

#note[
*Why it earns the slot.* Students are about to compute means, standard deviations, and
p-values on Pennypack data. Part 3 in particular addresses the mistake they are most likely to
make in the write-up: reporting a standard deviation when the question calls for a standard
error.
]

== Prep

- Data lives in `Class16/data/` --- both CSVs are already there
- Packages: `datascience`, `numpy`, `pandas`, `matplotlib`, `scipy`
- Six fill-in blanks in the skeleton, all one-liners
- `np.random.seed(16)` is set, so the whole room sees identical simulation output

== Timing

#table(
  columns: (1.5cm, 1fr),
  stroke: none,
  inset: (x: 3pt, y: 3.5pt),
  [*5 min*], [Hand out, Q0.1, teams open the skeleton],
  [*20 min*], [Part 1 --- the rule fails, then the fix. Protect this block.],
  [*17 min*], [Part 2 --- CLT and $sigma \/ sqrt(n)$],
  [*8 min*], [Part 3 --- SD vs. SE],
  [*5 min*], [Discussion --- instructor-run demo, D1 and D2],
)

#warn[
*If you are behind:* cut the closing demo and assign D1--D2 as written reflection. The cells
are fully worked in the skeleton. Do #emph[not] cut Part 3 --- it is eight minutes and it is
the concept most likely to show up wrong in the mini-project.
]

== Code blanks

```
z_scores = (cl - cl_mean) / cl_std
z = (values - np.mean(values)) / np.std(values)
downstream_z = group_z(downstream, 'Cl (mg/L)')
sample_sizes = [1, 6, 24]
standard_error = sample_sd / np.sqrt(n)
upper = sample_mean + 1.96 * standard_error
```

== 20 min --- Part 1. The Wrong Outlier

All 39 chloride samples: mean *184.26* mg/L, SD *48.80* mg/L.

#align(center)[
  #table(
    columns: (2.2cm, 1.8cm, 2.6cm, 2cm, 4.4cm),
    align: (center, center, center, center, left),
    inset: 5pt,
    stroke: 0.5pt + rgb("#888888"),
    table.header([*Site*], [*km*], [*Cl (mg/L)*], [*z*], [*Rule says*]),
    [PP1-1], [0.93], [52.77], [−2.69], [flagged --- pristine headwater],
    [PP1-2], [2.18], [80.05], [−2.14], [flagged --- pristine headwater],
    [PP1-9], [7.37], [280.60], [+1.97], [*not* flagged --- the actual spike],
  )
]

The rule flags the two cleanest sites in the creek and misses the largest chloride value in
the dataset. That is the whole activity.

#warn[
Q1.3 asks teams to commit in writing #emph[before] they plot. Do not preview the punchline and
do not let anyone plot early --- the value of 1.5 and 1.6 depends on having a wrong answer on
paper to compare against.
]

=== Running Q1.4 and Q1.5

Teams usually notice the flagged points are all at the top of the creek before they can say
why. Push them to the scatter plot. The line to land:

#note[
The rule assumes every value is a draw from *one* distribution. Chloride here has two regimes
--- a steep climb through the headwaters and a high plateau below the treatment plant. The
overall mean of 184 mg/L describes neither. The headwater samples look unusual only because
they are being compared against 30 downstream samples they have nothing in common with.
]

Say *"the fix is a better comparison group, not a better threshold"* out loud. It is the
transferable idea and it returns in Part 3 and again in D2.

=== After the group standardization

Upstream ($n = 9$, mean 129.9, SD 62.5): *PP1-9 at $z = +2.41$* --- now the only flag, and the
right one. Downstream ($n = 30$, mean 200.6, SD 27.8): PP1-11 (+2.09), PP1-13 (+2.00),
PP4-4 (−2.34).

#note[
These group SDs use `np.std` (population, `ddof=0`), matching `five_num_table` in the
mini-project. Part 3 deliberately switches to `ddof=1` for the standard error, which is why the
downstream SD reads 28.3 there and 27.8 here. Worth one sentence if a sharp team notices.
]

#warn[
The downstream group flags three sites, which is messier than upstream. This is honest rather
than tidy --- PP1-11 and PP1-13 sit immediately below the outfall and are plausibly the plume.
Good discussion if a team raises it; do not raise it yourself unless you are ahead of time.
]

*Q1.8:* PP1-9 is upstream of the outfall, which rules out the treatment plant. Expect road
salt from the adjacent road corridor. Teams that answer "the treatment plant" are reasoning
sensibly but missed the geometry --- ask them which direction water flows.

== 17 min --- Part 2. Many Means

Population: 330 hourly nitrate readings, mean *3.819*, SD *1.997*. Distinctly non-normal ---
broad and flat-topped, because the daily cycle spends little time near the average.

#align(center)[
  #table(
    columns: (2cm, 3.6cm, 3.6cm),
    align: (center, center, center),
    inset: 5pt,
    stroke: 0.5pt + rgb("#888888"),
    table.header([*n*], [*simulated SD*], [$sigma \/ sqrt(n)$]),
    [6], [0.82], [0.815],
    [24], [0.41], [0.408],
    [100], [0.20], [0.200],
  )
]

*Q2.2:* narrows, and becomes bell-shaped. *Q2.3:* a factor of *4* --- the denominator is
$sqrt(n)$. Anyone who writes 2 has guessed; send them back to the formula. *Q2.4:* the central
limit theorem, and they must name it.

#note[
*Extension for teams that finish early.* The logger data rises and falls daily. Ask: if you
could afford only 24 readings, would you take them across one day or spread over two weeks?
Consecutive hours are highly redundant --- the sample mean varies far more than
$sigma \/ sqrt(24)$ predicts because you have far fewer than 24 #emph[independent] pieces of
information. This is worth returning to when they write up the mini-project.
]

== 8 min --- Part 3. How Sure Is the Average?

Downstream chloride: $n = 30$, mean *200.6*, SD *28.3*, SE *5.2*, 95% CI *190 to 211* mg/L.

#note[
*Q3.2:* 28 mg/L is the standard deviation --- how much individual locations differ from each
other. 5 mg/L is the standard error --- how much the average would move if the sampling trip
were repeated. \
*Q3.3:* the average question needs the *standard error* (and the CI built from it). The
individual question needs the *individual measurements* --- neither summary statistic answers
it, and that is the point of offering three choices. Expect teams to reach for the standard
deviation here; it describes spread but never tells you whether any particular site crossed
250. The site above 250 mg/L is *PP1-9 at 280.6*, and it is *upstream* --- no downstream sample
exceeds the standard.
]

That last point is worth eight seconds of emphasis: the confidence interval on the downstream
mean tops out around 211, comfortably under the standard, while a single upstream site blows
past it. Same creek, same day, opposite conclusions depending on which question was asked.

== 5 min --- Discussion (instructor-run demo)

Run this yourself. Students watched the same machinery in Class 15.

Observed nitrate difference (downstream − upstream): *3.131* mg/L. In 20,000 shuffles, *zero*
reach it, so the empirical p-value prints as 0. Null distribution: mean $approx 0$, SD *0.64*.
Standardizing gives *$z = 4.87$* and *$p approx 5.7 times 10^(-7)$*.

#note[
*D1:* a p-value of 0 does not mean the result is impossible under the null --- it means 20,000
shuffles were not enough to land on anything that extreme. The simulation can only report
"smaller than 1 in 20,000," and a million shuffles just moves that floor down. \
*D2:* because the null distribution is normal, standardizing lets you read the probability off
a curve instead of counting, producing a number no simulation could reach. Same move as
Part 1: compare the value against the right distribution.
]

== Two code notes

#warn[
`pp.column()` returns the table's underlying array, not a copy, so `np.random.shuffle` on it
scrambles the nitrate column #emph[inside] `pp`. The demo cell uses `.copy()`. *The same hazard
exists in the mini-project notebook* --- a student who scrolls back and re-runs the earlier
plots after the shuffle cell gets corrupted results with no error message. Worth patching
before the project is due.
]

The mini-project also defines its test statistic as downstream − upstream but simulates
upstream − downstream. The null distribution is symmetric so the p-value is unaffected, but it
confuses careful students and would matter for a smaller effect.
