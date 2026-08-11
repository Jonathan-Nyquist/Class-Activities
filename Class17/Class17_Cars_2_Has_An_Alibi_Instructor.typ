#set document(
  title: "Honors Class 17 Instructor Notes: Cars 2 Has an Alibi",
  author: "Elements of Data Science",
  keywords: ("data science", "honors", "EDA", "box plot", "correlation", "influence", "instructor notes"),
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
#show heading.where(level: 3): it => [
  #set text(size: 11pt, weight: "bold", style: "italic")
  #block(above: 10pt, below: 4pt, it.body)
]

#let note(body) = block(width: 100%, fill: rgb("#f7f4ec"), inset: 8pt, radius: 3pt, body)
#let warn(body) = block(width: 100%, fill: rgb("#f7efef"), inset: 8pt, radius: 3pt, body)

= Cars 2 Has an Alibi

#align(center)[*Class 17 Instructor Notes* #h(0.5cm) | #h(0.5cm) 50 minutes of a 75-minute period #h(0.5cm) | #h(0.5cm) Four-page handout #h(0.5cm) | #h(0.5cm) Laptops, teams of 2--3]

== Placement and purpose

First class covering bivariate data. Runs on the day the Pennypack mini-project is due at
midnight, so the activity deliberately uses *no* Pennypack data --- students are still writing
that up, and nothing here should preempt their interpretation.

*The one idea:* $r$ measures one specific thing --- how tightly the points hug a straight line
--- and "the most unusual point" is a different question with a different answer. Part 1 builds
the univariate tools, Part 2 derives $r$ from standard units, Part 3 shows that the obvious
outlier and the point that most moves $r$ are not the same film, and why.

#note[
*The spine.* The box plot in Part 1 flags exactly one flier --- Cars 2 --- and the scatter plot
in Part 2 makes it look even worse. In Part 3 students find that removing it *raises* $r$, and
that the largest single effect on $r$ belongs to Onward instead. Cars 2 is not innocent; it has
an alibi for this particular charge. Do not spoil this.
]

#note[
*Sets up Class 18.* Part 2 has students derive $r$ as the mean of the product of standard
units by hand. That is the same derivation as slides 9--15 of the Class 18 deck, so those can
compress to a single recap slide --- and slide 30 ("in standard units the slope is $r$ and the
intercept is zero") lands as a payoff rather than a new fact.
]

== Timing

#table(
  columns: (1.5cm, 1fr),
  stroke: none,
  inset: (x: 3pt, y: 3.5pt),
  [*18 min*], [Part 1 --- `stats()`, quartiles by hand, box plot],
  [*18 min*], [Part 2 --- scatter, standard units, $r$],
  [*14 min*], [Part 3 --- the alibi, then the four data sets],
)

Leaves ~25 minutes for practice quiz questions, Pennypack tips, and correlation vs. causation.

#warn[
*If you are behind:* run Q3.5 as a demo from the front rather than cutting it --- the four
plots take thirty seconds to show and the discussion can happen out loud. Q3.3 is the one that
needs quiet working time.
]

== Code blanks

Only two, both in Part 2:

```
return (any_numbers - np.mean(any_numbers)) / np.std(any_numbers)
return np.mean(standard_units(x) * standard_units(y))
```

== 18 min --- Part 1. One Variable at a Time

Twenty-one films survive the `dropna()`.

#align(center)[
  #table(
    columns: (3.4cm, 2.3cm, 2.3cm, 2.3cm, 2.3cm),
    align: (left, center, center, center, center),
    inset: 5pt,
    stroke: 0.5pt + rgb("#888888"),
    table.header([], [*mean*], [*median*], [*mean − med*], [*IQR*]),
    [`rotten_tomatoes`], [88.52], [96], [*−7.48*], [17.0],
    [metacritic], [79.38], [81], [−1.62], [21.0],
    [`critics_choice`], [87.14], [89], [−1.86], [12.0],
  )
]

*Q1.2:* Rotten Tomatoes. A mean well below the median means a long left tail --- a few very low
values dragging the average down while most films cluster high.

#note[
*The reason is the measurement scale, not the movies.* Rotten Tomatoes reports the
#emph[percentage of critics who were positive], so it saturates: 14 of the 21 films sit at 90
or above and it cannot exceed 100. Metacritic averages numerical scores and does not pile up at
the ceiling. Worth saying out loud --- students assume the difference says something about
Pixar.
]

*Q1.3 (by hand):* Q1 = 26.5, Q2 = 36, Q3 = 51, IQR = 24.5. Same twelve numbers as the MathBits
slide, so it doubles as a check that the lecture definition landed.

*Q1.4:* Rotten Tomatoes most favorable, metacritic least. *One* flier in the entire plot, on
`rotten_tomatoes`.

