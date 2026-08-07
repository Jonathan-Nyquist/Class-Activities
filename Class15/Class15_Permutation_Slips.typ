#set document(title: "Class 15: Permutation Slips", author: "Elements of Data Science")
#set page(paper: "us-letter", margin: (x: 0.7in, y: 0.6in))
#set text(font: "Liberation Serif", size: 10.5pt)
#show raw: it => text(font: "Liberation Mono", size: 9.5pt, it)

#let roster = align(center)[
  #table(
    columns: (1.5cm,) * 7,
    inset: 4pt,
    align: center,
    stroke: 0.5pt + rgb("#888888"),
    table.cell(fill: rgb("#eeeeee"))[*P1*], table.cell(fill: rgb("#eeeeee"))[*P2*],
    table.cell(fill: rgb("#eeeeee"))[*P3*], table.cell(fill: rgb("#eeeeee"))[*P4*],
    table.cell(fill: rgb("#eeeeee"))[*P5*], table.cell(fill: rgb("#eeeeee"))[*P6*],
    table.cell(fill: rgb("#eeeeee"))[*P7*],
    [22], [33], [40], [19], [22], [25], [26],
  )
]

#let slip(team, rows) = block(
  width: 100%,
  inset: 10pt,
  stroke: 0.8pt + rgb("#444444"),
  radius: 3pt,
  [
    #text(size: 13pt, weight: "bold")[Team #team] #h(0.6cm)
    #text(size: 10pt)[Recovery times, in days, for the seven patients:]
    #v(0.15cm)
    #roster
    #v(0.2cm)
    #text(size: 10pt)[
      For each row below, add the three recovery times and write the total in the *Sum*
      column. Then write your #box(inset: (x: 2pt))[*Sum*] values on the board — nothing else.
    ]
    #v(0.2cm)
    #align(center)[
      #table(
        columns: (3.6cm, 4.2cm, 2.6cm),
        inset: 6pt,
        align: (center, center, center),
        stroke: 0.5pt + rgb("#888888"),
        table.cell(fill: rgb("#f2f2f2"))[*Control group*],
        table.cell(fill: rgb("#f2f2f2"))[*Their three times*],
        table.cell(fill: rgb("#f2f2f2"))[*Sum*],
        ..rows,
      )
    ]
  ]
)

#slip("A", (
    [P1, P2, P3], [`22 + 33 + 40`], [],
    [P1, P2, P4], [`22 + 33 + 19`], [],
    [P1, P2, P5], [`22 + 33 + 22`], [],
    [P1, P2, P6], [`22 + 33 + 25`], [],
    [P1, P2, P7], [`22 + 33 + 26`], [],
    [P1, P3, P4], [`22 + 40 + 19`], [],
  ))

#v(0.35cm)
#slip("B", (
    [P1, P3, P5], [`22 + 40 + 22`], [],
    [P1, P3, P6], [`22 + 40 + 25`], [],
    [P1, P3, P7], [`22 + 40 + 26`], [],
    [P1, P4, P5], [`22 + 19 + 22`], [],
    [P1, P4, P6], [`22 + 19 + 25`], [],
    [P1, P4, P7], [`22 + 19 + 26`], [],
  ))

#v(0.3cm)
#pagebreak()
#slip("C", (
    [P1, P5, P6], [`22 + 22 + 25`], [],
    [P1, P5, P7], [`22 + 22 + 26`], [],
    [P1, P6, P7], [`22 + 25 + 26`], [],
    [P2, P3, P4], [`33 + 40 + 19`], [],
    [P2, P3, P5], [`33 + 40 + 22`], [],
    [P2, P3, P6], [`33 + 40 + 25`], [],
  ))

#v(0.35cm)
#slip("D", (
    [P2, P3, P7], [`33 + 40 + 26`], [],
    [P2, P4, P5], [`33 + 19 + 22`], [],
    [P2, P4, P6], [`33 + 19 + 25`], [],
    [P2, P4, P7], [`33 + 19 + 26`], [],
    [P2, P5, P6], [`33 + 22 + 25`], [],
    [P2, P5, P7], [`33 + 22 + 26`], [],
  ))

#v(0.3cm)
#pagebreak()
#slip("E", (
    [P2, P6, P7], [`33 + 25 + 26`], [],
    [P3, P4, P5], [`40 + 19 + 22`], [],
    [P3, P4, P6], [`40 + 19 + 25`], [],
    [P3, P4, P7], [`40 + 19 + 26`], [],
    [P3, P5, P6], [`40 + 22 + 25`], [],
    [P3, P5, P7], [`40 + 22 + 26`], [],
  ))

#v(0.35cm)
#slip("F", (
    [P3, P6, P7], [`40 + 25 + 26`], [],
    [P4, P5, P6], [`19 + 22 + 25`], [],
    [P4, P5, P7], [`19 + 22 + 26`], [],
    [P4, P6, P7], [`19 + 25 + 26`], [],
    [P5, P6, P7], [`22 + 25 + 26`], [],
  ))
