#set document(
  title: "Honors Class 16 Activity: Compared to What?",
  author: "Elements of Data Science",
  keywords: ("data science", "honors", "normal distribution", "central limit theorem", "standardization", "z-score", "activity"),
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

= Compared to What?

#set par(justify: false)
*Team Members:* #blank(width: 3.4cm) #h(0.2cm) #blank(width: 3.4cm) #h(0.2cm) #blank(width: 3.4cm)

#v(0.2cm)
#h(2.55cm) #blank(width: 3.4cm) #h(0.2cm) #blank(width: 3.4cm)
#set par(justify: true)

#v(0.2cm)

On March 22, 2022, four teams of students walked Pennypack Creek and collected 39 water
samples, headwaters to the Delaware. One of them is hiding a road salt source. Today you will
fail to find it, then find it.

Open `Class16_Compared_To_What_Skeleton.ipynb`. Answer here, on paper.

Standardizing a value means subtracting the mean and dividing by the standard deviation:

#v(0.1cm)
#align(center)[
  $ z = (x - macron(x)) / sigma $
]
#v(0.1cm)

The result is a #emph[z-score] --- how many standard deviations a value sits from the mean.
It has no units, which is the whole point.

#question[
  #set par(justify: false)
  0.1 Two students measure the same water sample. One reports chloride in mg/L, the other in
  parts per million. Do their z-scores differ? #h(0.6cm) YES #h(1cm) NO \
  #v(0.1cm)
  #set par(justify: true)
  In one sentence, why?
]

#answer-space(height: 1.2cm)

== Part 1. The Wrong Outlier #h(1fr) #text(size: 9pt, style: "italic", weight: "regular")[20 minutes]

You have been taught a rule: values more than #box(stroke: 0.5pt, inset: 3pt)[2 standard
deviations] from the mean deserve a second look; more than 3 and they are outliers. Chloride
in an urban stream comes mostly from road salt, so an unusual chloride value should point you
at a source. Apply the rule.

#question[
  #set par(justify: false)
  1.1 From the notebook: mean chloride #blank(width: 2.2cm) mg/L #h(0.8cm)
  standard deviation #blank(width: 2.2cm) mg/L \
  #v(0.15cm)
  Sites the rule flags, and how far downstream each one is: \
  #v(0.1cm)
  #h(0.4cm) #blank(width: 2.6cm) at #blank(width: 1.6cm) km #h(1.2cm)
  #blank(width: 2.6cm) at #blank(width: 1.6cm) km
]

#question[
  #set par(justify: false)
  1.2 Now the three #emph[highest] chloride samples. The largest is #blank(width: 2.4cm) mg/L
  at site #blank(width: 2cm), with $z = $ #blank(width: 1.6cm) \
  #v(0.1cm)
  Did the rule flag it? #h(0.6cm) YES #h(1cm) NO
]

#question[
  1.3 #emph[Commit before you plot.] Which single sample would you send someone back out to
  investigate as a road salt source, and which sites do you think the rule should have
  flagged? Write it down now; you do not get to revise it.
]

#answer-space(height: 1.3cm)

#question[
  1.4 Run the scatter plot of chloride against distance downstream. Describe the shape of the
  data in one sentence --- specifically, what happens around 7 km.
]

#answer-space(height: 1.3cm)

#question[
  1.5 The rule flagged the two most pristine sites in the creek and missed the highest
  chloride value in the dataset. Using your plot, explain what assumption the rule makes that
  this data violates.
]

#answer-space(height: 1.7cm)

The fix is not a stricter threshold. It is a better #emph[comparison group]. The creek changes
character at the wastewater treatment plant near km 8, so compute z-scores separately above
and below it --- each sample judged against points that resemble it.

#question[
  #set par(justify: false)
  1.6 Upstream ($n = $ #blank(width: 1cm)): flagged site #blank(width: 2.2cm)
  with $z = $ #blank(width: 1.6cm) \
  #v(0.1cm)
  Does it match your answer to 1.3? #h(0.6cm) YES #h(1cm) NO
]

#question[
  1.7 The headwater sites are no longer flagged, and nothing about their chloride
  concentrations changed. What changed?
]

#answer-space(height: 1.4cm)

#question[
  1.8 Go back to the map in your mini-project notebook, or open satellite imagery for the
  flagged site. It sits #emph[upstream] of the treatment plant outfall, which rules out the
  obvious suspect. What do you see there instead?
]

#answer-space(height: 1.4cm)

== Part 2. Many Means #h(1fr) #text(size: 9pt, style: "italic", weight: "regular")[17 minutes]

Different question. Your 39 samples came from one morning. If the class walked the creek
again next week, how much would the #emph[average] move?

