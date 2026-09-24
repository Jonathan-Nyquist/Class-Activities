#set document(
  title: "Honors Class 10 Instructor Notes: Splitting the Difference",
  author: "Elements of Data Science",
)

#set page(paper: "us-letter", margin: (x: 1in, y: 1in))
#set par(justify: true, leading: 0.65em)
#set heading(numbering: none)
#set text(font: "Liberation Serif", size: 11pt, lang: "en", region: "us")

#show raw.where(block: true): it => block(
  fill: rgb("#f2f2f2"), inset: 8pt, radius: 3pt, width: 100%, breakable: false,
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

#let part-heading(title, minutes: none) = heading(level: 2)[
  #title #if minutes != none [#h(1fr) #text(weight: "regular", size: 10pt)[(≈ #minutes min)]]
]

#let note(body) = block(
  width: 100%, inset: 8pt, radius: 3pt,
  fill: rgb("#eef4fb"), stroke: (left: 2pt + rgb("#3a6ea5")),
  [*Note.* #body],
)
#let warn(body) = block(
  width: 100%, inset: 8pt, radius: 3pt,
  fill: rgb("#fdf1e6"), stroke: (left: 2pt + rgb("#c0661a")),
  [*Watch out.* #body],
)
#let ans(label, body) = block(
  width: 100%, inset: (left: 8pt, top: 3pt, bottom: 3pt),
  stroke: (left: 2pt + rgb("#4a4a4a")),
  [*#label* #h(0.3em) #body],
)

= Splitting the Difference — Instructor Notes

#align(center)[#text(style: "italic")[Class 10 · expected value vs. distribution · paper and coins, no notebook]]

#v(0.2cm)

*The idea.* A procedure can be perfectly fair _in expectation_ and still hand out lopsided
outcomes almost every time. The inventory is rigged to make this unmissable: the lake cabin
(\$60,000) is worth exactly as much as every other item combined. Whoever wins that one flip is
ahead no matter how the other eleven fall, so the aunt's share is bimodal, with humps near
\$30,000 and \$90,000 and a nearly empty middle right where the expected value sits.

*What students produce.* A prediction, two settlements per team, a class histogram, and
written answers to eleven questions. *What this does not claim to teach:* how to compute a
distribution formally, or fair-division theory. 4.4 touches that theory, but only as discussion.

*Materials.* One coin per team. A pre-drawn 12-bin histogram on the board (\$0–120k in \$10k bins,
matching the handout). Optional: the projection code in the appendix.

== Timing (50 min)

#table(
  columns: (1fr, 1.3cm, 3fr),
  inset: 5pt,
  stroke: 0.5pt + rgb("#888888"),
  [*Segment*], [*Min*], [*What happens*],
  [Setup + Part 1], [5], [Read the scenario aloud. Students commit to 1.1 and 1.2 in ink. Tally the 1.2 answers on the board _before_ any flipping.],
  [Part 2], [10], [24 flips per team (12 items × 2 rounds), add up totals, post both aunt totals.],
  [Part 3], [12], [Build the histogram, answer 3.1–3.5. Reveal the exact distribution (below).],
  [Part 4], [21], [Discussion. 4.1 and 4.5 are the ones that matter most; 4.3 carries the quantitative point.],
  [Buffer], [2], [],
)

#warn[The 50-minute budget is an estimate. Trim 4.2 or 4.4 first if you're short on time; keep 4.1, 4.3 and 4.5.]

== The numbers (exact: all $2^12 = 4096$ equally likely settlements enumerated)

#table(
  columns: (2.3fr, 1.4fr, 2.3fr),
  inset: 5pt,
  stroke: 0.5pt + rgb("#888888"),
  [], [*Original*], [*4.3 variant (cabin → 4 × \$15k)*],
  [Expected aunt share], [\$60,000], [\$60,000],
  [SD of aunt share], [\$32,068], [\$18,798],
  [P(aunt within \$10k of even)], [4.0% (164/4096)], [40.3%],
  [P(exactly \$60,000)], [0.10% (4/4096)], [—],
  [Expected gap (aunt − uncle, absolute)], [*\$60,000*], [\$30,339],
  [Median gap], [\$60,000], [\$26,000],
  [Shape], [two humps, near \$30k and \$90k], [one hump, centered \$60k],
)

