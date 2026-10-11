#import "preamble.typ": *

#show: body => class-doc(
  title: "Pull the Line -- Instructor Notes",
  subtitle: "Leverage, influence, and the points that move a regression line",
  team-members: false,
  body
)

== Overview

Draft, class number not yet assigned. Runs after least-squares regression has been taught.
Students play a browser game and record every commitment and result on the paper handout
(`PullTheLine.pdf`, 5 pages). Part 5 is a skeleton notebook (`PullTheLine_Skeleton.ipynb`,
with `data/cricket_thermometer.csv` and `data/plant_dataset_1.csv` to `_3.csv`) that reproduces
the game's numbers and runs the probe on every point.

*Game:* `https://jonathan-nyquist.github.io/EDS_Artifacts/pull-the-line/`. Adding `#r2` or
`#r3` to the URL opens that round directly, so any round can be skipped. Reloading the page
clears a student's answers; there is no data collection.

*Data:* Rounds 1--2 use the 15-point cricket dataset from Classes 18--19
(`cricket_thermometer.csv`, points numbered in file order). Round 3 uses three synthetic
datasets (seed 2026, the first three draws, not hand-picked), built by `verify_round3b_shift20.py`.
Every number below was produced by the scripts in `LeverageGame/` run in `ds313`, and the game
reproduces them.

*Arc:* fit by eye and compare with least squares -- commit to the one point that will tilt the
line most, discover it is the point farthest from mean x (leverage) -- hunt a planted point
using leave-one-out probes, discover that a far-out bad point hides in the residual plot and
that a far-out real point can move the line without being wrong (influence is not error) --
close on when deleting a point is justified.

== Learning objectives

Students should be able to:
+ Explain that a point's leverage depends only on how far its x-value is from mean x.
+ Explain why an influential point can have a small residual: it pulls the line toward itself.
+ Distinguish leverage (potential), influence (actual slope change), and being off the trend
  (miss from the line fit without the point), using leave-one-out refits.
+ Argue that "influential" is not by itself a reason to delete a data point.

*Not taught:* the leverage formula $h_i$, Cook's distance, studentized residuals, or any formal
outlier test. The "miss from the line fit without it" is a leave-one-out (deleted) residual,
but the handout never uses that term. Don't introduce it unless a student asks.

== Timing

#table(
  columns: (auto, auto, 1fr),
  stroke: 0.4pt + gray,
  inset: 6pt,
  [*Part*], [*Min*], [*Content*],
  [Setup], [3], [Open the game, teams of two, one handout per team],
  [1], [6], [Fit by eye -- commit, lock, SD-line discussion],
  [2], [7], [Tilt the line -- commit to a point, reveal, explore],
  [3], [12], [Find the plant -- three datasets with two probes each, then Q3.1--Q3.3],
  [4], [7], [Would you delete it? -- discussion],
  [5], [35], [Notebook: move-one-point loop, leave-one-out loop, all three game datasets],
)

That totals 70 minutes. The split reflects how this class works: point-and-click parts go fast,
coding is where students bog down. The time is weighted toward Part 5, and its three loops are
the likeliest place to run over. If time runs short, cut Part 5C first. 5A and 5B carry the method.
If a team is stuck on the 5B loop, point them to `leave_one_out(t)` in 5C, which contains the
same loop, and have them run it on `crickets`. If Part 4's discussion works better as the last
word, run it after Part 5.

#pagebreak()
== Part 1 -- Fit by eye

#table(
  columns: (auto, auto),
  stroke: 0.4pt + gray,
  inset: 6pt,
  [Least-squares slope / intercept], [3.291 °F per chirp/sec, 25.23 °F],
  [Correlation $r$], [0.835],
  [SD line slope (SD#sub[temp] / SD#sub[chirps])], [3.941],
  [Least-squares SSE (the score's denominator)], [190.55],
)

*Score* = student's SSE / 190.55. Only 1.00 exactly is perfect, and nothing can score lower.
The handles start flat at mean temperature, so a student who never touches them scores badly.

#warn[Q1.1 asks for a steeper/shallower prediction. It is tempting to tell students that people
systematically fit lines too steep, closer to the SD line (Mosteller et al., 1981). That claim
has *not* been verified for these notes. Present Q1.3 as a question about the class's own lines,
not as a known result, until the citation is checked.]

*Q1.3 key.* Least squares slope = $r times$ SD-line slope: 0.835 #sym.times 3.941 = 3.291. The
SD line runs along the long axis of the cloud and treats chirps and temperature symmetrically.
Least squares answers a one-way question -- predict temperature from chirps -- and because
$|r| < 1$ its predictions are pulled toward the mean temperature. A student whose eye-fitted line
lands near 3.94 has drawn the trend of the cloud, not the best prediction line. That is the
regression effect, and worth naming if the class's lines are visibly steep. Take a quick show
of hands: "closer to 3.29 or to 3.94?"

== Part 2 -- Tilt the line

#warn[The game's reveal names the best point. Check that each team has written its Q2.1 choice
and reason before anyone clicks *Move my point*.]

Moving point $i$ up by 10 °F changes the slope by exactly
$10 (x_i - overline(x)) slash (n dot "SD"_x^2)$, with $overline(x) = 16.653$ and
$n dot "SD"_x^2 = 40.54$. This was checked against a direct refit for all 15 points, with
agreement to $10^(-15)$. Moving a point up steepens the line if it is right of mean x and
flattens it if it is left. The residual never enters the formula.

#table(
  columns: (auto, auto, auto, auto, auto, auto, auto, auto),
  stroke: 0.4pt + gray,
  inset: 5pt,
  align: center,
  [*Rank*], [*Point*], [*x*], [*Slope change*], [*Rank*], [*Point*], [*x*], [*Slope change*],
  [1], [1], [20.0], [+0.825], [9], [2], [16.0], [−0.161],
  [2], [3], [19.8], [+0.776], [9], [13], [16.0], [−0.161],
  [3], [15], [14.4], [−0.556], [11], [12], [17.2], [+0.135],
  [4], [7], [14.7], [−0.482], [12], [10], [16.2], [−0.112],
  [5], [4], [18.4], [+0.431], [13], [5], [17.1], [+0.110],
  [6], [11], [15.0], [−0.408], [13], [8], [17.1], [+0.110],
  [7], [9], [15.4], [−0.309], [15], [14], [17.0], [+0.085],
  [8], [6], [15.5], [−0.284], [], [], [], [],
)

