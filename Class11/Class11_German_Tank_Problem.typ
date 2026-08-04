#set document(
  title: "Honors Class 11 Activity: The German Tank Problem",
  author: "Elements of Data Science",
  keywords: ("data science", "honors", "simulation", "sampling distribution", "estimator", "activity"),
)

#set page(
  paper: "us-letter",
  margin: (x: 1in, y: 1in),
)

#set par(justify: true, leading: 0.65em)
#set heading(numbering: none)
#set text(font: "Liberation Serif", size: 11pt, lang: "en", region: "us")

#show raw.where(block: true): it => block(
  fill: rgb("#f2f2f2"),
  inset: 8pt,
  radius: 3pt,
  width: 100%,
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
  #block(above: 14pt, below: 6pt, it.body)
]

#let question(body) = block(
  width: 100%,
  inset: (left: 8pt, top: 4pt, bottom: 4pt),
  stroke: (left: 2pt + rgb("#4a4a4a")),
  text(weight: "bold", body),
)

#let blank(width: 2.5cm) = box(
  width: width,
  height: 0.9em,
  stroke: (bottom: 0.5pt + black),
)

#let answer-space(height: 2cm) = block(height: height, width: 100%)

= The German Tank Problem

#set par(justify: false)
*Team Members:* #blank(width: 3.4cm) #h(0.2cm) #blank(width: 3.4cm) #h(0.2cm) #blank(width: 3.4cm)

#v(0.2cm)
#h(2.55cm) #blank(width: 3.4cm) #h(0.2cm) #blank(width: 3.4cm)
#set par(justify: true)

#v(0.2cm)

== Background — read this before class

Through 1940 and 1941, the Allies badly needed to know how many tanks Germany was building,
and had two ways of finding out. The first was conventional intelligence: spies, prisoner
interrogations, intercepted signals, aerial reconnaissance. The second was a group of
economists in London working with a much stranger kind of evidence — the serial numbers
stamped on captured German equipment. Gearboxes, engines, chassis, and road wheels all
carried numbers, and the Germans, being methodical, numbered them in sequence.

The idea is this. If you capture a handful of tanks at random and read their serial numbers,
those numbers are a sample from the full run of production. The largest number you happen to
see tells you something about how long that run must be. How much it tells you, and how to
turn it into a number, is the whole problem.

Richard Ruggles and Henry Brodie published the wartime account in 1947. Postwar records let
everyone check the answers:

#v(0.2cm)
#align(center)[
  #table(
    columns: (3.2cm, 4.2cm, 4cm, 3.4cm),
    inset: 6pt,
    align: (left, center, center, center),
    stroke: 0.5pt + rgb("#888888"),
    [*Month*], [*Conventional \ intelligence*], [*Serial-number \ analysis*], [*German \ records*],
    [June 1940], [1,000], [169], [122],
    [June 1941], [1,550], [244], [271],
    [August 1942], [1,550], [327], [342],
  )
]
#v(0.2cm)

The spies were off by a factor of five. The statisticians were off by a few percent, and
they were working from scrap metal. Just before D-Day the same method was turned on the
Panther tank, whose numbers in northern France the Allied command had badly underestimated.
Road wheels from two captured Panthers gave an estimate of 270 built in February 1944.
German records, recovered after the war, put the true figure at 276.

Today you will reconstruct the method, find out how well it works, and find out how they
knew how well it worked.

== Part 1. Commit First

Your unit has captured five enemy tanks. Their serial numbers are:

#v(0.15cm)
#align(center)[#text(size: 13pt, font: "Liberation Mono")[62 #h(0.8cm) 214 #h(0.8cm) 389 #h(0.8cm) 605 #h(0.8cm) 880]]
#v(0.15cm)

Nobody knows how many the enemy has. You have to say something. Do this before you open the
notebook.

#question[
  #set par(justify: false)
  1.1 State your team's rule in words, then give the number it produces. Anyone should be
  able to apply your rule without asking what you meant. \
  #v(0.05cm)
  #set par(justify: true)
  Estimate: #blank(width: 3cm)
]

#answer-space(height: 1.8cm)

