#import "preamble.typ": *

#show: body => class-doc(
  title: "Class 20: The Registrar's Report",
  subtitle: "Survivorship bias, from Wald's bombers to your diploma",
  team-members: true,
  body
)

#part-heading("Part 1: Before We Look at Anything Else")

Every year, a college can report a reassuring number: the average time it takes a student to
earn their degree. Here is that number for one entering cohort, straight from the registrar's
records -- 63 students who have graduated.

#question[Q1.1. Before you run anything: does a number like this -- computed only from
students who *already graduated* -- describe the typical experience of an entering student?
Is it likely to be optimistic, pessimistic, or accurate? And roughly what fraction of the
*entering* cohort do you think this statistic is even built from?]
#answer-space(lines: 3)

#warn[Write an answer above before you run the next cell. The rest of today only works if you
commit first.]

#part-heading("Part 2: What the Report Left Out")

The registrar's report only ever tracks students who finished. Here is the *entire* entering
cohort those 63 graduates came from -- everyone who started, including the ones who dropped
out and the ones still working on it.

#question[Q2.1. Run the cell that computes the honest completion rate. Record it here, and
compare it to your guess in Q1.1.]

Honest completion rate: #blank(width: 2.5cm) #h(1fr) My Q1.1 guess was: #blank(width: 2.5cm)

#question[Q2.2 Discussion. The naive graduates-only average (4.31 years) and this honest
completion rate are two completely different kinds of claim. What question does the average
answer, and what question does it fail to answer at all?]
#answer-space(lines: 2)

#part-heading("Part 3: The Proper Way to Count")

Averaging only the finishers has a second, sneakier problem: even the students who are *on
track* to graduate eventually don't count yet if we ask today. Statisticians call this
*censoring* -- we know how long we've tracked a student, but not whether or when they'll
graduate. There's a standard tool built for exactly this situation -- a *Kaplan-Meier curve*,
marked with a tick wherever a censored student leaves the count -- and your instructor will
walk through one built from scratch, using only the Table methods and numpy you already know.

#question[Q3.1. At year 6 -- the edge of our tracking window -- what percentage of the
*original* entering cohort still has not graduated? Is this number knowable from the
registrar's graduates-only report?]
#answer-space(lines: 4)

#question[Q3.2. The curve puts the point where 50% of the entering cohort has graduated at
4.5 years -- later than the naive graduates-only average of 4.31 years. Which direction did
the naive number get it wrong, and why does that direction make sense once you know what it
was leaving out?]
#answer-space(lines: 4)

#pagebreak()
#part-heading("Part 4: Back to the Bombers")

In lecture: engineers wanted to armor the planes where returning bombers showed the most
damage. Wald's insight was that the returning planes were exactly the wrong place to look.

#question[Q4.1. Fill in the right-hand column, matching each row to today's activity.]

#let ans-cell = [#blank(width: 5.4cm) #linebreak() #v(5pt) #blank(width: 5.4cm)]

#table(
  columns: (4.4cm, 5.4cm, 5.4cm),
  stroke: 0.4pt + gray,
  inset: 7pt,
  align: (left, left, left),
  row-gutter: 4pt,
  [], [*Returning Bombers*], [*The Registrar's Report*],
  [What we can see], [Damage on planes that made it back], ans-cell,
  [What's missing from the data], [Planes that never came back], ans-cell,
  [The naive conclusion], [Armor where the damage is], ans-cell,
  [Why it's wrong], [Damage there was survivable -- that's *why* those planes made it back],
  ans-cell,
)

#v(10pt)

#question[Q4.2. Name one more place -- outside planes and college -- where only looking at the
"survivors" would give you a misleading picture.]
#answer-space(lines: 4)