#block(breakable: false)[
Exact bin probabilities for the aunt's share (left-closed bins, \$000s):

#table(
  columns: (1.1fr,) * 12,
  inset: 3pt,
  align: center,
  stroke: 0.5pt + rgb("#aaaaaa"),
  ..([0–10], [10–20], [20–30], [30–40], [40–50], [50–60], [60–70], [70–80], [80–90], [90–100], [100–110], [110–120]).map(x => text(size: 8pt, x)),
  ..([1.8], [7.9], [14.9], [15.0], [8.4], [2.0], [1.9], [7.9], [14.9], [15.0], [8.4], [2.0]).map(x => text(size: 8pt, x + [%])),
)
#text(size: 9pt)[The last bin includes the \$120,000 outcome (0.05%). The 4.3 variant's bins run
0.2, 1.2, 4.0, 9.1, 15.2, 19.7, 19.7, 15.6, 9.4, 4.3, 1.3, 0.2%.]
]

#note[*Why the expected gap is exactly \$60,000.* Let _R_ be the value of the non-cabin items the
cabin _loser_ takes. The cabin winner has \$60,000 + (\$60,000 − _R_), the loser has _R_, and the gap
is \$120,000 − 2#emph[R]. By symmetry _R_ averages \$30,000, so the gap averages \$60,000. On average
the settlement is off by one entire expected share. This is the number to write on the board at the
end of Part 3.]

#warn[*Bin edges.* Every aunt total is a multiple of \$500, and 216 of the 4096 outcomes (5.3%) land
_exactly_ on a bin edge (\$20k, \$30k, \$40k, \$80k, \$90k, \$100k are the common ones). Announce the
convention before teams post: *a total on an edge goes in the bin to its right*, so \$60,000 goes in 60–70.]

#warn[*Few marks.* With teams of 4–5, a section of about 20 posts only about 10 settlements. At
$n = 10$ the two humps may not both show clearly, and there is a 66% chance that _no_ settlement
lands within \$10k of even. The empty middle makes the point by itself, but if you have spare
coins, have each team run a second aunt/uncle pair so there are 4 settlements per team. Either way,
project the exact distribution after the class histogram is up.]


#part-heading([Part 1. Predict First], minutes: 5)

#ans[1.1][\$60,000 is correct. Each item goes to the aunt with probability ½, so she expects half of
every appraised value. Almost everyone gets this; that's the setup, not the payoff.]

#ans[1.2][Tally the circles on the board. The answer depends on how students read "how far from an even split":]

#align(center)[
#table(
  columns: (2.6fr, 1.2fr, 1.4fr, 1.5fr, 1.3fr),
  inset: 4pt,
  stroke: 0.5pt + rgb("#888888"),
  [], [under \$5k], [\$5k–15k], [\$15k–30k], [over \$30k],
  [Gap between aunt and uncle], [0.3%], [1.7%], [7.6%], [*90.4%*],
  [Aunt's distance from \$60k (= gap ÷ 2)], [0.9%], [9.5%], [40.4%], [49.2%],
)]

#warn[1.2 is ambiguous as written, and the two readings differ by a factor of two. Part 2 defines
"Gap" as the aunt–uncle difference, so use the first row as the answer key. The most common
student answer is probably "under \$5,000" or "\$5,000–15,000", which the first row puts at about 2%
combined. Consider rewording the handout to "How far apart do you expect your aunt's and uncle's
totals to be?"]

#part-heading([Part 2. The Settlement], minutes: 10)

#ans[2.1][Varies. *Quick check:* aunt + uncle must equal \$120,000, and Gap = |aunt − uncle| =
|2 × aunt − 120,000|. The cabin winner is never behind; the only ties are the 4 exact \$60,000 splits.]

#note[Bruno has to be flipped too, even though he adds \$0. Students will notice who "won" the dog,
and 4.2 depends on them noticing.]