#question[
  1.2 Consider the simplest rule of all: report the largest serial number you saw. Give a
  reason it must be wrong — not "it feels low," but an argument for why it can never be too
  high.
]

#answer-space(height: 1.8cm)

== Where the Correction Comes From

Before you write `est_corrected`, here is the argument behind it.

Your captured serial numbers chop the stretch from zero up to the largest one you saw into
$k$ pieces: the space below the smallest, and the space between each consecutive pair. If
the capture was random, none of those gaps is special, so on average they are all the same
size — namely $m \/ k$. Above the largest serial there is one more stretch, the tanks you
never saw, and no reason it should be systematically wider or narrower than the others. So
estimate it at one more average gap.

#v(0.15cm)

#let W = 12.4cm
#let TOP = 17.5
#let px(v) = v * W / TOP

#align(center)[
  #box(width: W + 1.2cm, height: 2.9cm)[
    #place(dx: px(0), dy: 1.0cm, rect(width: px(2), height: 0.4cm,
      fill: rgb("#e4e4e4"), stroke: 0.4pt + rgb("#666666")))
    #place(dx: px(2), dy: 1.0cm, rect(width: px(4), height: 0.4cm,
      fill: rgb("#e4e4e4"), stroke: 0.4pt + rgb("#666666")))
    #place(dx: px(6), dy: 1.0cm, rect(width: px(1), height: 0.4cm,
      fill: rgb("#e4e4e4"), stroke: 0.4pt + rgb("#666666")))
    #place(dx: px(7), dy: 1.0cm, rect(width: px(7), height: 0.4cm,
      fill: rgb("#e4e4e4"), stroke: 0.4pt + rgb("#666666")))
    #place(dx: px(14), dy: 1.0cm, rect(width: px(3.5), height: 0.4cm,
      fill: none, stroke: (paint: rgb("#444444"), thickness: 0.7pt, dash: "dashed")))

    #place(dx: 0cm, dy: 1.0cm, line(length: W + 0.4cm, stroke: 0.8pt))

    #place(dx: -0.5cm, dy: 0.5cm, box(width: 1cm)[#align(center)[#text(size: 9pt)[0]]])
    #place(dx: px(2) - 0.5cm, dy: 0.5cm, box(width: 1cm)[#align(center)[#text(size: 9pt)[2]]])
    #place(dx: px(6) - 0.5cm, dy: 0.5cm, box(width: 1cm)[#align(center)[#text(size: 9pt)[6]]])
    #place(dx: px(7) - 0.5cm, dy: 0.18cm, box(width: 1cm)[#align(center)[#text(size: 9pt)[7]]])
    #place(dx: px(14) - 0.5cm, dy: 0.5cm, box(width: 1cm)[#align(center)[#text(size: 9pt)[14]]])
    #place(dx: px(17.5) - 0.7cm, dy: 0.5cm, box(width: 1.4cm)[#align(center)[#text(size: 9pt)[17.5]]])

    #place(dx: px(2), dy: 0.86cm, line(length: 0.28cm, angle: 90deg, stroke: 0.8pt))
    #place(dx: px(6), dy: 0.86cm, line(length: 0.28cm, angle: 90deg, stroke: 0.8pt))
    #place(dx: px(7), dy: 0.86cm, line(length: 0.28cm, angle: 90deg, stroke: 0.8pt))
    #place(dx: px(14), dy: 0.86cm, line(length: 0.28cm, angle: 90deg, stroke: 0.8pt))
    #place(dx: px(17.5), dy: 0.86cm, line(length: 0.28cm, angle: 90deg,
      stroke: (paint: rgb("#444444"), thickness: 0.8pt, dash: "dashed")))

    #place(dx: px(0), dy: 1.48cm, box(width: px(2))[#align(center)[#text(size: 8pt)[2]]])
    #place(dx: px(2), dy: 1.48cm, box(width: px(4))[#align(center)[#text(size: 8pt)[4]]])
    #place(dx: px(6), dy: 1.48cm, box(width: px(1))[#align(center)[#text(size: 8pt)[1]]])
    #place(dx: px(7), dy: 1.48cm, box(width: px(7))[#align(center)[#text(size: 8pt)[7]]])
    #place(dx: px(14), dy: 1.48cm, box(width: px(3.5))[#align(center)[#text(size: 8pt)[3.5]]])

    #place(dx: px(0), dy: 1.95cm, box(width: px(14))[#align(center)[
      #text(size: 8.5pt, style: "italic")[four gaps below the largest serial, average 14 ÷ 4 = 3.5]]])
    #place(dx: px(14) - 0.7cm, dy: 1.95cm, box(width: px(3.5) + 1.4cm)[#align(center)[
      #text(size: 8.5pt, style: "italic")[one more average gap]]])
  ]
]

