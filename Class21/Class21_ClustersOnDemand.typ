#import "preamble.typ": *

#show: body => class-doc(
  title: "Class 21: Clusters on Demand",
  subtitle: "k-means always finds groups. When should you believe them?",
  team-members: true,
  body
)

*Clustering* sorts points into groups using only how close they are to each other -- no labels, no right answers given. The most common method is *k-means*. You choose k, the number of groups, and the algorithm does the rest:

#block(inset: (left: 12pt))[
  *Start.* Pick k rows at random to be the starting centers. (The `seed` decides which rows.) \
  *Step A.* Every point joins the center it is closest to. \
  *Step B.* Every center moves to the average of its points. \
  *Repeat* A and B until no point changes groups.
]

Both columns are converted to standard units first, so a minute of waiting doesn't count more than a minute of eruption just because waiting times are bigger numbers.

#note[Lab 10 uses *k-nearest neighbors*, a different method. There, k counts neighbors used to make a prediction. Here, k counts groups.]

#grid(columns: (1.1fr, 1fr), gutter: 12pt,
  image("fig_faithful.png", width: 100%),
  [
    #question[Q1 -- Before running any code. How many groups do you see? Draw the boundary between them on the plot. Describe each group in a few words.]
    #answer-space(lines: 4)
  ]
)

#question[Q2. Run `kmeans(faithful, 2, seed=0)`. Does its boundary match yours? How many eruptions are in each cluster?]
#answer-space(lines: 2)

#pagebreak()

#grid(columns: (1fr, 1.1fr), gutter: 12pt,
  image("fig_noise.png", width: 100%),
  [
    #question[Q3 -- Predict first. These 272 points were generated at random, spread evenly over the same ranges. What will `kmeans(noise, 2, seed=0)` do? Circle one, then sketch your guess on the plot.]
    #v(4pt)
    (a) give an error or refuse \
    (b) put nearly every point in one cluster \
    (c) split the points into two clusters of about equal size \
    (d) something else: #blank(width: 3cm)
  ]
)

#question[Q4. Run k = 2 on both datasets with seed 0, then with seed 2. Fill in the table. For "boundary," write *vertical*, *horizontal*, or *diagonal*.]
#table(
  columns: (1.5fr, 1fr, 1fr, 1fr, 1fr),
  stroke: 0.5pt + gray,
  inset: 10pt,
  [], [*seed 0: sizes*], [*seed 0: boundary*], [*seed 2: sizes*], [*seed 2: boundary*],
  [Old Faithful], [], [], [], [],
  [Random points], [], [], [], [],
)
Which dataset's answer depended on the seed? #blank(width: 6cm)

#question[Q5. Now ask for k = 3 on Old Faithful, with seed 0 and then seed 6. Record the cluster sizes. Did k-means complain? Which, if any, of the three clusters do you believe?]
seed 0: #blank(width: 4cm) #h(1cm) seed 6: #blank(width: 4cm)
#answer-space(lines: 3)

#question[Q6. k-means *always* returns exactly k groups. Name two pieces of evidence you would want before believing a cluster is real.]
#answer-space(lines: 4)
