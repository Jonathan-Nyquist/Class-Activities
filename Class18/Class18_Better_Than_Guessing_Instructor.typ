#set document(
  title: "Honors Class 18 Instructor Notes: Better Than Guessing",
  author: "Elements of Data Science",
  keywords: ("data science", "honors", "regression", "R-squared", "residual plot", "extrapolation", "instructor notes"),
)

#set page(paper: "us-letter", margin: (x: 1in, y: 0.85in))
#set par(justify: true, leading: 0.62em, spacing: 0.9em)
#set heading(numbering: none)
#set text(font: "Liberation Serif", size: 11pt, lang: "en", region: "us")

#show raw.where(block: true): it => block(
  fill: rgb("#f2f2f2"), inset: 8pt, radius: 3pt, width: 100%,
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

#let note(body) = block(width: 100%, fill: rgb("#f7f4ec"), inset: 8pt, radius: 3pt, body)
#let warn(body) = block(width: 100%, fill: rgb("#f7efef"), inset: 8pt, radius: 3pt, body)

= Better Than Guessing

#align(center)[*Class 18 Instructor Notes* #h(0.5cm) | #h(0.5cm) 15 minutes of a 75-minute period #h(0.5cm) | #h(0.5cm) Two-page handout #h(0.5cm) | #h(0.5cm) Laptops, teams of 2--3]

== Placement and purpose

Follows a long regression lecture that does the full $S S_"Total"$ → fit → $S S_"Residual"$ →
$R^2$ calculation on the cricket data. The activity starts from that result rather than
rebuilding it, and spends its time on the two things the lecture cannot do as well: where the
line stops being trustworthy, and a case where $R^2$ points the wrong way.

*The one idea:* $R^2$ measures how much the line beat a flat guess at the mean --- and it can be
high for a model that is flatly wrong. The residual plot is what catches that.

#note[
*No code blanks.* Every cell runs as given; the skeleton is 17 cells. Part 1 is a single cell
that reproduces the lecture's numbers, so students can check their lecture notes against it.
]

== Timing

#table(
  columns: (1.5cm, 1fr),
  stroke: none,
  inset: (x: 3pt, y: 3.5pt),
  [*3 min*], [Part 1 --- run the cricket fit, interpret the slope, square last week's $r$],
  [*4 min*], [Part 2 --- extrapolation and the intercept],
  [*7 min*], [Part 3 --- predict, then the twist and the residual plots],
  [*1 min*], [Buffer / closing line],
)

#warn[
*If you are behind:* take Q2.1 orally from the front --- read the three predictions and ask which
two to refuse. Do not cut Part 3; the residual plot is the only diagnostic in the activity that
generalizes beyond this data set, and the predict-first in Q3.1 is what makes it land.
]

== 3 min --- Part 1. The Cricket Line

#align(center)[
  #table(
    columns: (5cm, 3.4cm),
    align: (left, center),
    inset: 5pt,
    stroke: 0.5pt + rgb("#888888"),
    table.header([*quantity*], [*value*]),
    [mean temperature], [80.04 °F],
    [$S S_"Total"$], [629.84],
    [slope], [3.2911],
    [intercept], [25.2323],
    [$S S_"Residual"$], [190.55],
    [$R^2 = r^2$], [0.6975],
    [$r$], [0.8351],
  )
]

*Q1.1 slope in plain English:* each additional chirp per second corresponds to about *3.3 °F*
warmer. Push for the units --- "degrees Fahrenheit per chirp per second" is the answer, and
students who cannot state them usually cannot interpret the number either.

#note[
*Q1.2 is the calibration question.* Last class students found $r = 0.802$ between Pixar rating
services and called it strong. Squared, that is *0.64* --- barely two-thirds of the variation.
Most students carry an intuition that $r = 0.8$ means "80% of the way to perfect." It does not.
The crickets make the same point: $r = 0.84$ sounds excellent, $R^2 = 0.70$ sounds noticeably
less so, and they are the same fit.
]

== 4 min --- Part 2. Where the Line Stops Working

Predictions: *19 chirps → 87.8 °F* (fine, inside the observed range of 14.4--20.0);
*40 chirps → 156.9 °F* (absurd --- and no cricket chirps that fast);
*0 chirps → 25.2 °F*, the intercept itself.

#note[
*The intercept is the better half of this question.* Extrapolating to 40 is an obvious mistake
that no one would make by accident. But the intercept is *printed in the regression output* and
looks like a legitimate result --- and it claims something about a temperature at which crickets
have been silent for thirty degrees. Students who write "the intercept is the temperature when
there are no chirps" have stated the arithmetic correctly and the science wrongly.
]

== 7 min --- Part 3. A Better Number That Is a Worse Model

Second data set: $x = 0 .. 6$, $y = x^2$. Fitted line $y = 6x - 5$, $S S_"Total" = 1092$,
$S S_"Residual" = 84$, *$R^2 = 0.9231$*.

*Q3.1:* expect many students, looking at a line that visibly misses a curve, to predict *lower*. It is
higher (0.923 vs 0.698), and it is the one where a straight line is the *wrong* model. The
crickets have a genuinely linear relationship with real scatter; the second set has no scatter
at all and a systematic curve. Get a show of hands on the prediction before anyone runs the cell.

*Q3.2 --- the residuals.* This is the payoff.

#align(center)[
  #table(
    columns: (2cm, 1.2cm, 1.2cm, 1.2cm, 1.2cm, 1.2cm, 1.2cm, 1.2cm),
    align: center,
    inset: 4pt,
    stroke: 0.5pt + rgb("#888888"),
    table.header([*x*], [0], [1], [2], [3], [4], [5], [6]),
    [*residual*], [+5], [0], [−3], [−4], [−3], [0], [+5],
  )
]

A perfect U. The cricket residuals, by contrast, scatter from −6.5 to +5.0 with no pattern ---
their correlation with chirp rate is exactly 0, which is true of *any* least-squares fit by
construction, so what matters is the visible shape, not the number.

*Q3.3:* no. A high $R^2$ says the line is closer to the points than a flat mean is; it says
nothing about whether a line was the right shape. The residual plot shows structure the line
failed to capture --- and here it shows it loudly, on the data set with the better $R^2$.

#note[
*Closing line worth saying out loud:* every regression you fit from here on gets a residual
plot before you report the $R^2$. It costs one cell.
]

== Cut from the 40-minute version

The earlier version is in `_archive_40min/`. Three things came out:

- *Two baselines (paper).* Why the mean is the best single guess, and $R^2 = 1$ / $0$ at the
  extremes. The lecture covers both; if it did not, ask the two limits orally in one minute.
- *The six-step walkthrough with code blanks.* The lecture does this calculation on the same
  data.
- *Negative $R^2$.* Keeping the fitted slope and forcing $b = 0$ gives $R^2 approx -14.5$. It
  needed a caveat --- a true through-origin refit gives slope 4.79 and $R^2 = +0.55$ --- and did
  not earn its time at 15 minutes. If a student asks whether $R^2$ can be negative: yes, for any
  prediction rule worse than the mean, but not for a least-squares line with an intercept.

*The Cars 2 callback.* Class 17's notes promised that the diagnostic catching Cars 2 would
arrive this class. Residual plots deliver only half of that: on the Pixar fit, Onward has the
larger residual (−18.0) and Cars 2 the larger *leverage* (0.599 against a mean of 0.095). There
is no room for it in this activity; if you want to close the loop, it belongs in the lecture.
Otherwise say plainly that the second half of the answer is still coming.
