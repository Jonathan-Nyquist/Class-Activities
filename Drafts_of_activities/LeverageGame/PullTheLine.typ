#import "preamble.typ": *

#show: body => class-doc(
  title: "Pull the Line",
  subtitle: "Leverage, influence, and the points that move a regression line",
  team-members: true,
  body
)

Open the game at #link("https://jonathan-nyquist.github.io/EDS_Artifacts/pull-the-line/")[`jonathan-nyquist.github.io/EDS_Artifacts/pull-the-line`] and keep this sheet beside you. Every round asks you to
commit to a prediction *on paper* before you lock anything in on screen. The game can't check
your reasoning -- this sheet is where it lives.

#part-heading("Part 1: Fit by Eye")

The game shows the same 15 cricket chirp rates and temperatures you have worked with before.
You will drag a line to fit them, then compare it with the least-squares line.

#question[Q1.1. Before you touch the handles: least squares makes the sum of squared
*vertical* misses as small as possible. Do you expect the line you draw by eye to come out
steeper than the least-squares line, shallower, or about the same? Why?]
#answer-space(lines: 2)

#warn[Lock in your line only after you have answered Q1.1.]

#question[Q1.2. Record your results.]

Your slope: #blank(width: 2.2cm) #h(1fr) Least-squares slope: #blank(width: 2.2cm) #h(1fr)
Your score: #blank(width: 2.2cm)

#question[Q1.3. Click *Show the SD line*. Is your slope closer to the least-squares slope or
to the SD line's slope? Least squares is answering "what temperature should I predict for a
given chirp rate?" What question does the SD line seem to answer instead?]
#answer-space(lines: 4)

#pagebreak()
#part-heading("Part 2: Tilt the Line")

You may move exactly one point straight up by 10 °F. Your goal is to change the slope of the
least-squares line as much as possible, in either direction.

#question[Q2.1. Before you click anything: which point will you move, and why that one? Will
the slope go up, go down, or barely change?]

Point number: #blank(width: 1.6cm) #h(1fr) Slope will: #h(4pt) go up #h(10pt) go down
#h(10pt) barely change

Reason:
#answer-space(lines: 2)

#warn[Lock in your point only after you have answered Q2.1.]

#question[Q2.2. Record your results.]

Slope change: #blank(width: 2cm) #h(1fr) Your rank (of 15): #blank(width: 1.5cm) #h(1fr)
Best point: #blank(width: 1.5cm) #h(1fr) Its change: #blank(width: 2cm)

#question[Q2.3. Use *Try other points* to explore. Point 9 has the largest residual of all 15
points, about 6.5 °F below the line. Where does it rank for changing the slope? What do the
points that move the slope the most have in common? (The average chirp rate is 16.65 chirps
per second.)]
#answer-space(lines: 4)

#note[A point's *leverage* is its potential to move the line. It depends only on how far the
point's x-value is from the average x-value -- not on its y-value, and not on its residual.]

#pagebreak()
#part-heading("Part 3: Find the Plant")

In each dataset, someone moved one point 20 °F up or down before the line was fit. You get two
probes per dataset. A probe removes one point, refits the line without it, and reports the
*slope change* that point caused and its *miss* from the line fit without it.

For each dataset, name your suspect *before* probing. Then copy the probe table from the
screen.

#let probe-block(n) = block(breakable: false, above: 18pt, below: 6pt)[
  *Dataset #n.* #h(6pt) Suspect before probing (chirps/sec): #blank(width: 1.6cm)
  #h(6pt) Why: #blank(width: 6.2cm)
  #v(4pt)
  #table(
    columns: (2.2cm, 3.6cm, 3.6cm, 4.4cm),
    stroke: 0.4pt + gray,
    inset: 6pt,
    align: (left, center, center, center),
    [], [*Point (chirps/sec)*], [*Slope change*], [*Miss without it (°F)*],
    [Probe 1], [], [], [],
    [Probe 2], [], [], [],
  )
  #v(2pt)
  Accused (chirps/sec): #blank(width: 1.6cm) #h(1fr) Correct? #h(4pt) Yes #h(8pt) No
  #h(1fr) The plant's residual was the #blank(width: 1.2cm) largest
]

#probe-block(1)
#probe-block(2)
#probe-block(3)

#question[Q3.1. In Dataset 2, the far-right point was real data and the plant was near the
middle. Which of the two changed the slope more? Which of the two was farther from the line
fit without it? What does that tell you about using "it moves the line a lot" as evidence that
a point is wrong?]
#answer-space(lines: 4)

#block(breakable: false)[
#question[Q3.2. Fill in each cell with *big* or *small*.]

#table(
  columns: (5.6cm, 4.4cm, 4.4cm),
  stroke: 0.4pt + gray,
  inset: 7pt,
  align: (left, center, center),
  [], [*Slope change*], [*Miss without it*],
  [A moved point far from the center of x], [], [],
  [A moved point near the center of x], [], [],
  [A real point far from the center of x], [], [],
)
]

#question[Q3.3. In Datasets 1 and 3, the plant did not have the largest residual. Explain why
a moved point far from the center of x can hide in an ordinary residual plot, and why removing
it before measuring its miss fixes that.]
#answer-space(lines: 4)

#part-heading("Part 4: Would You Delete It?")

#question[Q4.1. You are analyzing stream chloride against distance downstream. One sample,
taken much farther downstream than the rest, sits well above the trend and changes the slope a
lot. A teammate says to delete it because it is "an influential outlier." Using what you found
in Part 3, what would you check before deleting it -- and what would count as a good reason to
remove a data point?]
#answer-space(lines: 5)

#pagebreak()
#part-heading("Part 5: Leave One Out (Notebook)")

Open `PullTheLine_Skeleton.ipynb`. You will reproduce the game's numbers with code, then probe
every point at once instead of two at a time.

#question[Q5.1. Record the slope change from moving point 1 up 10 °F. Does it match the game?]

Slope change: #blank(width: 2.2cm) #h(1fr) Matches the game? #h(4pt) Yes #h(8pt) No

#question[Q5.2. Describe the shape of the plot of slope change against distance from mean x.
Where does it cross a slope change of zero, and what does that tell you about leverage?]
#answer-space(lines: 2)

#question[Q5.3. Is there a pattern in the plot of slope change against residual? Where is
point 9?]
#answer-space(lines: 2)

#question[Q5.4. Fill in the table from the leave-one-out loop. Then answer: which points get the
biggest boost when they are left out, and what do they have in common?]

#table(
  columns: (2.2cm, 3cm, 3.4cm, 3.4cm),
  stroke: 0.4pt + gray,
  inset: 5pt,
  align: center,
  [*Point*], [*Residual*], [*Miss without it*], [*Miss ÷ residual*],
  [1], [], [], [],
  [3], [], [], [],
  [9], [], [], [],
)
#answer-space(lines: 2)

#question[Q5.5. For each game dataset, record the x-value of the point with the biggest miss,
the point with the biggest slope change, and the plant (from the game).]

#table(
  columns: (2.4cm, 4cm, 4.4cm, 3cm),
  stroke: 0.4pt + gray,
  inset: 5pt,
  align: center,
  [*Dataset*], [*Biggest miss (x)*], [*Biggest slope change (x)*], [*Plant (x)*],
  [1], [], [], [],
  [2], [], [], [],
  [3], [], [], [],
)

In which dataset do the two columns disagree? Which column found the plant there, and why?
#answer-space(lines: 2)