Dr. Toran left a nitrate logger below the treatment plant recording every hour for two weeks
--- 330 readings. Treat those as a population and sample from it.

#question[
  #set par(justify: false)
  2.1 Look at the histogram of all 330 readings with a normal curve drawn on top. Are these
  data normally distributed? #h(0.6cm) YES #h(1cm) NO \
  #v(0.1cm)
  #set par(justify: true)
  Describe the shape in one sentence.
]

#answer-space(height: 1.2cm)

#question[
  #set par(justify: false)
  2.2 Now draw 2,000 samples of size $n$ and histogram their means. Name #emph[two] things
  that change as $n$ goes from 1 to 6 to 24.
]

#answer-space(height: 1.2cm)

#question[
  #set par(justify: false)
  2.3 The narrowing follows an exact rule, $"SD"("sample mean") = sigma \/ sqrt(n)$.
  Fill in from the notebook: \
  #v(0.15cm)
  #align(center)[
    #table(
      columns: (1.8cm, 3.6cm, 3.6cm),
      inset: 6pt,
      align: (center, center, center),
      stroke: 0.5pt + rgb("#888888"),
      [*n*], [*simulated SD*], [$sigma \/ sqrt(n)$],
      [6], [], [],
      [24], [], [],
      [100], [], [],
    )
  ]
  #v(0.1cm)
  #h(0.4cm) To cut the spread of the sample mean in half, $n$ must increase by a factor of
  #blank(width: 1.6cm) #h(0.6cm) #text(size: 9pt, style: "italic", weight: "regular")[(use the formula, not a guess)]
]

#question[
  2.4 The population you just sampled is not remotely bell-shaped, yet the distribution of its
  sample means is. State that finding as a general rule in one sentence. It has a name --- use it.
]

#answer-space(height: 1.3cm)

== Part 3. How Sure Is the Average? #h(1fr) #text(size: 9pt, style: "italic", weight: "regular")[8 minutes]

Back to the creek. Thirty chloride samples sit downstream of the treatment plant.

#question[
  #set par(justify: false)
  3.1 From the notebook, for those 30 samples: \
  #v(0.15cm)
  #h(0.4cm) mean #blank(width: 2cm) mg/L #h(0.7cm) standard deviation #blank(width: 2cm) mg/L
  #h(0.7cm) standard error #blank(width: 2cm) mg/L \
  #v(0.15cm)
  #h(0.4cm) 95% confidence interval: #blank(width: 2cm) to #blank(width: 2cm) mg/L
]

#question[
  3.2 Two of those numbers are about 28 and about 5. They describe completely different
  things. Which is which, and what does each one tell you?
]

#answer-space(height: 1.6cm)

#question[
  #set par(justify: false)
  3.3 The EPA drinking water standard for chloride is 250 mg/L. For each question below,
  circle what you would actually need in order to answer it. \
  #v(0.2cm)
  #h(0.4cm) "Does the #emph[average] chloride downstream exceed the standard?" \
  #v(0.1cm)
  #h(1.2cm) the standard deviation #h(1cm) the standard error #h(1cm) the individual measurements \
  #v(0.25cm)
  #h(0.4cm) "Does #emph[any individual location] exceed the standard?" \
  #v(0.1cm)
  #h(1.2cm) the standard deviation #h(1cm) the standard error #h(1cm) the individual measurements \
  #v(0.25cm)
  #set par(justify: true)
  One site in the creek does exceed 250 mg/L. Which one, and is it downstream?
]

#answer-space(height: 1.2cm)

== Discussion #h(1fr) #text(size: 9pt, style: "italic", weight: "regular")[5 minutes]

In Class 15 you built a null distribution by shuffling labels. Watch the same thing happen
with the Pennypack nitrate data: 20,000 shuffles, testing whether nitrate differs above and
below the treatment plant.

#question[
  #set par(justify: false)
  D1. Number of shuffles at least as extreme as the observed difference: #blank(width: 1.6cm)
  #h(1cm) so $p = $ #blank(width: 1.6cm) \
  #v(0.15cm)
  #set par(justify: true)
  A p-value of exactly zero cannot be right --- the observed result obviously #emph[can]
  happen under the null, since it happened. Explain what the simulation is actually telling
  you, and why running a million shuffles would not fix it.
]

#answer-space(height: 1.9cm)

#question[
  D2. That null distribution is bell-shaped, and Part 2 explains why. Standardizing the
  observed difference against it gives $p approx 5 times 10^(-7)$. In one sentence, say what
  standardizing let you do that counting could not --- and note that this is the same move you
  made back in Part 1.
]

#answer-space(height: 1.9cm)