#part-heading([Part 3. The Class Distribution], minutes: 12)

#ans[3.1][Say which "center" you mean. Class *mean* for 10 settlements: 90% of classes land between
\$43k and \$77k (\$49k–71k for 24 settlements), so it will usually be near \$60k. Class *median* is
unstable because the distribution is bimodal: for 24 settlements its 90% range is \$36k–84k.
If the median lands in one of the humps, point that out. It's 3.5 arriving early.]

#ans[3.2][Truth: 4.0%. Expected count about 0.4 of 10 settlements and about 1 of 24. Zero is the most
likely class result (66% at $n=10$, 38% at $n=24$).]

#ans[3.3][Two humps, near \$30k and \$90k, mirror images of each other, with a near-empty valley at \$60k
(bimodal, symmetric). Cause: the cabin is half the estate and equals everything else combined. The
cabin flip decides which hump you are in; the other eleven items only spread you out within that
hump (SD of the non-cabin share is \$11,330). Strong answers mention *both* facts: the cabin is large,
and it is exactly \$60k.]

#ans[3.4][Varies. The class maximum is typically about \$94k for 10 settlements (90% range \$76k–113k) and
about \$102k for 24. The largest possible gap is \$120,000, one party getting every item with value
(4 of 4096 settlements).]

#ans[3.5][The mean is a balance point, not a typical value. Two humps at \$30k and \$90k balance at
\$60k, but hardly anyone lives there. Push for the gap number: the _expected gap_ is also \$60,000.
The procedure is exactly even on average and, on average, off by an entire half of the estate.]

#part-heading([Part 4. Discussion], minutes: 21)

#ans[4.1][*Ex ante* (procedural) fairness: before the flips, the rules are symmetric and each party's
expected share is \$60,000. That's the uncle's meaning. *Ex post* (outcome) fairness: the actual
split after the coin lands. That's the aunt's meaning; she lost the cabin flip. Both are
legitimate uses of the word, and the coin only guarantees the first.]

#ans[4.2][The ring (it's _grandmother's_; whose grandmother?), the piano (whoever plays it), the
comic books, the cabin (memories, location). An appraisal gives market value, not what each person
values. A consequence worth drawing out: since the coin ignores preferences, trading after the flips
could leave _both_ people better off, so the coin isn't even efficient. Bruno: a \$0 appraisal
ignores attachment. Arguably his value is negative in cost terms (food, vet) and large in
attachment terms.]

#ans[4.3][One hump centered at \$60k. SD falls from \$32.1k to \$18.8k, P(within \$10k of even) rises from
4.0% to 40.3%, and the expected gap halves, \$60,000 → \$30,339. Fairer *ex post*; *ex ante* is
unchanged (still \$60k each, still a symmetric procedure). The point: spread depends on how lumpy the
items are, not only on how many there are. It's a preview of why averages of many comparable
pieces settle down.]

#note[If someone asks: the extreme \$120,000 gap is still possible in the variant, just rarer (4 in
32,768 vs. 4 in 4096).]

#ans[4.4][Anything defensible. Common good ones: sell everything and split the cash (requires selling,
destroys sentimental value); alternating picks, draft-style (requires stated preferences and a rule
for who picks first); one divides, the other chooses; bid on each item with cash payments to
equalize, as in Brams & Taylor's Adjusted Winner. The graded part is the second sentence: every good
answer requires the aunt and uncle to _reveal preferences, negotiate, or pay cash_, which is exactly the
cooperation the coin let them skip.]

#ans[4.5][From the _variance_, not bias. The procedure is unbiased, but they only get one draw from a
wide, lumpy distribution, and there's no repeated trial to average it out. Fair expected value is a
statement about the long run; a divorce happens once. That sentence is the takeaway for the class.]

#v(0.4cm)

== Appendix A: simulation code (instructor only)

Runs on the hub. It simulates the settlement 10,000 times; the result matches the exact
enumeration above to within sampling noise (one verified run: mean \$59,982, 4.2% within \$10k; the 4.3 inventory gave \$60,299 and 40.2%).
Change `values` to the 4.3 inventory to show the one-hump version.