#v(0.1cm)

Above the line are the four serial numbers you captured; below it are the sizes of the gaps
they create. Adding one more average gap gives $m + m \/ k = m (1 + 1 \/ k)$, or 17.5 here.

The $- 1$ in the formula is a counting correction. Serial numbers are whole numbers and the
gaps include their endpoints, so without it the estimate lands one tank high on average.
That brings this sample to 16.5 — the value your function has to return in 2.2.

Two checks worth making. If you captured every tank, then $k = N$ and $m = N$, and the
formula returns exactly $N$. If you captured only one, it tells you to double the serial
number — which is what you would have guessed anyway, since a single random serial sits
halfway up the run on average.

== Part 2. One Capture

Open `Class11_German_Tank_Problem_Skeleton.ipynb` and save it under your team's name.

#question[
  #set par(justify: false)
  2.1 Four more draws of five tanks from a fleet of 1000. Largest serial number each time: \
  #v(0.05cm)
  #h(0.5cm) #blank(width: 2.4cm) #h(0.5cm) #blank(width: 2.4cm) #h(0.5cm) #blank(width: 2.4cm) #h(0.5cm) #blank(width: 2.4cm)
]

#question[
  #set par(justify: false)
  2.2 Tested on `make_array(2, 6, 7, 14)`, your two functions must return exactly *14* and
  *16.5*. Check both before going on. Do they? #h(0.4cm) YES #h(0.8cm) NO — fix them now.
]

#question[
  #set par(justify: false)
  2.3 Now the five real serial numbers. \
  #v(0.05cm)
  #h(0.5cm) `est_max` #blank(width: 3cm) #h(1cm) `est_corrected` #blank(width: 3cm)
]

#question[
  #set par(justify: false)
  2.4 Here is a third rule, which you will not be coding. Take twice the average of the
  serial numbers, minus one. Work it out by hand for your five tanks: #blank(width: 2.6cm) \
  #v(0.05cm)
  #set par(justify: true)
  That answer is smaller than a serial number you have seen with your own eyes. Could it be
  the true number of tanks? This rule is nevertheless correct *on average*. What does that
  tell you about the difference between a rule being right on average and a rule being
  sensible every time?
]

#answer-space(height: 2.4cm)

== Part 3. A Thousand Parallel Wars

You cannot tell whether a rule is good from one capture, because you get one capture and you
never learn the answer. So invent an enemy whose size you already know — 1000 tanks — and
fight the same war a thousand times.

#question[
  3.1 Sketch both histograms, on the same bins. Mark 1000 on each one.
]

#v(0.2cm)
#align(center)[
  #table(
    columns: (7.7cm, 7.7cm),
    rows: (3.6cm, auto),
    inset: 4pt,
    align: center,
    stroke: 0.5pt + rgb("#aaaaaa"),
    [], [],
    text(size: 9pt)[`max`], text(size: 9pt)[`corrected`],
  )
]
#v(0.2cm)

#question[
  #set par(justify: false)
  3.2 Which histogram is centered on the true value of 1000? #blank(width: 5cm) \
  #v(0.05cm)
  Are they symmetric, or do they have a long tail on one side? \
  #v(0.05cm)
  #h(0.5cm) #blank(width: 12cm)
]

#question[
  3.3 The serial numbers themselves are perfectly uniform — every number from 1 to 1000 is
  equally likely, and that distribution has no skew at all. Yet your histograms are
  lopsided. Where did the skew come from?
]

#answer-space(height: 2.4cm)

== Part 4. Which Estimator Would You Take Into a War?

