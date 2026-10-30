#import "preamble.typ": *

#show: body => class-doc(
  title: "Class 20: Who Got In -- Instructor Notes",
  subtitle: "Survivorship bias as selection: a filter can manufacture a correlation",
  team-members: false,
  body
)

== Overview

About 9 minutes nominal, quiz day, paper only (no laptops). Files in `Class20/`: handout `Class20_WhoGotIn.typ/.pdf`, reveal slides `fig_reveal_A.png` and `fig_reveal_B.png`, data and generator in `data/` (`applicants.csv`, 400 rows; `make_admissions.py`, seed 2026, `ds313`).

*Placement:* follows the lecture's Wald bomber example. Wald's planes show missing cases distorting a *summary*; this activity shows missing cases creating a *relationship* that does not exist in the full population. It reuses Class 17--18 ideas (scatter plots, r, standard units) and introduces nothing new.

*Arc:* draw the admission cutoff -- predict r among admits -- reveal a negative r -- diagnose the dean's false trade-off -- (optional) contrast with a one-variable cutoff -- apply it to themselves.

*What it does not claim:* it does not estimate how distorted real admissions data are, does not teach correction methods, and does not take a position on test-optional admissions. Admission here is a mechanical index; real honors admission is holistic. Nothing on the handout describes this program's actual process.

== Timing

#table(
  columns: (auto, auto, 1fr),
  stroke: 0.4pt + gray,
  inset: 6pt,
  [*Step*], [*Min*], [*Content*],
  [Setup], [1], [Read the two paragraphs aloud; point out r = +0.41 and the stars],
  [Q1], [2], [Draw and shade the cutoff],
  [Q2], [1], [Commit to a prediction -- poll the room before revealing],
  [Reveal A], [1], [Project `fig_reveal_A.png`],
  [Q3], [2], [Diagnose the dean's conclusion],
  [Q4 + Reveal B], [1], [*Cut first if short on time*],
  [Q5], [1], [Closing prompt; take two or three answers aloud],
)

== Key numbers (verified in `ds313`, seed 2026)

#table(
  columns: (1fr, auto, auto),
  stroke: 0.4pt + gray,
  inset: 6pt,
  [*Group*], [*n*], [*r (GPA, SAT)*],
  [All applicants], [400], [+0.41],
  [Program A: top 30% on combined index], [120], [−0.29],
  [Program B: top 30% on GPA alone (cutoff GPA ≥ 3.48)], [123], [+0.13],
)

Program B has 123 admits rather than 120 because of ties at the 3.48 cutoff. Pool summary: GPA mean 3.31, SD 0.31 (7 values capped at 4.00); SAT mean 1158, SD 152. Stars are at (3.00, 1458) and (4.00, 962). r is computed with the course's `standard_units` / `correlation` definitions.

#note[For a bivariate-normal pool with ρ = 0.4, the *expected* values are about −0.24 (index cutoff, top 30%) and +0.22 (GPA-only cutoff). This sample's −0.29 and +0.13 differ by ordinary sampling variation with n ≈ 120. Use the sample values in class; the expected values are only a sanity check. The sign flip requires a fairly selective cutoff: admitting the top 50% gives an expected r of only about −0.08.]

== Q1 -- the cutoff

Admitted region is *above and to the right* of the line. It slopes down because the rule is compensatory: a lower GPA can be offset by a higher SAT, and vice versa. Every point on the line has the same combined score.

== Q2 -- the prediction

Key: *weakly negative* (r = −0.29). Accept "strongly negative" if the explanation shows the mechanism; the sign is the point.

Common wrong answers: "about +0.41 -- it's just a subset" and "stronger -- admitted students are good at both." Poll the room before showing Reveal A. The mechanism, in one sentence: among admits, anyone low on one variable *must* be high on the other to clear the line, so the admitted cloud is a band tilted along the cutoff.

#align(center)[#image("fig_reveal_A.png", width: 62%)]

== Q3 -- the dean

The trade-off is created by the selection rule, not by students. In the full pool, GPA and SAT are positively related. The dean never sees the applicants who were low on both, which is exactly the region that would have shown the positive relationship. Tie back to Wald: the evidence that would correct the conclusion is in the cases that didn't make it into the data.

== Q4 -- one-variable cutoff (cut first)

Positive but weaker (+0.13 here). Cutting on GPA alone narrows GPA's range, which shrinks r (restriction of range), but it doesn't force any trade-off, so there is no sign flip. Point students at the vertical cutoff in Reveal B: the admitted cloud is a narrow vertical strip with the same upward tilt as before, just harder to see.

#align(center)[#image("fig_reveal_B.png", width: 62%)]

If students raise the test-optional debate: restriction of range is one reason predictive correlations computed on enrolled students understate the correlation in the applicant pool. Keep it at that -- the activity shows a mechanism, not the size of the effect in real admissions data.

== Q5 -- closing prompt

Look for answers that name both a selection filter and a conclusion it would distort. Examples: "SAT scores don't predict college grades" (studied only among admitted students); "students who did more extracurriculars had lower GPAs" (if both counted toward admission); "the study habits we use must work" (no data on applicants with the same habits who weren't admitted).
