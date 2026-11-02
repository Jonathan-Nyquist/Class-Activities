// ============================================================
// APPROXIMATE preamble reconstructed from house-style notes.
// This is Claude's best reconstruction, NOT your real preamble.
// Paste your actual preamble over this file before compiling
// for real -- macro names/behavior below are guesses at the
// documented interface (question, blank, answer-space, note, warn).
// ============================================================

#let body-font = "Liberation Serif"
#let code-font = "Liberation Mono"
#let accent = rgb("#9E1B34") // Temple cherry, per house palette used elsewhere

#let question-counter = counter("question")

#let question(body) = block(
  stroke: (left: 2.5pt + black),
  inset: (left: 10pt, top: 6pt, bottom: 6pt, right: 6pt),
  width: 100%,
  above: 10pt,
  below: 8pt,
  [*#body*]
)

#let blank(width: 3.5cm) = box(width: width, stroke: (bottom: 0.6pt + black), [#h(1fr)])

#let answer-space(lines: 3) = {
  for i in range(lines) {
    v(0.55cm)
    line(length: 100%, stroke: 0.5pt + gray)
  }
  v(0.2cm)
}

#let note(body) = block(
  fill: rgb("#f2f2f2"),
  inset: 8pt,
  radius: 2pt,
  width: 100%,
  above: 8pt,
  below: 8pt,
  [*Note:* #body]
)

#let warn(body) = block(
  fill: rgb("#fdecea"),
  inset: 8pt,
  radius: 2pt,
  width: 100%,
  above: 8pt,
  below: 8pt,
  [*Caution:* #body]
)

#let part-heading(title, minutes: none) = {
  let label = if minutes != none [#title (#sym.approx #minutes min)] else [#title]
  align(center)[
    #block(above: 16pt, below: 10pt)[
      #text(size: 14pt, weight: "bold", tracking: 0.5pt)[#upper(label)]
    ]
  ]
}

#let class-doc(title: "", subtitle: "", team-members: false, body) = {
  set page(paper: "us-letter", margin: (x: 1.9cm, y: 1.9cm),
    footer: context [
      #align(center)[#text(size: 8pt, fill: gray)[#counter(page).display() / #counter(page).final().first()]]
    ]
  )
  set text(font: body-font, size: 11pt)
  show raw: set text(font: code-font, size: 9.5pt)
  show raw.where(block: true): it => block(
    fill: rgb("#ececec"),
    inset: 8pt,
    radius: 2pt,
    width: 100%,
    it
  )
  set heading(numbering: none)
  show heading.where(level: 1): it => align(center)[
    #block(above: 4pt, below: 4pt)[
      #text(size: 16pt, weight: "bold")[#it.body]
    ]
  ]

  align(center)[
    #text(size: 18pt, weight: "bold")[#title]
    #if subtitle != "" [
      #v(2pt)
      #text(size: 12pt, style: "italic")[#subtitle]
    ]
  ]

  if team-members {
    v(12pt)
    line(length: 100%, stroke: 0.4pt + gray)
    v(10pt)
    grid(columns: (2.4fr, 1fr), gutter: 16pt,
      [Team Members: #blank(width: 9.5cm)],
      [Date: #blank(width: 3.2cm)]
    )
    v(8pt)
    line(length: 100%, stroke: 0.4pt + gray)
    v(12pt)
  }

  body
}
