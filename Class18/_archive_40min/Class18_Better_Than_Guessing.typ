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

You can fit a line to anything. The line does not care whether it makes sense. Today you will
build the number that tells you whether a line was worth fitting --- and then find a case where
that number lies to you.

Open `Class18_Better_Than_Guessing_Skeleton.ipynb`. Answer here, on paper.

== Part 1. Two Baselines #h(1fr) #text(size: 9pt, style: "italic", weight: "regular")[6 minutes]

Someone reads you fifteen temperatures in random order and asks you to guess each one before
it is revealed. You know nothing else.

#question[
  #set par(justify: false)
  1.1 What single number should you guess every time, and why that one rather than any other?
]

#answer-space(height: 1.4cm)

Now they tell you the cricket chirp rate before each guess. If chirps and temperature are
related, you can do better than one fixed number --- you can use a line.

That is the whole idea behind $R^2$. It compares the error left over after using the line to
the error you started with using only the mean:

#v(0.1cm)
#align(center)[
  $ R^2 = 1 - S S_"Residual" / S S_"Total" $
]
#v(0.1cm)

#question[
  #set par(justify: false)
  1.2 Before computing anything: if the line were perfect, $S S_"Residual"$ would be
  #blank(width: 1.6cm) and $R^2$ would be #blank(width: 1.6cm). If the line were no help at all,
  $S S_"Residual"$ would equal #blank(width: 3.4cm) and $R^2$ would be #blank(width: 1.6cm).
]

== Part 2. How Good Is the Cricket Line? #h(1fr) #text(size: 9pt, style: "italic", weight: "regular")[20 minutes]

Fifteen observations of chirp rate and temperature. Work through the notebook in order.

#question[
  #set par(justify: false)
  2.1 The mean baseline. Record: \
  #v(0.15cm)
  #h(0.4cm) mean temperature #blank(width: 2.2cm) °F #h(1.4cm)
  $S S_"Total"$ #blank(width: 2.6cm) \
  #v(0.15cm)
  #set par(justify: true)
  In one sentence, what do the red vertical segments in the plot represent?
]

#answer-space(height: 1.2cm)

#question[
  #set par(justify: false)
  2.2 Fit the line. \
  #v(0.15cm)
  #h(0.4cm) slope #blank(width: 2.2cm) #h(1cm) intercept #blank(width: 2.2cm) \
  #v(0.2cm)
  #set par(justify: true)
  Write the equation, and state what the *slope* means in plain English --- with units.
]

#answer-space(height: 1.4cm)

#question[
  #set par(justify: false)
  2.3 Finish the calculation. \
  #v(0.15cm)
  #h(0.4cm) $S S_"Residual"$ #blank(width: 2.4cm) #h(1cm) $R^2$ #blank(width: 2cm)
  #h(1cm) $r$ #blank(width: 2cm) #h(1cm) $r^2$ #blank(width: 2cm) \
  #v(0.2cm)
  #set par(justify: true)
  Interpret the $R^2$ in a sentence a non-statistician would understand. What does the leftover
  $(1 - R^2)$ represent?
]

#answer-space(height: 1.8cm)

#question[
  Last class you found $r = 0.80$ between two Pixar rating services and called it a strong
  correlation. Square it. Does "strong correlation" mean what you assumed it meant?
]

#answer-space(height: 1.4cm)

#pagebreak()

== Part 3. Where the Line Stops Working #h(1fr) #text(size: 9pt, style: "italic", weight: "regular")[8 minutes]

#question[
  #set par(justify: false)
  3.1 Use your equation to predict the temperature at each chirp rate: \
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

#question[
  3.2 The notebook keeps the fitted slope but forces the intercept to zero, and $R^2$ comes out
  around $-14$. A negative $R^2$ means the line did worse than a flat guess at the mean. Look at
  what that line predicts at 15 chirps/sec compared to the real temperatures, and explain how a
  line can be *worse than useless*.
]

#answer-space(height: 2cm)

== Part 4. A Better Number That Is a Worse Model #h(1fr) #text(size: 9pt, style: "italic", weight: "regular")[6 minutes]

The notebook now fits a straight line to a second data set and reports its $R^2$.

#question[
  #set par(justify: false)
  4.1 $R^2$ for the second data set #blank(width: 2cm) #h(1cm) versus the crickets
  #blank(width: 2cm) \
  #v(0.15cm)
  #set par(justify: true)
  Which fit has the higher $R^2$? Which data set is the straight line actually the right model
  for? Look at the plot before you answer.
]

#answer-space(height: 1.4cm)

#question[
  #set par(justify: false)
  4.2 Now compare the two *residual* plots. Sketch the shape of each, roughly: \
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
  4.3 So: does a high $R^2$ mean you have the right model? State what the residual plot told you
  that $R^2$ could not, in one or two sentences.
]

#answer-space(height: 2cm)