*Q1.5:* Cars 2 --- 40 / 57 / 67. Expect teams to say yes, obviously an outlier. Let them.

== 20 min --- Part 2. Two Variables at a Time

*Q2.2:* Standardizing changes the axis numbers and centers the cloud on zero. It does not
change the shape of the pattern at all --- because subtracting a constant and dividing by a
constant is just relabeling the ruler.

*Q2.3 sign table:* both above average, or both below → *positive* product. One above and one
below → *negative*. So when the variables track each other, nearly every product is positive
and they add up; when they do not, positives and negatives cancel toward zero.

#align(center)[
  #table(
    columns: (3cm, 3cm, 3cm),
    align: (center, center, center),
    inset: 5pt,
    stroke: 0.5pt + rgb("#888888"),
    table.header([], [`rotten_tomatoes`], [*metacritic*]),
    [metacritic], [*0.802*], [],
    [`critics_choice`], [*0.852*], [*0.865*],
  )
]

*Q2.4:* metacritic and `critics_choice` agree most closely ($r = 0.865$). All three are
strong and positive, which is the unsurprising part --- they are all rating the same films.

== 14 min --- Part 3. The Alibi

*Q3.1:* $r$ = *0.802* with all 21 films, *0.826* with Cars 2 removed. Removing the worst-looking
point makes the correlation *stronger*. Give the room a moment with that.

*Q3.2:* leave-one-out changes, largest first: Onward *+0.0473*, Cars 2 +0.0239, WALL-E +0.0091.
Onward is at (88, 61) --- middle of the pack horizontally, well below everything else vertically.

*Q3.3:* the decomposition. $r$ = 0.802 observed; *0.867* if Cars 2 had scored 46; *0.826* with
Cars 2 removed.

#note[
*Where the 0.04 went.* Removing Cars 2 does two opposing things. It deletes a point that is out
of line, which *raises* $r$ by about 0.065. It also collapses the spread of `rotten_tomatoes`
--- range 60 down to 31, SD 14.26 down to 9.49 --- and $r$ rewards spread, which *lowers* $r$ by
about 0.041. Net: +0.024. Onward gets no such cancellation, because at RT = 88 it sits inside
the range and removing it changes the spread not at all.
]

*Q3.4:* Yes, Cars 2 is genuinely the most unusual point. No, it is not the point that most
affects $r$. Both are true because $r$ is not a measure of unusualness --- it asks how tightly
the cloud hugs a line, and Cars 2 simultaneously hurts that (off the line) and helps it (widens
the spread).

#warn[
*This is where students push hardest, and they are right to.* Cars 2 really is the extreme
point by every standard diagnostic --- its leverage is 0.599 against a mean of 0.095, and its
Cook's distance is 3.69 against Onward's 0.147, a factor of 25. If a team argues that Cars 2
"obviously matters more," agree with them. The lesson is not that Cars 2 is unimportant; it is
that $Delta r$ answers a narrower question than "which point matters," and answering the
broader one takes a fitted line.
]

#note[
*Hand-off to Class 18.* Once regression is on the board, this same scatter gives you residuals
and leverage --- the tools that do convict Cars 2. Worth promising out loud at the end of
Part 3: "the measure that catches this one is next class."
]

*Q3.5:* Anscombe's quartet. All four have mean $x = 9$, mean $y = 7.5$, SD $y approx 1.94$, and
$r approx 0.816$ --- close to the 0.802 students just computed, which is the hook. Set I is an
ordinary linear scatter; II is a clean parabola; III is a perfect line with one outlier; IV is a
vertical stack at $x = 8$ plus a single distant point that manufactures the entire correlation.

Only Set I can honestly be summarized by $r$. II has a strong relationship that is not linear,
so $r$ understates it. III's underlying relationship is nearly perfect but one point drags $r$
down. IV has no relationship at all among ten of its eleven points --- and it is the tidiest
possible illustration of the Cars 2 problem, since there a single high-leverage point creates
the correlation rather than merely surviving it.

#warn[
Students often conclude "$r$ is useless." Push back: $r$ answers one specific question --- how
close is this to a straight line --- and answers it well. The failure is reporting it without
the plot, not the statistic itself.
]

== Two notes on the code

#note[
The warmup's `ratings.to_df().dropna()` keeps all 21 films even though Soul is missing a
`cinema_score`. That is because `Table.read_table` reads `cinema_score` as a string column, so
the missing entry becomes the literal string `'nan'`, which `dropna()` does not recognize. It
gives the right answer here, but by luck --- reading the same file with `pandas.read_csv`
directly drops Soul and leaves 20. Worth knowing if a student's numbers disagree with yours.
]

The influence loop recomputes standard units inside each subset, which is the correct thing to
do --- $r$ is defined relative to the mean and SD of the data you actually have. A student who
reuses the full-table standard units will get slightly different numbers and is worth a
conversation.
