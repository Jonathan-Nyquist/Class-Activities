#import "preamble.typ": *

#show: body => class-doc(
  title: "Class 21: Clusters on Demand -- Instructor Notes",
  subtitle: "k-means always returns k groups; stability across starting points is evidence, agreement is not",
  team-members: false,
  body
)

== Overview

About 28 minutes nominal, laptops on. Files in `Class21/`: handout `Class21_ClustersOnDemand.typ/.pdf`, skeleton notebook `Class21_ClustersOnDemand_Skeleton.ipynb`, reveal figures `fig_reveal_*.png`. In `data/`: `faithful.csv` (Data 8 copy, 272 rows), `noise.csv` (272 rows, `make_noise.py`, seed 21), `kmeans_helper.py` (the function pasted into the notebook), `make_figures.py`.

*Placement:* before Lab 10. First unsupervised method. Uses distance in standard units informally; Lab 10 formalizes distance for kNN. Old Faithful is the Lab 8 dataset.

*Arc:* predict the groups by eye -- k-means agrees -- predict what happens on structureless data -- k-means splits it anyway -- change the seed: Old Faithful doesn't move, the noise does -- ask for k = 3 and get it -- what counts as evidence?

*What it does not claim:* it does not teach how to choose k, does not test whether clusters are statistically real, and does not explain why Old Faithful has two eruption types. Seed stability is one piece of evidence, not a test: a dataset can give stable but meaningless clusters (for example, one long stretched cloud split at its middle).

== Timing

#table(
  columns: (auto, auto, 1fr),
  stroke: 0.4pt + gray,
  inset: 6pt,
  [*Step*], [*Min*], [*Content*],
  [Setup], [3], [Read the k-means box aloud; flag the kNN vs. k-means note],
  [Q1], [3], [Predict by eye, on paper, before any code],
  [Q2], [4], [Load data, run k = 2, seed 0],
  [Q3], [2], [Commit to a prediction for the noise -- poll the room],
  [Q4], [7], [Adapt the cell for noise; rerun both with seed 2; fill table],
  [Q5], [4], [k = 3 with seeds 0 and 6. *Cut first if short on time*],
  [Q6], [5], [Discussion],
)

== Key numbers (verified in `ds313`, datascience 0.18.1; same in 0.17.6)

#table(
  columns: (1.4fr, auto, auto, 1.6fr),
  stroke: 0.4pt + gray,
  inset: 6pt,
  [*Run*], [*seed*], [*sizes*], [*what the split looks like*],
  [Old Faithful, k = 2], [0], [98, 174], [short (1.6--3.4 min) vs. long (3.1--5.1 min)],
  [Old Faithful, k = 2], [2], [98, 174], [identical rows; cluster *numbers* swap],
  [Random points, k = 2], [0], [135, 137], [roughly vertical: split on eruptions near 3.2--3.5],
  [Random points, k = 2], [2], [131, 141], [horizontal: split on waiting, means 83 vs. 59],
  [Old Faithful, k = 3], [0], [79, 96, 97], [short intact; long split by waiting],
  [Old Faithful, k = 3], [6], [40, 62, 170], [long intact; short split in two],
)

Old Faithful k = 2 gave the same 98 / 174 split for all 20 seeds tried (0--19), and raw minutes instead of standard units give nearly the same split (100 / 172). Random points (k = 2) alternate between the vertical and horizontal splits across seeds. Old Faithful k = 3 lands on at least five different answers in seeds 0--19.

== Q1--Q2

Nearly everyone sees two groups: short eruptions with short waits, long eruptions with long waits. k-means agrees: 98 short, 174 long. The point to name: agreement with your eye is reassuring but is not evidence the groups are real -- Q3 shows why.

#align(center)[#image("fig_reveal_faithful_k2.png", width: 82%)]

== Q3--Q4 -- the noise

Key: *(c)*, two clusters of about equal size (135 / 137). Common wrong answers are (a) "it'll say there are no groups" and (b). There is no step in the algorithm that can refuse: every point must join a center.

The table is the payoff. Old Faithful: same sizes, same boundary (diagonal gap). Random points: the boundary flips from vertical to horizontal and the sizes change. *Only the noise depended on the seed.* A real gap pulls every starting point to the same answer; with no gap, the answer depends on where you started.

#align(center)[#image("fig_reveal_noise_k2.png", width: 82%)]

Students may notice the Old Faithful cluster numbers swap (0 = long at seed 0, 0 = short at seed 2). Cluster numbers are arbitrary names, not rankings -- that's why the table asks for sizes.

== Q5 -- k = 3 (cut first)

No complaint; three groups every time. Seed 0 splits the long-eruption cloud; seed 6 splits the short one. The short-eruption cluster of 97--98 shows up in most runs; the third group moves around. Believe the two-way split; treat the third as unsupported.

#align(center)[#image("fig_reveal_faithful_k3.png", width: 82%)]

#note[Seeds 0 and 6 are not equally good. k-means minimizes total squared distance to centers (standard units): 56.3 for seed 0 vs. 64.3 for seed 6. Seed 6 is a stuck answer the algorithm can't improve by Steps A and B. Real software runs many starts and keeps the best -- but "best of many" still always returns k groups.]

== Q6 -- discussion

Look for any two of:
- *A visible gap* -- empty space between groups, not a cut through a continuous cloud.
- *Stability* -- the same groups from different starting points (Q4).
- *Replication* -- the same groups in new data (next month's eruptions).
- *An outside explanation* -- a mechanism or variable not used in the clustering that predicts the groups.
- *A large drop in spread.* Total squared distance in standard units is 544 before clustering. k = 2 cuts it to 79.6 for Old Faithful (85% removed) but only to 324 for the noise (40% removed). Honors aside only; not on the handout.

Tie-back: same flavor as "compared to what?" -- a result only means something next to what you'd get with no real structure.