Ties (points 2 and 13, points 5 and 8) share a rank in the game.

*Q2.3 key.* Point 9 has the largest residual (−6.52 °F) but ranks only 7th. The top four points
are the four farthest from 16.65 chirps/sec, two on each side. Watch for teams choosing
point 9 (biggest residual) or point 3 (highest temperature) -- a guess, not yet observed. Ask anyone who chose
point 9 why. Their answer is the misconception this round exists to break.

#note[The leverage note at the end of Part 2 is a definition, not a discovery. Have students
read it aloud *after* Q2.3, not before.]

== Part 3 -- Find the plant

Each dataset has 13 ordinary points, one point near mean x, and one isolated point at 21--22
chirps/sec. Either the far point (Datasets 1 and 3) or the near-center point (Dataset 2) was
moved 20 °F. Because there is always a far point, "always accuse the far one" does not work.

#table(
  columns: (auto, auto, auto, auto, auto, auto),
  stroke: 0.4pt + gray,
  inset: 5pt,
  align: (left, center, center, center, center, center),
  [*Dataset*], [*Plant (x)*], [*Moved*], [*Plant's residual rank*], [*Slope before*], [*Slope after*],
  [1], [21.5 (far)], [up], [2nd], [3.804], [6.170],
  [2], [16.7 (near)], [down], [1st], [4.339], [4.635],
  [3], [21.2 (far)], [up], [2nd], [3.519], [5.558],
)

*Probe values students should copy* (slope change, miss without it):

#table(
  columns: (auto, auto, auto, auto),
  stroke: 0.4pt + gray,
  inset: 5pt,
  align: (left, left, center, center),
  [*Dataset*], [*Point*], [*Slope change*], [*Miss without it (°F)*],
  [1], [x = 21.5, the plant], [+1.93], [+16.3],
  [1], [x = 18.3, the largest residual], [−0.26], [−8.0],
  [2], [x = 16.7, the plant], [+0.32], [−21.4],
  [2], [x = 21.5, real data], [−0.96], [−7.3],
  [3], [x = 21.2, the plant], [+1.25], [+12.2],
  [3], [x = 16.5, the largest residual], [−0.12], [+7.8],
)

*The intended strategy* is to probe the far point and the largest-residual point, then accuse
whichever misses its refit line by more. Across 2,000 simulated datasets of each kind:

#table(
  columns: (auto, auto, auto),
  stroke: 0.4pt + gray,
  inset: 5pt,
  [*Approach*], [*Far plant*], [*Near plant*],
  [Accuse the largest residual], [41.7%], [100%],
  [Two-probe strategy, 20 °F shift (used)], [97.8%], [99.5%],
  [Two-probe strategy, 15 °F shift], [88.4%], [94.4%],
)

The 20 °F shift was chosen so the evidence nearly always resolves. The cost is that the plant
is often visible by eye in the scatterplot. That is why the handout requires the probe table:
grade the evidence and the reasoning, not just "Correct? Yes."

#warn[The method is not infallible. For an innocent far point, the miss without it has a median
of 3.9 °F, but its 95th percentile is 11.5 °F. A point far from the others is predicted poorly
when left out, because the refit line is extrapolating. If a student asks why the far point's
miss is "large-ish" even when it is innocent, that is the reason, and it is a good question.]

*Q3.1 key.* In Dataset 2, the real far point changed the slope three times as much as the
plant (−0.96 vs +0.32), but missed the line fit without it by far less (7.3 vs 21.4 °F).
Moving the line a lot shows leverage plus some influence. It is not evidence of an error.

