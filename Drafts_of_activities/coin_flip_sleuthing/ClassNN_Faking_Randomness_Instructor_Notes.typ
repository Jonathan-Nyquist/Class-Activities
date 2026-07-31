#set document(
  title: "Instructor Notes: Faking Randomness",
  author: "Elements of Data Science",
  keywords: ("data science", "honors", "randomness", "simulation", "facilitation notes"),
)

#set page(
  paper: "us-letter",
  margin: (x: 1in, y: 1in),
)

#set par(justify: true, leading: 0.65em)
#set heading(numbering: none)
#set text(font: "Liberation Serif", size: 11pt, lang: "en", region: "US")

// ── Heading styles ─────────────────────────────────────────────────────────

#show heading.where(level: 2): it => block(
  above: 1.2em, below: 0.5em,
)[#text(weight: "bold", size: 12pt)[#it.body]]

#show heading.where(level: 3): it => block(
  above: 1.0em, below: 0.4em,
)[#text(weight: "bold", size: 11pt)[#it.body]]

// ── Helpers ────────────────────────────────────────────────────────────────

#show raw.where(block: false): it => box(
  fill: luma(240),
  inset: (x: 3pt, y: 1pt),
  radius: 2pt,
  text(font: "Liberation Mono", size: 10pt)[#it]
)

#show raw.where(block: true): it => block(
  width: 100%,
  fill: luma(245),
  stroke: (left: 3pt + luma(160)),
  inset: (x: 10pt, y: 8pt),
  radius: 2pt,
  text(font: "Liberation Mono", size: 10pt)[#it]
)

#let question(body) = block(above: 0.6em, below: 0.2em)[*#body*]

#show heading.where(level: 1): it => align(center)[
  #block(above: 0em, below: 1em)[
    #text(size: 16pt, weight: "bold")[#it.body]
  ]
]

= Instructor Notes: Faking Randomness

#v(0.5em)
#line(length: 100%, stroke: 0.5pt)

== What This Activity Is Actually For

That humans are bad at inventing randomness lands in the first ten minutes and is not worth
a class period. The eighty minutes are for two things that are harder to teach: that a
hypothesis test requires _choosing_ a statistic, and that two statistics measuring the same
behavior can differ enormously in how well they work; and that the amount of data a question
needs is a property of the study design, not of the phenomenon. Part 5 is the payoff. If you
are running short, protect it and cut elsewhere.

The activity assumes Lab 05 is complete. It uses `np.random.choice`, `for` loops,
conditionals, and empirical p-values — nothing else — and it applies them to data the class
generates in the room.

== Preparation, About Fifteen Minutes the Night Before

Generate one genuine sequence per student, each tagged with a two-letter code.

```python
import numpy as np
from datascience import *

n_students = 26
rng = np.random.default_rng(20260901)

codes = [chr(65 + i // 26) + chr(65 + i % 26) for i in np.arange(n_students)]
seqs  = [''.join(rng.choice(['H', 'T'], 100)) for i in np.arange(n_students)]

key = Table().with_columns('code', codes, 'sequence', seqs)
key.to_csv('genuine_key.csv')

# Printable cards, ten tosses per line
with open('genuine_cards.txt', 'w') as f:
    for code, seq in zip(codes, seqs):
        lines = [seq[i:i+10] for i in np.arange(0, 100, 10)]
        f.write('ID ' + code + '\n' + '\n'.join(lines) + '\n\n' + '-'*30 + '\n\n')
```

Print `genuine_cards.txt` and cut the cards apart. Bring blank cards of *identical stock*
for the fabricated sequences — if the two cards look different, the demonstration is
worthless. Keep `genuine_key.csv` but do not open it during Part 2.

*The one thing that ruins this activity.* If you instead ask students to flip real coins,
roughly a third will get bored somewhere around toss forty and start inventing. That
contaminates the comparison group silently and teaches the opposite of the intended lesson.
Pre-generating also lets you keep the true labels, which is what makes Part 4 a real test
rather than a demonstration.

== Timing

#table(
  columns: (2cm, 1fr),
  stroke: 0.5pt,
  inset: 7pt,
  align: (left, left),
  [*0–10*], [Production. No framing and no hints — do not say the word "runs." Five minutes of silence, then hand out the genuine cards, shuffle, label, collect.],
  [*10–14*], [Predictions, written before the reveal. Average them on the board. Without this commitment step the reveal is only a magic trick.],
  [*14–26*], [The reveal. Take eight to ten pairs. Scan each for a long run and call the one without it the fake. Narrate your confidence, never your method.],
  [*26–40*], [Part 3. Elicit the statistic, define runs and switches, everyone computes both for both cards and posts switch counts to the board.],
  [*40–58*], [Part 4. Pooled simulation and empirical p-value.],
  [*58–72*], [Part 5. The power sweep. Let teams run it themselves; the discovery is the point.],
  [*72–80*], [Discussion questions. Take the first and the last.],
)

