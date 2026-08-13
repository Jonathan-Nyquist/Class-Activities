#import "preamble.typ": *

#show: body => class-doc(
  title: "Class 19: The Confidence Game -- Instructor Notes",
  subtitle: "Bootstrap CI for a mean, and for a regression slope",
  team-members: false,
  body
)

== Overview

50 minutes. Files in `Class19/`, data = `weight-height.csv` (Part 1, your real file -- 10,000 rows, Gender/Height/Weight, height in *inches*) and `cricket_thermometer.csv` (Part 2, same 15-row Pierce dataset as Class 18 -- verified to reproduce Class 18's numbers exactly).

#note[`weight-height.csv` is the classic Kaggle Gender/Height/Weight set: 5,000 Male + 5,000 Female rows, height in inches (not cm -- the original warm-up notebook's print label said "cm"; corrected here). `population.select("Height")` pools both genders, so the population is mildly bimodal (Male mean 69.03 in, SD 2.86; Female mean 63.71 in, SD 2.70). This doesn't break anything -- the bootstrap CI for a mean doesn't require a normal population -- and the n=10/n=500 histograms below come out visibly unimodal regardless. Worth having the fact in your pocket in case a sharp student asks why the population itself isn't bell-shaped.]

*Arc:* replicate-vs-resample on a die roll (why bootstrap works at all) -- worked height-mean example -- predict-first before scaling n=10 to n=500 -- callback to Class 18's cricket slope -- predict-first before bootstrapping that slope -- spaghetti-plot visualization -- adapt to the intercept, which turns out to be a second, unplanned lesson about extrapolation -- discussion of when the method breaks.

== Timing

#table(
  columns: (auto, auto, 1fr),
  stroke: 0.4pt + gray,
  inset: 6pt,
  [*Part*], [*Min*], [*Content*],
  [1], [15], [Die-roll bootstrap (concept) -> height mean, n=10 -> predict -> n=500],
  [2], [20], [Cricket slope bootstrap (worked) -> spaghetti plot -> adapt to intercept],
  [3], [3], [Bridge to Lab 09],
  [4], [10], [Paper discussion -- assumptions and limits],
  [Total], [48], [2 min buffer],
)

== Part 1 -- Key numbers (verified against your real data)

#note[Die-roll bootstrap validates the method itself: the replicate-many-times CI and the resample-from-one-sample CI should land close to each other. In one test run: replication CI [3.020, 3.980], bootstrap CI [2.740, 3.760] -- close, as expected (both runs are random, so exact bounds will shift each time; the point is the two methods agreeing, not the specific numbers). This is worth saying out loud to students: *we're not doing anything magical, we're just checking that resampling-from-one-sample gives approximately the same answer as actually replicating the experiment* -- which is the entire justification for trusting the bootstrap later, when replication isn't possible.]

Population mean height (both genders pooled): 66.37 in. One test draw:

#table(
  columns: (auto, auto, auto),
  stroke: 0.4pt + gray,
  inset: 6pt,
  [*n*], [*95% CI*], [*Width*],
  [10], [63.93 -- 67.69], [3.77],
  [500], [65.99 -- 66.65], [0.66],
)

Ratio of widths ~5.7x for a 50x increase in n. Theory says $sqrt(50) approx 7.07$; a single random draw of the n=10 sample won't hit that exactly (this is itself worth naming if a student computes a different ratio than a neighboring team -- everyone drew a different random n=10 sample). Point for discussion (Q1.5): CI width scales with $1/sqrt(n)$, not $1/n$ -- quadrupling precision costs 16x the data, not 4x.

#note[Because this cell re-randomizes every run, exact bounds will differ slightly each time you or a student executes the notebook -- including between your instructor run and what students see live. That's expected and itself worth a sentence: the *CI* is a range estimate, not a single fixed number, so a small amount of run-to-run jitter in *where exactly* it lands is the method working correctly, not a bug.]

== Part 2 -- Key numbers (verified against the real Class 18 dataset)

#note[The cricket data reproduces Class 18's stats exactly: mean temp 80.04°F, slope 3.2911, intercept 25.2323, r = 0.8351, $r^2$ = 0.6975. This is the same `cricket_thermometer.csv` -- no new data file needed if it's already sitting in your repo from Class 18.]

#table(
  columns: (auto, auto, auto),
  stroke: 0.4pt + gray,
  inset: 6pt,
  [*Quantity*], [*Point estimate*], [*95% bootstrap CI*],
  [Slope], [3.2911], [2.27 -- 4.54],
  [Intercept], [25.2323], [3.7 -- 43.5],
)

#warn[The intercept's CI is *enormous* relative to its point estimate -- almost an order of magnitude wider, proportionally, than the slope's. This is not a bug. The intercept is the predicted temperature at 0 chirps/sec, far outside the observed range of 14.4--20 chirps/sec, so resampling amplifies its uncertainty the same way Class 18's negative-R² extrapolation did. If a team gets a wildly wide intercept CI and asks whether they made a mistake, the answer is no -- that width *is* the finding. Worth flagging explicitly in Q2.4 debrief, and a clean callback to "predictions get shakier the further you extrapolate" from last week.]

*Does the slope CI include 0?* No -- comfortably clears it (2.27 is well above 0), consistent with r = 0.835. This is worth connecting explicitly to hypothesis testing: a CI that excludes 0 is equivalent to rejecting the null of "no relationship" at the 5% level. Some students will make this connection unprompted; if not, it's a good thing to surface in the Q2.2 debrief.

== Part 4 -- Discussion guidance

*Q4.1 (assumptions).* Target answer: the sample needs to be reasonably representative / randomly drawn from the population of interest. A bad-case example for crickets: all 15 measured from the same colony on the same night (temperature range too narrow, pseudo-replication). For height: sampling only one gender, or one age group, would make the "sample stands in for the population" assumption fail even though the code runs fine and produces a confident-looking interval.

*Q4.2 (200 vs. 10,000 reps).* This is the Lab 7 lag-2 callback from Class 14, restated: a narrower interval isn't automatically a better one if it came from fewer resamples -- with only 200 reps, percentile estimates are noisier, and a "tighter" result is as likely to be bad luck as it is to be a better estimate. More reps reduces *simulation* noise around a fixed answer; it does not fix *sampling* noise from having only 15 crickets to begin with. Those are two different sources of uncertainty and it's easy for students to conflate them -- worth drawing that distinction explicitly if it doesn't come up.

*Q4.3 (n=15 vs n=500 resample composition).* With n=15, a single resample easily omits an influential point (e.g., the 93.3°F / 19.8 chirps observation) or triples it up, visibly shifting the fitted line -- that's exactly what the spaghetti plot in Part 2 shows. With n=500, no single point has enough leverage to move the line much regardless of how many times it's resampled. This is the mechanical reason small-n bootstrap CIs are wide and lumpy while large-n ones are narrow and smooth.

== Open items

- *Font fallback* -- same Liberation Serif issue noted for Classes 16--18. Unresolved; left unchanged.
- *`preamble.typ` is a reconstruction*, not your real preamble -- paste yours over it before compiling for real.
- *`weight-height.csv` is now your real file* -- verified above (10,000 rows, inches, mixed gender). No further action needed.
- *Cricket_Thermometer.ipynb item closed* -- its content (bootstrap CI for slope, seaborn-style visualization) is now folded into this class via the spaghetti plot in Part 2; no separate notebook needed.
