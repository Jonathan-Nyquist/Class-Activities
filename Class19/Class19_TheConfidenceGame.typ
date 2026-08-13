#import "preamble.typ": *

#show: body => class-doc(
  title: "Class 19: The Confidence Game",
  subtitle: "Bootstrap confidence intervals -- for a mean, and for a regression slope",
  team-members: true,
  body
)

#part-heading("Part 1: How Confident Are We in a Mean?")

We rolled a die 50 times and bootstrapped a 95% confidence interval for the mean roll -- resampling *from our one sample*, with replacement, instead of collecting new data.

#question[Q1.1. Before running the bootstrap cell: do you expect the bootstrapped CI to be close to the CI from actually replicating the experiment, or very different? Why might resampling from one sample of 50 tell you anything about the population?]
#answer-space(lines: 3)

We then did the same thing for a real quantity: the mean height in a sample of 10 people drawn from a larger population.

#question[Q1.2 (Student Challenge 1). Record your 95% bootstrapped CI for the sample mean height (n = 10).]
#answer-space(lines: 2)

#question[Q1.3 -- Predict first. Now imagine we'd measured 500 people instead of 10 -- 50x as much data. Before you compute anything: will the new CI be narrower, wider, or about the same width? Roughly what factor do you expect?]
#answer-space(lines: 3)

#question[Q1.4 (Student Challenge 2). Record your 95% bootstrapped CI for the sample mean height (n = 500).]
#answer-space(lines: 2)

#question[Q1.5 Discussion. How close was your prediction in Q1.3? What does this tell you about the relationship between sample size and the width of a confidence interval?]
#answer-space(lines: 3)

#part-heading("Part 2: From a Mean to a Slope")

Last week you fit a regression line to 15 crickets: temperature $=$ 3.29 $times$ chirps/sec $+$ 25.23, with r $=$ 0.835. That line came from only 15 crickets.

#question[Q2.1 -- Predict first. With only 15 data points, how much do you think the slope could plausibly shift if we'd measured a different 15 crickets? Give a rough range.]
#answer-space(lines: 3)

We'll bootstrap this the same way: resample the table with replacement, refit the slope, repeat 10,000 times.

#question[Q2.2 Discussion. Does the 95% CI for the slope include 0? What would it mean, scientifically, if it did? How does the width of this CI compare to what you predicted in Q2.1?]
#answer-space(lines: 3)

#question[Q2.3. Compare this CI to the one you found for the height mean in Part 1. Which sample gives the more precise estimate relative to its own scale: n = 15 crickets or n = 10 people? What's driving the difference?]
#answer-space(lines: 3)

*Adapt:* using the same idea, bootstrap a 95% CI for the regression's *intercept*.

#question[Q2.4 (Student Challenge 3). Record your 95% bootstrapped CI for the intercept. How does its width compare, proportionally, to the slope's CI?]
#answer-space(lines: 3)

#part-heading("Part 3: Looking Ahead")

Lab 09 (Age of the Universe) asks you to bootstrap the slope of a regression line on real supernova data, then convert that slope into an estimate of the age of the universe, with a confidence interval. Part 2 is exactly the method you'll need.

#part-heading("Part 4: When Does This Break?")

#question[Q4.1. Bootstrapping assumes your one sample is a reasonable stand-in for the population. What has to be true about *how* a sample was collected for that to hold? Can you think of a way the cricket or height sample could have been collected that would make bootstrapping misleading?]
#answer-space(lines: 3)

#question[Q4.2. A classmate ran only 200 bootstrap resamples (not 10,000) and got a *narrower* slope CI than yours. Should they trust their tighter interval more? Why or why not?]
#answer-space(lines: 3)

#question[Q4.3. With only 15 crickets, a bootstrap resample can, by chance, leave out an influential point entirely or include it two or three times. Why does that matter more for n = 15 than it would for n = 500?]
#answer-space(lines: 3)
