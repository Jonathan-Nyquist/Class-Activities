#set document(
  title: "Honors Class 08 Activity: What Does \"Current\" Mean?",
  author: "Elements of Data Science",
  keywords: ("data science", "honors", "matplotlib", "pyplot", "figures", "axes", "activity"),
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
  #block(above: 12pt, below: 6pt, it.body)
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

#let code-line() = block(above: 8pt, below: 8pt)[
  #box(width: 100%, height: 1.1em, stroke: (bottom: 0.5pt + black))
]

= Honors Class 08 Activity: What Does "Current" Mean?

#par(justify: false)[
  #box(width: 3.2cm)[*Team Members:*] #blank(width: 3.9cm) #h(0.4cm) #blank(width: 3.9cm) #h(0.4cm) #blank(width: 3.9cm)
]
#v(-0.15cm)
#par(justify: false)[
  #h(3.2cm) #blank(width: 3.9cm) #h(0.4cm) #blank(width: 3.9cm)
]

#v(0.15cm)

Working in the Class 08 matplotlib notebook. Predict first, then run. A
prediction you got wrong is worth more than one you got right, so write down the wrong one before you fix it.

== Part 1: Decode the Format String (5 minutes)

The notebook shows you `"-o"` and `"-ro"`. Fill in this table *from reasoning alone*,
then test each one with `plt.plot(x, y, ...)`.

#align(center)[
  #table(
    columns: (3cm, 3.4cm, 3.4cm, 3.4cm),
    align: (center, center, center, center),
    inset: 7pt,
    [*Format string*], [*Connecting line?*], [*Marker shape?*], [*Color?*],
    [`"ro"`], [], [], [],
    [`"g^"`], [], [], [],
    [`"--k"`], [], [], [],
  )
]

#question[
  Problem 1: Which of your three predictions was wrong, and what rule were you using that
  turned out to be false?
]

#answer-space(height: 1.6cm)

== Part 2: One Cell or Two? (7 minutes)

Put these two lines together in a single cell and run it:

```python
plt.plot(x, y1)
plt.plot(x, y2)
```

Now split them: put the first line in one cell, the second line in a new cell below it,
and run both.

#question[
  Problem 2: Before you run the split version — predict. (circle one)

  #h(0.6cm) A. Two curves on one plot, same as before #h(0.8cm)
  B. Two separate plots, one curve each

  Now run it. Which happened?
]

#answer-space(height: 1.4cm)

#question[
  Problem 3: Nothing about the two `plt.plot` lines changed. Only where they live changed.
  So what does a cell boundary *do* to a plot?
]

#answer-space(height: 2.2cm)

== Part 3: A Table Plot Is a Matplotlib Plot (8 minutes)

The notebook says the `datascience` table is "calling matplotlib" behind the scenes. Test
that claim. In one cell, run `poly.plot("x", ["y1", "y2"])` and then, on the next line of
the *same* cell, add a title with `plt.title(...)`.

#question[
  Problem 4: Did the title land on the table's plot? What does that tell you about what
  `poly.plot()` actually is?
]

#answer-space(height: 2cm)

Now move the `plt.title(...)` line into a cell of its own, below the `poly.plot` cell, and
run both.

#question[
  Problem 5: Predict first, then run. Describe exactly what appeared — including anything
  that appeared that you were not expecting.
]

#answer-space(height: 2.4cm)

#question[
  Problem 6: Write the one-sentence rule you would give a classmate about where plotting
  code has to live in a notebook, and why `plt.title` needs that rule but
  `poly.plot("x", "y1")` does not.
]

#answer-space(height: 2.6cm)
