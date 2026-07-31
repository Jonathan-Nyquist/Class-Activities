#set document(
  title: "Honors Class06 Activity: Practice with Tables — Breakfast Cereals",
  author: "Elements of Data Science"
)

#set page(
  paper: "us-letter",
  margin: (x: 1in, y: 1in),
)

#set text(font: "Liberation Serif", size: 11pt, lang: "en", region: "US")
#set par(justify: true, leading: 0.65em)
#set heading(numbering: none)

// ── Heading styles ─────────────────────────────────────────────────────────

#show heading.where(level: 2): it => block(
  above: 1.2em, below: 0.5em,
)[#text(weight: "bold", size: 12pt)[#it.body]]

#show heading.where(level: 3): it => block(
  above: 1.0em, below: 0.4em,
)[#text(weight: "bold", size: 11pt)[#it.body]]

#show heading.where(level: 4): it => block(
  above: 0.9em, below: 0.3em,
)[#text(weight: "bold", style: "italic", size: 11pt)[#it.body]]

// ── Helpers ────────────────────────────────────────────────────────────────

#let blank(width: 4cm) = box(
  width: width,
  stroke: (bottom: 0.5pt),
  inset: (bottom: 2pt),
  []
)

#let answer-space(height: 1.2cm) = block(width: 100%, height: height, [])

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

// ── Title ──────────────────────────────────────────────────────────────────

#align(center)[
  #text(size: 16pt, weight: "bold")[Honors Class06 Activity: Practice with Tables — Breakfast Cereals]
]

#v(1em)
*Team Members:* #blank(width: 9cm)
#v(0.3em)
#line(length: 100%, stroke: 0.5pt)

// ── Learning Objectives ────────────────────────────────────────────────────

== Learning Objectives

- Read data into tables
- Understanding metadata
- Manipulating data tables

You will be using data tables for just about everything the rest of the semester, so let's
warm up today with an exercise designed to review many of the basic table operations. And
what could be better on a table than some breakfast cereal? We'll start by loading data from
a file.

Open the starter notebook for Class 06. At the start you are provided with metadata
describing the columns in the cereal dataset.

// ── Problems 1–5 ───────────────────────────────────────────────────────────

==== Problem 1

Suppose you are collecting water samples to assess stream quality. Give some examples of
metadata you might record.
#answer-space(height: 1.2cm)

Recall that an array must contain data all of the same type. Most of the data in this table
is numeric.

==== Problem 2: Which columns contain arrays of strings?

#answer-space(height: 1.2cm)

Enter the code below to extract the rating column from the table as an array.

```python
ratings = cereal.column("rating")
ratings
```

==== Problem 3: What are the average, maximum, and minimum ratings for the cereals in this dataset?

#answer-space(height: 1.2cm)

To sort from highest to lowest rating, you can use the `sort()` function with the
`descending=True` option.

==== Problem 4: Which cereal has the highest rating?

#answer-space(height: 1.2cm)

After you've answered the questions above, continue exploring the data table. You might try
to find the cereal with the most sugar, or the one with the highest fiber content.

==== Problem 5: What other interesting facts can you find about the cereals in this dataset?

#answer-space(height: 3cm)

// ── Filtering ──────────────────────────────────────────────────────────────

== Filtering Based on a Condition

This comes up a lot: you want to pull rows from a table based on some condition. For this,
you need the `where()` method.

For example, suppose we want just the cereals with more than 8 grams of fiber per serving.

```python
high_fiber = cereal.where("fiber", are.above(8))
high_fiber
```

Ah, bran cereals! No surprise they are the ones highest in fiber. Now create a table with
just the hot cereals.

==== Problem 6: Which cereals are hot cereals?

#answer-space(height: 2cm)

// ── Multiple Conditions ────────────────────────────────────────────────────

== Applying Multiple Conditions

To filter on multiple conditions, simply apply them one at a time.

Let's look for the cereals high in sodium and sugar — the ones you probably shouldn't eat.
First, find the range of values for each. The code for this is provided in the notebook.

*Negative sugar!?* If such a cereal existed it would be extremely popular as a diet food!
This is almost certainly an error. Data sets often have mistakes — remember this when you do
your own data collection and analysis.

Enter the code below to find any cereals with negative sugar content.

```python
cereal.where("sugars", are.below(0))
```

Oatmeal has both negative sugar and negative carbs. Who knew?

==== Problem 7

Ignoring this obvious flaw in the data, find any cereal with more than 230 milligrams of
sodium *and* more than 10 grams of sugars. (The ones also low in fiber are truly without
redeeming value.)
#answer-space(height: 2cm)

// ── Discussion Questions ────────────────────────────────────────────────────

== Discussion Questions

The activity emphasizes that tables are comprised of columns, and columns are arrays of
data of the same type.

==== Problem 8: At what point does data analysis stop being about computation and start being about judgment?

Point to a specific moment in this activity where that shift occurs.
#answer-space(height: 2cm)

==== Problem 9

The dataset includes negative values for sugar and carbohydrates.
- What are some realistic ways such errors could arise?
- Should these rows be removed, corrected, or flagged? Why?
#answer-space(height: 3cm)

==== Problem 10

Suppose you were to design a data table to track your daily activities (e.g., studying,
exercising, socializing). What columns would you include? Justify your choices.
