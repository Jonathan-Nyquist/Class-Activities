#import "preamble.typ": *

#show: body => class-doc(
  title: "Class 20: The Registrar's Report -- Instructor Notes",
  subtitle: "Survivorship bias in graduation statistics",
  team-members: false,
  body
)

== Overview

30 minutes, quiz day. Files in `Class20/`, data = `registrar_report.csv` (63 rows, graduates
only) and `full_cohort.csv` (100 rows, the entire entering cohort). Both generated from the
same synthetic-cohort logic (seed 42): 60% graduate / 20% drop out / 20% still enrolled at the
6-year tracking window, with graduation times skewed around 4 years.

*Placement:* immediately follows the lecture's WWII bomber example (Abraham Wald, survivorship
bias). Nothing new is introduced from scratch -- the activity is a second, close-to-home
instance of the same fallacy, worked through with a dataset instead of a story.

*Arc:* naive graduates-only average looks reassuring -- commit to a prediction -- reveal the
37 students the average silently dropped -- a hand-built Kaplan-Meier curve shows the honest
picture, including the part that's still unknown -- close by mapping both cases onto the same
table.

== Timing

#table(
  columns: (auto, auto, 1fr),
  stroke: 0.4pt + gray,
  inset: 6pt,
  [*Part*], [*Min*], [*Content*],
  [1], [5], [Registrar's report (graduates only) -- commit to a prediction on paper],
  [2], [12], [Reveal full cohort -- breakdown, bar chart, honest completion rate],
  [3], [10], [Instructor-led Kaplan-Meier curve -- the plateau, the shifted median],
  [4], [3], [Paper mapping back to the bomber example],
)

== Part 1 -- Key numbers

#note[Registrar's report, 63 graduates: mean 4.31 years, median 4.00 years. Verified in the
real `ds313` environment, not just a sandbox -- exact match on both runs.]

Enforce a real commit before anyone runs the naive-stat cell. The number by itself is not
dramatic -- 4.31 years sounds perfectly ordinary -- which is exactly the point: nothing about
it *looks* wrong. Poll a few predictions out loud before moving on; the spread (some students
will say "accurate," some "too optimistic") sets up Part 2.

== Part 2 -- Key numbers

#table(
  columns: (auto, auto, auto),
  stroke: 0.4pt + gray,
  inset: 6pt,
  [*Status*], [*Count*], [*% of cohort*],
  [Graduate], [63], [63%],
  [Drop out], [19], [19%],
  [Still enrolled], [18], [18%],
)

Honest completion rate = 63.0% exactly. The naive average was computed from just under
two-thirds of the entering cohort, with no indication in the number itself that a third is
missing.

#note[If a team asks why "still enrolled" isn't just "will graduate eventually, ignore it" --
that's the right question and the bridge into Part 3. We don't know yet. Some of them will
graduate late, some never will, and today's snapshot can't tell the difference.]

== Part 3 -- Key numbers (Kaplan-Meier)

#table(
  columns: (auto, auto),
  stroke: 0.4pt + gray,
  inset: 6pt,
  [*Year*], [*% not yet graduated*],
  [0.0], [100.0%],
  [3.5], [96.4%],
  [4.0], [50.6%],
  [4.5], [39.2%],
  [5.0], [30.4%],
  [5.5], [24.0%],
  [6.0], [22.8%],
)

The 50%-graduated point falls at *year 4.5* -- half a year later than the naive graduates-only
mean of 4.31. Direction matters for the debrief: the naive number isn't just incomplete, it's
also a little too optimistic, because it's silently built from the students who succeeded
fastest and never has to answer for the ones still working on it.

#note[The notebook now plots censoring explicitly, matching the lifelines-style convention
from your original prototype: 37 tick marks (`|`) on the curve, one per dropout or
still-enrolled student, placed at their own tracked year and the survival level in effect at
that point. All 18 still-enrolled students land on the same point (year 6, 22.8%) since they
share a censoring time -- worth pointing out that the stacked tick is real, not a rendering
glitch. The notebook also prints the 19/18 dropout/still-enrolled split right before the plot.]

*Q3.1 target answer:* 22.8% of the entering cohort has still not graduated at year 6, and no
-- this is not recoverable from the graduates-only report, which by construction only ever
contains people who already crossed the finish line.

*Q3.2 target answer:* the naive average is biased *low* (too fast/optimistic) relative to the
honest curve, because it's an average over survivors of the process, computed at the moment
they succeeded -- structurally similar to why the returning bombers only show survivable
damage.

#warn[Simplification worth naming if a sharp student pushes on it: this treats drop-out and
still-enrolled identically as "censored." That's a simplification -- drop-out is closer to a
permanent competing outcome than to temporary censoring -- but distinguishing them properly is
more machinery than 30 minutes affords. One sentence of honesty is enough; don't let it eat
the clock.]

== Part 4 -- Answer key

#table(
  columns: (4.4cm, 1fr),
  stroke: 0.4pt + gray,
  inset: 6pt,
  [*What we can see*],
  [The 63 students who graduated, and how long each took.],
  [*What's missing from the data*],
  [The 19 dropouts and 18 still-enrolled -- 37 students entirely absent from the report.],
  [*The naive conclusion*],
  ["Students graduate in about 4.3 years" -- with the 100% completion rate this implies never
   stated, and never checked.],
  [*Why it's wrong*],
  [The missing 37 aren't a random subset -- struggling is correlated with dropping out or
   taking longer, so excluding them doesn't just shrink the sample, it tilts it toward the
   easy cases. Same shape as the bombers: the missing cases are missing *for a reason connected
   to the very thing being measured*.],
)

*Q4.2, pocket examples if a team is stuck:* startup-founder success books (built from
companies that survived); published research (file-drawer problem -- failed studies don't get
written up); long-term-smoker health surveys (early deaths aren't in the "long-term" sample);
investment fund track records (funds that failed quietly close and vanish from the dataset).
If the Silberzahn/replication-crisis thread has come up before, publication bias is the
cleanest callback.

== Open items

- *Font fallback* -- same Liberation Serif issue as Classes 16--19. Unresolved; left
  unchanged so this handout matches the rest of the series.
- *`preamble.typ` is still the reconstruction*, not your real preamble -- same open item
  carried from every class since 16. Paste yours over it before compiling for real.
- *Data files are new, not reused* -- `registrar_report.csv` and `full_cohort.csv` were
  generated fresh for this class (seed 42) and verified end-to-end in `ds313`: CSV generation,
  every notebook cell (with blanks filled), and the Kaplan-Meier function all ran without
  error, and the printed numbers match this document exactly.
- *Notebook code deliberately kept simple.* `kaplan_meier` uses `np.unique` instead of
  `sorted(set(...))`, builds arrays with `make_array`/`np.append` (the same pattern used for
  bootstrap loops in Class 19) instead of Python lists, returns a single `Table` instead of a
  tuple to unpack, and every loop is written with `np.arange` indexing instead of `zip`. More
  lines than the terse version, on purpose -- nothing here should require a Python idiom
  students haven't already seen in a lab.