#block(breakable: false)[
*Q3.2 key.*
#table(
  columns: (auto, auto, auto),
  stroke: 0.4pt + gray,
  inset: 5pt,
  [], [*Slope change*], [*Miss without it*],
  [Moved point, far from center], [big], [big],
  [Moved point, near center], [small], [big],
  [Real point, far from center], [can be big (Dataset 2: −0.96)], [small],
)
]
Accept "small or medium" for the third row's slope change. The point is that it can be big.

*Q3.3 key.* A residual is measured from a line the point helped fit. A far-out point has
enough leverage to drag the line toward itself, shrinking its own residual: 6.8 °F for the
Dataset 1 plant, against 16.3 °F once it is removed. Removing the point lets the other 14 set the
line, so its distance from that line is an honest measure of how off-trend it is.

#note[Callbacks, if time allows. Class 17's Cars 2 had the leverage while Onward had the bigger
residual (−18.0 vs +10.8). This round is the diagnostic that Class 17 promised. Class 16's
2-SD rule failed for the same structural reason: the reference statistics included the
contamination they were meant to detect.]

== Part 4 -- Would you delete it?

*Q4.1 key (discussion).* A strong answer:
- checks the sample's record (field notes, lab QA, units, transcription);
- asks whether the site differs in kind from the others (a new input, different land use) -- if
  it does, it is a different population, not an error;
- refits with and without the point and reports both.

A good reason to remove a point is a documented error, or the point falling outside the scope
of the question being asked. "It is influential" or "it changes my slope" is not a reason.
Removing it for that reason is choosing the answer after seeing the data, which ties back to
fixing analysis choices before looking at results.

#warn[Q4.1 is a hypothetical. Don't present it as a real Pennypack sample or attach real numbers
to it unless they are pulled from the course data and verified first.]

== Part 5 -- Leave one out (notebook)

Executed end to end in `ds313`. The Class 19 copy of `cricket_thermometer.csv` (rounded values,
`chirps_per_sec` / `temp_f` headers) reproduces every game number to the displayed precision.
The toolbox functions are copied from Class 19 (`slope_of(t)`, `intercept_of(t)` on a table).
Student blanks: the 3-row test loop, the 15-row loop, the leave-one-out loop, and Datasets 2--3.

*Q5.1 key.* +0.825, matching the game.

*Q5.2 key.* A perfectly straight line through zero at mean x = 16.65 chirps/sec, slope
$10 slash (n dot "SD"_x^2) = 0.247$ per chirp/sec. Points right of the mean steepen the line,
points left of it flatten it, and the farther out, the bigger the effect. That is leverage.

*Q5.3 key.* No clear pattern. Point 9 (residual −6.52) has slope change −0.309, smaller than
several points with small residuals.

#block(breakable: false)[
*Q5.4 key.*
#table(
  columns: (auto, auto, auto, auto),
  stroke: 0.4pt + gray,
  inset: 5pt,
  align: center,
  [*Point*], [*Residual*], [*Miss without it*], [*Miss ÷ residual*],
  [1], [−2.45], [−3.73], [1.52],
  [3], [+2.90], [+4.21], [1.45],
  [9], [−6.52], [−7.28], [1.12],
)
]
Points 1 and 3 are the two farthest from mean x, so they had pulled the line hardest toward
themselves. Point 9 is near the middle and barely changes.

#note[Not for students unless asked: miss ÷ residual is exactly $1 slash (1 - h_i)$, where
$h_i = 1 slash n + (x_i - overline(x))^2 slash (n dot "SD"_x^2)$ is the leverage. For point 1,
$h = 0.067 + 0.276 = 0.343$, giving $1 slash 0.657 = 1.52$.]

#warn[The leave-one-out slope change is not the same quantity as Part 2's "move up 10 °F" slope
change. Point 1 moved up gives +0.825; point 1 removed gives −0.308. In the real cricket data the
most influential single point is point 3 (+0.327), just ahead of point 1. Students who compare
the two columns may be confused. The first asks "what could this point do?"; the second asks "what
is this point doing?"]

*Q5.5 key.*
#table(
  columns: (auto, auto, auto, auto),
  stroke: 0.4pt + gray,
  inset: 5pt,
  align: center,
  [*Dataset*], [*Biggest miss*], [*Biggest slope change*], [*Plant*],
  [1], [21.5 (+16.3)], [21.5 (+1.93)], [21.5],
  [2], [16.7 (−21.4)], [21.5 (−0.96)], [16.7],
  [3], [21.2 (+12.2)], [21.2 (+1.25)], [21.2],
)
They disagree in Dataset 2. The miss found the plant. The biggest slope change belongs to the real
far point. Left-out slope change is exactly (distance from mean x) #sym.times (miss) / $(n dot "SD"_x^2)$
-- for point 1 of the crickets, $3.347 times (-3.734) slash 40.54 = -0.308$ -- so it rewards
distance from the center as much as being off the trend. It measures influence, not error. The near-center plant is badly off the trend but has too little leverage to move the
slope.
