import nbformat
from nbformat.v4 import new_notebook, new_markdown_cell, new_code_cell

helper = open('data/kmeans_helper.py').read().strip()

cells = []
md = lambda s: cells.append(new_markdown_cell(s.strip()))
code = lambda s: cells.append(new_code_cell(s.strip()))

md("""
# Class 21: Clusters on Demand
*Elements of Data Science (Honors)*

<br>**<center>Learning Goals**

|Area|Concept|
|---|---|
|Clustering|Sort points into groups using only distance -- no labels|
|k-means|Assign each point to the nearest center, move centers, repeat|
|Skepticism|k-means always returns k groups, real or not|

Write your answers on the handout, not in this notebook.
""")
code("""
import numpy as np
from datascience import *
%matplotlib inline
import matplotlib.pyplot as plt
plt.style.use('fivethirtyeight')
""")
md("""
## The k-means tool

Run this cell once. You do **not** need to edit it, but read the comments: Step A and Step B are the two steps on your handout.
""")
code("""
def standard_units(arr):
    return (arr - np.mean(arr)) / np.std(arr)

""" + helper)
md("""
## Part 1: Old Faithful

The same 272 eruptions you met in Lab 8. **Answer handout Q1 before running anything below.**
""")
code("""
faithful = Table.read_table('data/faithful.csv')
faithful.scatter('eruptions', 'waiting')
""")
md("""
Now ask k-means for 2 clusters. The `seed` picks which random rows become the starting centers.
""")
code("""
faithful_2 = kmeans(faithful, 2, seed=0)
plot_clusters(faithful_2, 'Old Faithful, k = 2, seed = 0')
faithful_2.group('cluster')
""")
md("""
## Part 2: Points with no groups

These 272 points were generated at random, spread evenly over the same ranges as Old Faithful. Nobody built any groups into them.

**Answer handout Q3 before running the k-means cell.**
""")
code("""
noise = Table.read_table('data/noise.csv')
noise.scatter('eruptions', 'waiting')
""")
md("""
Adapt the Old Faithful cell above: cluster `noise` with k = 2 and seed = 0, plot it, and show the group sizes.
""")
code("""
noise_2 = ...
plot_clusters(noise_2, 'Random points, k = 2, seed = 0')
noise_2.group('cluster')
""")
md("""
### Change the starting point

Run k-means again on **both** datasets with `seed=2`. Record the group sizes and the direction of the boundary in the Q4 table.
""")
code("""
faithful_2b = kmeans(faithful, 2, seed=2)
plot_clusters(faithful_2b, 'Old Faithful, k = 2, seed = 2')
faithful_2b.group('cluster')
""")
code("""
noise_2b = ...
plot_clusters(noise_2b, 'Random points, k = 2, seed = 2')
noise_2b.group('cluster')
""")
md("""
## Part 3: Ask for three

Cluster Old Faithful with k = 3, first with `seed=0`, then with `seed=6`. Record the group sizes for handout Q5.
""")
code("""
faithful_3 = kmeans(faithful, ..., seed=0)
plot_clusters(faithful_3, 'Old Faithful, k = 3, seed = 0')
faithful_3.group('cluster')
""")
code("""
faithful_3b = ...
plot_clusters(faithful_3b, 'Old Faithful, k = 3, seed = 6')
faithful_3b.group('cluster')
""")

nb = new_notebook(cells=cells)
nb.metadata['kernelspec'] = {'display_name': 'Python 3 (ipykernel)', 'language': 'python', 'name': 'python3'}
nbformat.write(nb, 'Class21_ClustersOnDemand_Skeleton.ipynb')

# Filled-in copy for verification only
fill = {
    "noise_2 = ...": "noise_2 = kmeans(noise, 2, seed=0)",
    "noise_2b = ...": "noise_2b = kmeans(noise, 2, seed=2)",
    "kmeans(faithful, ..., seed=0)": "kmeans(faithful, 3, seed=0)",
    "faithful_3b = ...": "faithful_3b = kmeans(faithful, 3, seed=6)",
}
for c in nb.cells:
    for a in fill:
        c.source = c.source.replace(a, fill[a])
nbformat.write(nb, '_scratch/solved.ipynb')
print('written', len(cells), 'cells')
