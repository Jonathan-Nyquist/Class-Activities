#import "preamble.typ": *

#show: body => class-doc(
  title: "Class 20: Who Got In",
  subtitle: "What a selected group can tell you -- and what it can't",
  team-members: true,
  body
)

An honors program received 400 applications. Each dot below is one applicant's high school GPA and SAT score. Across *all* applicants, r = +0.41: higher GPAs tend to go with higher SAT scores, though far from perfectly. (The data are synthetic, built to resemble a realistic applicant pool.)

The program ranks applicants on a combined score -- GPA in standard units *plus* SAT in standard units -- and admits the top 30% (120 students). Every applicant exactly on the admission cutoff has the same combined score. The two stars sit on that cutoff.

#align(center)[#image("fig_applicants.png", width: 72%)]

#question[Q1. Connect the two stars with a straight line and shade the region of admitted students. In one sentence: why does the cutoff slope *downward*?]
#answer-space(lines: 3)

#pagebreak()

#question[Q2 -- Predict first. Among the 120 admitted students only, what will r be? Circle one, then explain using your shaded region. \
#v(4pt)#grid(columns: (auto, 1fr, auto, 1fr, auto, 1fr, auto, 1fr, auto, 1fr, auto), [strongly negative], [], [weakly negative], [], [near 0], [], [weakly positive], [], [about +0.41], [], [stronger than +0.41])]
#answer-space(lines: 4)

#question[Q3. A dean studies only the enrolled honors students and reports: "Our strongest test-takers have the weakest grades. Test-taking ability and hard work must be different traits." Using your sketch, explain what the dean got wrong.]
#answer-space(lines: 5)

#question[Q4 -- Predict first. Program B admits the top 30% by GPA alone, ignoring SAT. Among Program B's admits, will r be negative, near 0, or positive? Larger or smaller than +0.41?]
#answer-space(lines: 3)

#question[Q5. You are all in an honors program. Name one conclusion someone could wrongly draw by studying *only* students like you.]
#answer-space(lines: 4)