To fit fifty minutes, run Part 5 yourself while talking, about ninety seconds, and assign
the discussion questions as written homework. Do not cut Part 3.

== What to Expect Numerically

Fabricated binary sequences alternate at a rate of about 0.58 to 0.62 in the published
literature, against a true rate of 0.50. At 100 tosses that gives:

#table(
  columns: (5cm, 1fr, 1fr),
  stroke: 0.5pt,
  inset: 7pt,
  align: (left, center, center),
  [], [*Genuine*], [*Fabricated*],
  [Mean switches], [49.5], [about 59],
  [Longest run of 5 or more], [0.97], [0.80],
  [Longest run of 6 or more], [0.81], [0.46],
  [Longest run of 7 or more], [0.54], [0.21],
)

So the rule you are secretly using — no run of six means fabricated — is about 81% specific
and 54% sensitive. Your hit rate on ten pairs will usually land between seven and nine.

*If you go five for ten,* say so immediately and without embarrassment, and put the
binomial calculation on the board: five or fewer out of ten has probability 0.62 under pure
guessing, so this demonstration was nearly uninformative about whether you have any skill.
Then run Part 4 anyway. The pooled test cannot fail — twenty students at 100 tosses gives
1,980 adjacent pairs — and the contrast between an inconclusive parlor trick and a p-value
below 0.001 on the same behavior is a better version of the lesson than a clean sweep would
have been.

Detection rates for a single fabricated sequence, one-sided test at the 5% level:

#table(
  columns: (2.5cm, 1fr, 1fr, 1fr),
  stroke: 0.5pt,
  inset: 7pt,
  align: (center, center, center, center),
  [*Tosses*], [*Rate 0.55*], [*Rate 0.60*], [*Rate 0.65*],
  [30], [0.09], [0.22], [0.41],
  [50], [0.15], [0.38], [0.66],
  [100], [0.21], [0.58], [0.89],
  [200], [0.39], [0.87], [0.99],
  [300], [0.50], [0.96], [1.00],
)

Students should arrive at roughly 170 tosses for 80% detection of one fabricator, against 20
tosses each when pooled across the class. Two orders of magnitude in per-person cost for the
same effect and the same statistic. Write both numbers on the board side by side.

== Answer Notes

*Expected switches.* Each of the 99 adjacent pairs disagrees with probability one half,
independently of the others, so the count is binomial with 99 trials and the expected value
is 49.5, with a standard deviation of about 4.97. Students fresh from Lab 05 will want to
simulate this instead, which is fine, but push at least one student to give the
pair-counting argument out loud.

*Why switches beat the longest run.* The longest run is computed from the whole sequence but
its value is determined by a single stretch of it; nearly all of the 99 pairs have no
influence on the answer. The switch count uses every pair. Sorting a fabricated card from a
genuine one at 100 tosses succeeds about 74% of the time using the longest run and about 92%
using switches. This is a first concrete encounter with a statistic that wastes information,
and it is worth naming as such — it comes back when they meet the sample mean in Module 3.

*One-sided or two.* One-sided is defensible because the direction was specified in advance
from prior knowledge: fabricators alternate too much. Two-sided is also defensible if a
student argues that any departure from randomness is of interest. What is not defensible is
choosing after seeing the board, and that is the real content of the third discussion
question.

*Selective reporting.* You handled all twenty-five pairs and then chose which ten to
attempt. That is selection on the outcome and it biases the hit rate upward. Point out that
you did this in front of them without announcing it, and that this is publication bias in
miniature.

*The individual objection.* The student is not right, and the confusion is the standard one.
The test says nothing about that individual sequence; it is a statement about how often
sequences like theirs arise under the null. A run of six appears in 46% of fabricated
sequences.

== Threads for the Discussion

*The clustering illusion.* Real randomness is lumpier than intuition allows. Feller's
analysis of V-1 impact sites across London is the canonical case — the map looked targeted
and the statistics said Poisson.

*The hot hand.* Gilovich, Vallone and Tversky (1985) used exactly this runs logic to
conclude the hot hand does not exist, and that conclusion sat in textbooks for thirty years.
Miller and Sanjurjo (2018) showed that conditioning on "the previous shot was a make"
induces a selection effect in finite sequences that biases the runs estimator downward, and
that correcting it restores a real effect. This is the best single item in the course for an
honors seminar: a famous, careful, repeatedly replicated null result that turned out to be
an artifact of the estimator rather than a fact about the world. It sits naturally next to
the replication crisis and streetlight effect topics.

*Optional competitive round, add fifteen minutes.* Teams receive ten anonymized sequences
from the other section, five of each kind, and classify them for score. Teams that compute
switch counts beat teams that eyeball for long runs, reliably, and the scoreboard makes the
argument better than you can.
