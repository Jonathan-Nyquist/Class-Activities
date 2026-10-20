#set document(
  title: "Honors Class 18 Activity: Better Than Guessing",
  author: "Elements of Data Science",
  keywords: ("data science", "honors", "linear regression", "R-squared", "residuals", "extrapolation", "activity"),
)

#set page(paper: "us-letter", margin: (x: 1in, y: 1in))
#set par(justify: true, leading: 0.65em)
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
  #block(above: 14pt, below: 6pt, it.body)
]

#let question(body) = block(
  width: 100%,
  inset: (left: 8pt, top: 4pt, bottom: 4pt),
  stroke: (left: 2pt + rgb("#4a4a4a")),
  text(weight: "bold", body),
)

#let blank(width: 2.5cm) = box(width: width, height: 0.9em, stroke: (bottom: 0.5pt + black))
#let answer-space(height: 2cm) = block(height: height, width: 100%)

= Better Than Guessing

#set par(justify: false)
*Team Members:* #blank(width: 3.4cm) #h(0.2cm) #blank(width: 3.4cm) #h(0.2cm) #blank(width: 3.4cm)
#set par(justify: true)

#v(0.2cm)

You can fit a line to anything. The line does not care whether it makes sense. In lecture you
built the number that tells you whether a line was worth fitting:

#v(0.1cm)
#align(center)[
  $ R^2 = 1 - (S S_"Residual") / (S S_"Total") $
]
#v(0.1cm)

Today you will find out where the line stops working --- and find a case where $R^2$ lies to you.
Open `Class18_Better_Than_Guessing_Skeleton.ipynb`. Every cell runs as given. Answer here, on paper.

== Part 1. The Cricket Line

#question[
  #set par(justify: false)
  1.1 Run the first cell and record: \
  #v(0.15cm)
  #h(0.4cm) slope #blank(width: 2.2cm) #h(1cm) intercept #blank(width: 2.2cm)
  #h(1cm) $R^2$ #blank(width: 2cm) \
  #v(0.2cm)
  #set par(justify: true)
  State what the *slope* means in plain English --- with units.
]

#answer-space(height: 1.4cm)

#question[
  1.2 Last class you found $r = 0.80$ between two Pixar rating services and called it a strong
  correlation. Square it. Does "strong correlation" mean what you assumed it meant?
]

#answer-space(height: 1.4cm)

== Part 2. Where the Line Stops Working

#question[
  #set par(justify: false)
  2.1 Use your equation to predict the temperature at each chirp rate: \
  #v(0.15cm)
  #h(0.4cm) 19 chirps/sec → #blank(width: 2cm) °F #h(1.6cm)
  40 chirps/sec → #blank(width: 2cm) °F \
  #v(0.15cm)
  #h(0.4cm) And at 0 chirps/sec, the intercept says #blank(width: 2cm) °F \
  #v(0.2cm)
  #set par(justify: true)
  The observed chirp rates run from 14.4 to 20.0. Two of those three predictions are ones you
  should refuse to make. Which, and what is wrong with each?
]

#answer-space(height: 2.2cm)

#pagebreak()

== Part 3. A Better Number That Is a Worse Model

The notebook now fits a straight line to a second data set. Look at the plot, but do *not* run
the $R^2$ cell yet.

#question[
  #set par(justify: false)
  3.1 Predict: will this fit's $R^2$ be #h(0.3cm) *higher* #h(0.3cm) or #h(0.3cm) *lower*
  #h(0.3cm) than the crickets'? (Circle one.) Now run the cell. \
  #v(0.15cm)
  #h(0.4cm) $R^2$ for the second data set #blank(width: 2cm) #h(1cm) versus the crickets
  #blank(width: 2cm) \
  #v(0.15cm)
  #set par(justify: true)
  Which data set is the straight line actually the right model for?
]

#answer-space(height: 1.4cm)

#question[
  #set par(justify: false)
  3.2 Now compare the two *residual* plots. Sketch the shape of each, roughly: \
  #v(0.2cm)
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    box(width: 100%, height: 3cm, stroke: 0.5pt + rgb("#888888"), inset: 4pt)[
      #text(size: 9pt)[crickets]
    ],
    box(width: 100%, height: 3cm, stroke: 0.5pt + rgb("#888888"), inset: 4pt)[
      #text(size: 9pt)[second data set]
    ],
  )
]

#question[
  3.3 So: does a high $R^2$ mean you have the right model? State what the residual plot told you
  that $R^2$ could not, in one or two sentences.
]

#answer-space(height: 3cm)
