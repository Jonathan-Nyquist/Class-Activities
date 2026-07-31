#set document(
  title: "Honors Class02 Activity: Data to Die For…",
  author: "Elements of Data Science",
  keywords: ("data science", "honors", "probability", "distributions", "activity"),
)

#set page(
  paper: "us-letter",
  margin: (x: 1in, y: 1in),
)

#set par(justify: true, leading: 0.65em)
#set heading(numbering: none)
#set text(font: "Liberation Serif", size: 11pt, lang: "en", region: "US")

// ── Heading styles ─────────────────────────────────────────────────────────

#show heading.where(level: 1): it => align(center)[
  #block(above: 0em, below: 1.2em)[
    #text(size: 16pt, weight: "bold")[#it.body]
  ]
]

#show heading.where(level: 2): it => block(
  below: 0.6em,
  above: 1.2em,
)[#text(weight: "bold", size: 11pt)[#it.body]]

// ── Helpers ────────────────────────────────────────────────────────────────

#let blank(width: 5cm) = box(
  width: width,
  stroke: (bottom: 0.5pt),
  inset: (bottom: 2pt),
  []
)

#let question(body) = block(above: 0.8em, below: 0.2em)[*#body*]

#let answer-space(height: 1.5cm) = block(
  width: 100%,
  height: height,
  []
)

// ── Title ──────────────────────────────────────────────────────────────────

= Honors Class02 Activity: Data to Die For…

*Team Members:* #line(length: 9cm, stroke: 0.5pt)

#line(length: 100%, stroke: 0.5pt)

// ── Learning Objectives ────────────────────────────────────────────────────

== Learning Objectives

- Plotting data by hand
- Probability Distributions
- Sample distributions and sample size

// ── Activity Introduction ──────────────────────────────────────────────────

== Activity Introduction #footnote[This activity and the associated graphic were adapted in large part from the excellent introduction: #link("http://pages.stat.wisc.edu/~ifischer/Intro_Stat/Lecture_Notes/4_-_Classical_Probability_Distributions/4.1_-_Discrete_Models.pdf")]

This activity introduces several concepts we will revisit throughout the semester, including
probability, and sample size. Just for this one activity, you'll be plotting the data by hand
because, hey, everyone needs to remember what it was like before computers!

If you roll a single die, there are six possible outcomes: $S = {1, 2, 3, 4, 5, 6}$. If the die
is not loaded these outcomes are equally likely, so each has a one in six chance of occurring or
a probability of $1\/6$, where 0 means no chance and 1 means 100% certainty. Because each
outcome is equally likely, the distribution of probabilities is "uniform."

#figure(
  image("sample_space.png", width: 88%, alt: "A 6-by-6 grid listing all 36 ordered pairs of outcomes when rolling two dice, from (1,1) to (6,6). The sample space S has 36 elements."),
  caption: [Sample space for two dice: all 36 equally likely outcomes],
)

// ── Experiment ─────────────────────────────────────────────────────────────

== Experiment

The sum of the two dice is any integer between 2 and 12, but the probability distribution is no
longer uniform. Let's find it experimentally.

On the graph paper provided, you will plot the frequency distribution, which is the number of
times each value occurred in the data sample. For example, if you had one 2, one 3, two 4's,
three 5's, four 6's, six 7's, three 8's, one 9, two 10's and one 12, your plot would look like
this:

#figure(
  image("hist_by_hand.png", width: 88%, alt: "A hand-drawn dot plot on graph paper showing an example frequency distribution for dice sums 1 through 12, with stacked X marks. The distribution peaks near 6 and 7."),
  caption: [Example hand-drawn frequency distribution],
)

== Data from 50 rolls of a pair of dice

#figure(
  table(
    columns: (1fr,) * 10,
    stroke: (x, y) => if y == 0 { (bottom: 0.5pt) } else { none },
    align: center,
    inset: (x: 6pt, y: 4pt),
    [7],[11],[5],[3],[8],[6],[6],[9],[5],[4],
    [9],[7],[10],[5],[7],[6],[6],[7],[10],[8],
    [7],[4],[6],[8],[11],[4],[6],[5],[7],[9],
    [10],[8],[5],[8],[12],[9],[7],[5],[6],[10],
    [9],[4],[6],[3],[8],[7],[9],[8],[7],[7],
    [3],[6],[5],[11],[7],[5],[8],[8],[7],[6],
    [4],[10],[7],[9],[6],[5],[8],[3],[7],[7],
    [6],[9],[10],[4],[9],[7],[11],[8],[8],[7],
    [6],[7],[9],[6],[7],[8],[6],[5],[8],[5],
    [7],[9],[9],[9],[5],[9],[9],[10],[6],[9],
  ),
  caption: [Raw data: sums from 50 rolls of two dice],
)

#figure(
  image("small_graph_paper.png", width: 80%, alt: "Blank graph paper provided for students to plot their frequency distribution by hand."),
  caption: [Graph your data here],
)

What you have just created is a data histogram, a way to visualize the distribution of a data
sample. Once you learn some Python coding, you'll no longer have to plot these by hand. (And
there was much rejoicing.)

#question[Based on your histogram, what is the most likely sum when you roll two dice?]
#answer-space(height: 1.2cm)

#question[Least likely?]
#answer-space(height: 1.2cm)

Here's the histogram from a 10,000-roll simulation, which now closely matches the expected
probability distribution for the sum of two fair dice.

#figure(
  image("hist10_000.png", width: 90%, alt: "A bar chart titled 'Histogram of 10,000 Rolls of Two 6-Sided Dice.' The x-axis shows sums from 2 to 12 and the y-axis shows frequency. The distribution is roughly triangular, peaking at 7 with about 1,650 occurrences."),
  caption: [Histogram for 10,000 rolls],
)

Based on a simulation of 10,000 rolls, the most likely sum is 7.

// ── Discussion Questions ───────────────────────────────────────────────────

== Discussion Questions

When you rolled two dice, you were no longer working with a uniform distribution.
#question[What changed between rolling one die and rolling two dice?]
#answer-space(height: 1.5cm)

Look at your hand-drawn frequency histogram.
#question[Are the peaks more reliable than the tails, or vice versa?]
#answer-space(height: 1.5cm)

Your histogram might not show 7 as the most frequent outcome, even though the 10,000-roll
simulation does.
#question[Does that mean your data contradicts probability theory?]
#answer-space(height: 1.5cm)

#question[What would it mean, statistically, to say your result is "wrong"?]
#answer-space(height: 1.5cm)

Suppose you repeated this activity with:

- 30 rolls
- 300 rolls
- 3,000 rolls

#question[At which point would you feel comfortable predicting the most likely sum for future rolls? Why?]
#answer-space(height: 1.5cm)

#question[This activity is about dice — but what other kinds of real data behave similarly?]
Consider, for example, medical trials, or polling data.