Fill in the table from your simulation of 1000 captures. The true value is 1000.

#v(0.2cm)
#align(center)[
  #table(
    columns: (3.6cm, 2.3cm, 2.3cm, 2.3cm, 2.3cm, 2.6cm),
    inset: 7pt,
    align: center,
    stroke: 0.5pt + rgb("#888888"),
    [], [*mean*], [*median*], [*SD*], [*IQR*], [*within \ 20%*],
    align(left)[`max`], [], [], [], [], [],
    align(left)[`corrected`], [], [], [], [], [],
  )
]
#v(0.2cm)

#question[
  4.1 One estimator is wrong in the same direction every single time. Which one, in which
  direction, and by roughly how much? Explain why it could not have come out any other way.
]

#answer-space(height: 2.2cm)

#question[
  4.2 On a skewed distribution the SD and the IQR tell you different things about the
  spread. Which would you rather quote to a general who has to plan around your estimate,
  and why?
]

#answer-space(height: 2.2cm)

== Part 5. Testing a Claim

Conventional intelligence insists the enemy has 1500 tanks. The largest serial number you
captured was 880.

#question[
  #set par(justify: false)
  5.1 Out of 1000 simulated captures from a fleet of 1500, the fraction whose largest serial
  number came out at 880 or below: #blank(width: 3cm)
]

#question[
  5.2 The general asks whether the 1500 figure is believable. Answer him in three sentences,
  using the number you just computed. Do not use any vocabulary you have not been taught yet.
]

#answer-space(height: 2.4cm)

== Before You Leave

#question[
  #set par(justify: false)
  The true size of the enemy fleet, announced at the end of class: #blank(width: 2.5cm) \
  #v(0.05cm)
  #set par(justify: true)
  Your Part 1 estimate was off by #blank(width: 2cm), your `est_corrected` estimate by
  #blank(width: 2cm). Was the method wrong?
]

#answer-space(height: 1.8cm)

#pagebreak()

= Written Response

Answer both before the next class and bring them with you.

#question[
  R1. Your histograms in Part 3 show a thousand estimates from a thousand captures — but in
  the real war there was only ever one capture, and it either happened or it did not. So
  what are those histograms a picture of?
]

#answer-space(height: 4cm)

#question[
  R2. Last class, a coin split an estate fairly on average and almost never fairly in
  practice. Today, one of your estimators is right on average and rarely right exactly. Say
  what the two situations have in common, and what it means to trust a procedure whose
  individual results you cannot trust.
]

#answer-space(height: 4cm)

#pagebreak()

= Code You Will Need

This is a reference, not a solution. You still have to decide what goes where.

#v(0.2cm)

*Setup — run this first, exactly as written:*

```
from datascience import *
import numpy as np
%matplotlib inline
import matplotlib.pyplot as plt
plt.style.use('fivethirtyeight')
import collections as collections
import collections.abc as abc
collections.Iterable = abc.Iterable
```

*Making and drawing from arrays:*

```
np.arange(1, 1001)                          # the numbers 1 through 1000
make_array(2, 6, 7, 14)                     # an array of specific values
np.random.choice(serials, 5, replace=False) # capture 5 different tanks
len(sample)                                 # how many values are in an array
```

*Summarizing an array:*

```
max(sample)             np.mean(sample)          np.median(sample)
np.std(sample)          np.percentile(sample, 25)
np.mean(estimates >= 800)   # the fraction of values that satisfy a condition
```

*Repeating something 1000 times and keeping the answers:*

```
results = make_array()

for i in np.arange(1000):
    sample = np.random.choice(serials, 5, replace=False)
    results = np.append(results, max(sample))
```

*Tables and histograms:*

```
t = Table().with_columns('max', max_estimates, 'corrected', corrected_estimates)

bins = np.arange(0, 2001, 50)
t.hist('max', bins=bins)
plt.title('Estimator: max');
```

#v(0.3cm)

*Two rules for today.* Run every loop with 10 repetitions and read the output before you run
it with 1000 — a bug is obvious in ten numbers and invisible in a thousand. And test every
function on values you can check by hand before you trust it with anything.