```python
values = make_array(60000, 14000, 11000, 8500, 7000, 5500,
                    4500, 3500, 2500, 2000, 1500, 0)

aunt_totals = make_array()
for i in np.arange(10000):
    flips = np.random.choice([0, 1], len(values))
    aunt_totals = np.append(aunt_totals, sum(flips * values))

Table().with_column("Aunt's share", aunt_totals).hist(bins=np.arange(0, 130000, 10000))
np.mean(abs(aunt_totals - 60000) <= 10000)
```

4.3 inventory:

```python
values = make_array(15000, 15000, 15000, 15000, 14000, 11000, 8500,
                    7000, 5500, 4500, 3500, 2500, 2000, 1500, 0)
```

#v(0.4cm)

== Appendix B: exact distribution (instructor only)

This code lists every possible settlement instead of simulating them. The histogram it draws is the
exact distribution, and its numbers match the key: 4,096 settlements, mean 60.0, 4.0% within \$10k of
even. Values are in thousands of dollars so the axis matches the handout and a bar height of 1.5
(percent per \$1k) means 15% of settlements in that \$10k bin. For the 4.3 variant, set `values = make_array(15, 15, 15, 15, 14, 11, 8.5, 7, 5.5, 4.5, 3.5, 2.5, 2, 1.5, 0)`: 32,768 settlements in one hump centered on 60, 40.3% within \$10k of even.

```python
from datascience import *
import numpy as np
import matplotlib.pyplot as plots
%matplotlib inline

# Appraised values in $ thousands (matches the handout's axis)
values = make_array(60, 14, 11, 8.5, 7, 5.5,
                    4.5, 3.5, 2.5, 2, 1.5, 0)

# Start with one settlement: the aunt has nothing yet.
# For each item, every settlement so far splits in two:
# one where the aunt gets the item, one where she doesn't.
aunt_totals = make_array(0)
for i in np.arange(len(values)):
    aunt_totals = np.append(aunt_totals, aunt_totals + values.item(i))

print("Number of settlements:", len(aunt_totals))                       # 4096
print("Average:", np.mean(aunt_totals))                                 # 60.0
print("Within $10k of even:", np.mean(abs(aunt_totals - 60) <= 10))     # 0.04

settlements = Table().with_column("Aunt's share ($ thousands)", aunt_totals)
settlements.hist(bins=np.arange(0, 130, 10))
plots.axvline(60, color="black", linestyle="--")
plots.title("All 4096 settlements, equally likely");
```

=== How the algorithm works

The loop runs *12 times, once per item, not 4,096 times.* On each pass the array of settlements
doubles. Every settlement built so far is copied twice: once where the aunt does not get the item (the
old totals, unchanged) and once where she does (the old totals plus the item's value).
`np.append(aunt_totals, aunt_totals + values.item(i))` joins those two lists. After 12 passes the array
holds $2^12 = 4096$ totals.

Trace with only the first three items (60, 14, 11):

#align(center)[
#table(
  columns: (2.6cm, 7.2cm, 1.6cm),
  inset: 5pt,
  align: (left, left, center),
  stroke: 0.5pt + rgb("#888888"),
  [*After item*], [*`aunt_totals`*], [*Count*],
  [start], [0], [1],
  [cabin (60)], [0, 60], [2],
  [truck (14)], [0, 60, 14, 74], [4],
  [sailboat (11)], [0, 60, 14, 74, 11, 71, 25, 85], [8],
)]

Each entry is one complete coin-flip outcome. For example, 25 is truck + sailboat without the cabin.
Nine more items bring the count to 4,096.

*Why a plain histogram is exact.* Every flip is fair and independent, so all 4,096 settlements are
equally likely. The fraction of the list in each bin is exactly that bin's probability. There's no
sampling noise, which is the difference from Appendix A.

*Limits.* The list doubles with every item, so this is practical only for small inventories: 15 items
give 32,768 settlements, but 40 items would give about $10^12$. That's where simulation takes over.
