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

#align(center)[*Class 18 Instructor Notes* #h(0.5cm) | #h(0.5cm) 40 minutes of a 75-minute period #h(0.5cm) | #h(0.5cm) Four-page handout #h(0.5cm) | #h(0.5cm) Laptops, teams of 2--3]

== Placement and purpose

Follows the regression lecture. Students already have $r$, and the lecture has shown that slope
and intercept both fall out of it. This activity answers the question that comes next: *was the
line worth fitting?*

*The one idea:* $R^2$ measures how much the line beat a flat guess at the mean --- and it can be
high for a model that is flatly wrong. The residual plot is what catches that.

#note[
*Structural note.* The order here is inverted from the source notebook. Students do the full
six-step calculation once, on the *cricket* data, and meet the quadratic example afterwards as a
twist rather than as a warm-up. Two reasons: it fits 40 minutes (one walkthrough, not two), and
it makes the punchline land harder --- the fake data set gets the *higher* $R^2$ (0.923 vs
0.698) while being the case where a straight line is plainly wrong.
]

== Timing

#table(
  columns: (1.5cm, 1fr),
  stroke: none,
  inset: (x: 3pt, y: 3.5pt),
  [*6 min*], [Part 1 --- two baselines, on paper, no code],
  [*20 min*], [Part 2 --- $S S_"Total"$, fit, $S S_"Residual"$, $R^2 = r^2$],
  [*8 min*], [Part 3 --- extrapolation and the negative $R^2$],
  [*6 min*], [Part 4 --- the twist and the residual plots],
)

#warn[
*If you are behind:* Part 3 is the one to compress --- run the two cells from the front and
assign Q3.1--3.2 as written reflection. Do not cut Part 4; the residual plot is the only
diagnostic in the activity that generalizes beyond this data set.
]

== Code blanks

Four, all in Part 2 except none elsewhere:

```
SS_total   = np.sum(deviations ** 2)
residuals  = temp - predicted
R_squared  = 1 - (SS_residual / SS_total)
```

(The second blank is the one students get wrong --- they subtract the mean again instead of the
prediction. The comment warns them; some will still do it.)

== 6 min --- Part 1. Two Baselines

Paper only. *Q1.1:* the mean, because it minimizes total squared error --- no other single
number sits closer to all the points at once. *Q1.2:* perfect line → $S S_"Residual" = 0$,
$R^2 = 1$; useless line → $S S_"Residual" = S S_"Total"$, $R^2 = 0$.

Getting Q1.2 down *before* any computation is what makes the negative $R^2$ in Part 3 register
as strange rather than as just another number.

== 20 min --- Part 2. How Good Is the Cricket Line?

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
    [$R^2$], [0.6975],
    [$r$], [0.8351],
  )
]

*Q2.2 slope in plain English:* each additional chirp per second corresponds to about *3.3 °F*
warmer. Push for the units --- "degrees Fahrenheit per chirp per second" is the answer, and
students who cannot state them usually cannot interpret the number either.

*Q2.3:* chirp rate accounts for about *70%* of the variation in temperature; the remaining 30%
is variation the line cannot explain --- measurement error, other factors, and the fact that
crickets are not thermometers.

#note[
*Q2.4 is the calibration question and worth the time.* Last class students found $r = 0.802$
between Pixar rating services and called it strong. Squared, that is *0.64* --- barely
two-thirds of the variation. Most students carry an intuition that $r = 0.8$ means "80% of the
way to perfect." It does not. The crickets make the same point: $r = 0.84$ sounds excellent,
$R^2 = 0.70$ sounds noticeably less so, and they are the same fit.
]

== 8 min --- Part 3. Where the Line Stops Working

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

*Q3.2:* forcing the line through the origin while keeping the fitted slope makes it predict
*49.4 °F at 15 chirps/sec*, against actual temperatures of 69--93 °F. It is 20--30 degrees low
across the whole data set, so $S S_"Residual"$ balloons to 9741 against 190 for the real line,
and $R^2$ falls to about *−14.5*. Negative $R^2$ means the flat line at the mean would have been
better.

#warn[
*Expect the sharp question:* "why not refit the slope through the origin?" The honest answer is
that you can, and it gives slope 4.79 and $R^2 = +0.55$ --- positive. So this demonstration is
*not* showing what a through-origin regression does; it is showing what happens when you keep a
slope that was fitted alongside an intercept and then throw the intercept away. The general
lesson survives intact: $R^2$ compares whatever prediction rule you hand it against the mean,
and a bad rule loses. Do not claim more than that.
]

== 6 min --- Part 4. A Better Number That Is a Worse Model

Second data set: $x = 0 .. 6$, $y = x^2$. Fitted line $y = 6x - 5$, $S S_"Total" = 1092$,
$S S_"Residual" = 84$, *$R^2 = 0.9231$*.

*Q4.1:* the quadratic data gets the higher $R^2$ (0.923 vs 0.698), and it is the one where a
straight line is the *wrong* model. The crickets have a genuinely linear relationship with real
scatter; the second set has no scatter at all and a systematic curve.

*Q4.2 --- the residuals.* This is the payoff.

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

*Q4.3:* no. A high $R^2$ says the line is closer to the points than a flat mean is; it says
nothing about whether a line was the right shape. The residual plot shows structure the line
failed to capture --- and here it shows it loudly, on the data set with the better $R^2$.

#note[
*Closing line worth saying out loud:* every regression you fit from here on gets a residual
plot before you report the $R^2$. It costs one cell.
]

== Notes on what was left out

*Bootstrapping.* `Cricket_Thermometer.ipynb` continues into bootstrap confidence intervals for
the slope and a seaborn `regplot` band. That needs regression to be settled first, so it belongs
in a later class. Its Challenges 1--3 --- explain `intercept()`, predict at 19 chirps, why not
extrapolate to 40 --- are folded into Parts 2 and 3 here.

*The Cars 2 callback.* Class 17's notes promised that the diagnostic catching Cars 2 would
arrive this class. Residual plots deliver only half of that: on the Pixar fit, Onward has the
larger residual (−18.0) and Cars 2 the larger *leverage* (0.599 against a mean of 0.095). If you
want to close that loop, it takes a fifth part introducing leverage as "how far this point sits
from the center of $x$," which does not fit 40 minutes. Otherwise say plainly that the second
half of the answer is still coming.
