import json, csv, os
import nbformat
from nbformat.v4 import new_notebook, new_markdown_cell, new_code_cell

D = '/Users/nyq/Documents/Github/Class-Activities/Drafts_of_activities/LeverageGame/'
os.makedirs(D + 'data', exist_ok=True)
# cricket data: the Class 19 copy (clean header); game datasets from verify_round3b_shift20.py
open(D + 'data/cricket_thermometer.csv', 'w').write(
    open('/Users/nyq/Documents/Github/Class-Activities/Class19/data/cricket_thermometer.csv').read())
for k, tr in enumerate(json.load(open(D + 'round3b_trials_shift20.json'))):
    with open(D + f'data/plant_dataset_{k + 1}.csv', 'w', newline='') as f:
        w = csv.writer(f); w.writerow(['chirps_per_sec', 'temp_f'])
        for xv, yv in zip(tr['x'], tr['y']):
            w.writerow([xv, yv])

# each cell: (kind, skeleton source, solution source or None)
C = []
def md(s): C.append(('md', s, None))
def code(s, sol=None): C.append(('code', s, sol))

md("""# Pull the Line: Leave One Out
*Elements of Data Science (Honors)*

<br>**<center>Learning Goals**

|Area|Concept|
|---|---|
|Leverage|How far a point's x-value is from the mean x decides how much it *can* move the line|
|Influence|How much the slope actually changes when one point is removed|
|Leave-one-out|Refit without a point, then measure how far that point sits from the new line|

In the game you moved points and probed a few of them by hand. Here you will reproduce the game's numbers with code, then run the probe on *every* point at once. Answer the handout questions on paper.

Run the setup cell first.""")
code("""import numpy as np
from datascience import *
%matplotlib inline
import matplotlib.pyplot as plt
plt.style.use('fivethirtyeight')""")
md("""## The cricket data and the regression toolbox

Same 15 crickets as Classes 18 and 19, and the same functions. **Row 0 is the game's point 1**, row 1 is point 2, and so on.""")
code("""crickets = Table.read_table("./data/cricket_thermometer.csv")
crickets = crickets.relabeled("chirps_per_sec", "Chirps/sec").relabeled("temp_f", "Temp (F)")
crickets""")
code('''def standard_units(x):
    "Convert an array of numbers to standard units."
    return (x - np.mean(x)) / np.std(x)

def correlation(t, label_x, label_y):
    x_su = standard_units(t.column(label_x))
    y_su = standard_units(t.column(label_y))
    return np.mean(x_su * y_su)

def slope_of(t):
    # Least-squares slope relating Temp (F) to Chirps/sec for table t.
    r = correlation(t, "Chirps/sec", "Temp (F)")
    return r * np.std(t.column("Temp (F)")) / np.std(t.column("Chirps/sec"))

def intercept_of(t):
    # Least-squares intercept relating Temp (F) to Chirps/sec for table t.
    return np.mean(t.column("Temp (F)")) - slope_of(t) * np.mean(t.column("Chirps/sec"))

observed_slope = slope_of(crickets)
observed_intercept = intercept_of(crickets)
print(f"Slope: {observed_slope:.3f}   Intercept: {observed_intercept:.2f}")''')
md("""## Part 5A: Move one point

This function returns a copy of a table with one row's temperature raised. It builds the new temperature column one value at a time, so the original table is never changed.""")
code('''def move_up(t, row, amount):
    # Return a copy of table t with the temperature in one row raised by amount.
    temps = t.column("Temp (F)")
    new_temps = make_array()
    for j in np.arange(t.num_rows):
        if j == row:
            new_temps = np.append(new_temps, temps.item(j) + amount)
        else:
            new_temps = np.append(new_temps, temps.item(j))
    return t.with_column("Temp (F)", new_temps)''')
md("""Test it on a value you can check: move row 0 (the game's point 1) up 10 °F.

> **Handout Q5.1.** Record the slope change. Does it match what the game reported for point 1?""")
code("""moved = move_up(crickets, 0, 10)
change = slope_of(moved) - observed_slope
print(f"Slope change from moving point 1 up 10 F: {change:+.3f}")""")
md("""**Your turn.** Adapt the cell above into a loop that moves *each* row up 10 °F, one at a time, and collects the slope change. Run it as written first: it only does 3 rows, so you can check it against the game before doing all 15.""")
code("""changes = make_array()
for row in np.arange(3):
    moved = ...
    changes = np.append(changes, ...)
changes""",
"""changes = make_array()
for row in np.arange(3):
    moved = move_up(crickets, row, 10)
    changes = np.append(changes, slope_of(moved) - observed_slope)
changes""")
md("""Points 1, 2, 3 in the game gave +0.825, −0.161, +0.776. If yours match, change `np.arange(3)` to `np.arange(crickets.num_rows)` and run it again.""")
code("""changes = make_array()
for row in np.arange(crickets.num_rows):
    moved = ...
    changes = np.append(changes, ...)
changes""",
"""changes = make_array()
for row in np.arange(crickets.num_rows):
    moved = move_up(crickets, row, 10)
    changes = np.append(changes, slope_of(moved) - observed_slope)
changes""")
md("""Now compare each point's slope change with its distance from the mean chirp rate.

> **Handout Q5.2.** Describe the shape of this scatter plot. Where does it cross a slope change of zero, and what does that tell you about leverage?""")
code("""mean_chirps = np.mean(crickets.column("Chirps/sec"))
fitted = observed_slope * crickets.column("Chirps/sec") + observed_intercept
moves = crickets.with_columns(
    "Point", np.arange(1, crickets.num_rows + 1),
    "Distance from mean x", crickets.column("Chirps/sec") - mean_chirps,
    "Residual", crickets.column("Temp (F)") - fitted,
    "Slope change", changes)
moves.scatter("Distance from mean x", "Slope change")""")
md("""> **Handout Q5.3.** Now plot slope change against the *residual*. Is there a pattern? Find point 9, the point with the largest residual.""")
code("""moves.scatter("Residual", "Slope change")
moves.sort("Residual")""")
md("""## Part 5B: Leave one out

This is what a probe in the game did. Remove one row with `exclude`, refit, and measure:
- the **slope change** that point caused: the slope with it, minus the slope without it
- its **miss**: how far the point sits from the line fit *without* it

Worked example for row 0 (point 1):""")
code("""row = 0
without = crickets.exclude(row)
slope_without = slope_of(without)
intercept_without = intercept_of(without)

x_left_out = crickets.column("Chirps/sec").item(row)
y_left_out = crickets.column("Temp (F)").item(row)
miss = y_left_out - (slope_without * x_left_out + intercept_without)

print(f"Point {row + 1}: slope change {observed_slope - slope_without:+.3f}, miss {miss:+.2f} F")""")
md("""**Your turn.** Adapt the worked example into a loop over every row. Check row 0 against the worked example before trusting the rest.""")
code("""loo_changes = make_array()
misses = make_array()
for row in np.arange(crickets.num_rows):
    without = ...
    slope_without = ...
    intercept_without = ...
    x_left_out = ...
    y_left_out = ...
    loo_changes = np.append(loo_changes, ...)
    misses = np.append(misses, ...)

probes = moves.select("Point", "Chirps/sec", "Residual").with_columns(
    "Slope change (left out)", loo_changes,
    "Miss without it", misses)
probes""",
"""loo_changes = make_array()
misses = make_array()
for row in np.arange(crickets.num_rows):
    without = crickets.exclude(row)
    slope_without = slope_of(without)
    intercept_without = intercept_of(without)
    x_left_out = crickets.column("Chirps/sec").item(row)
    y_left_out = crickets.column("Temp (F)").item(row)
    loo_changes = np.append(loo_changes, observed_slope - slope_without)
    misses = np.append(misses, y_left_out - (slope_without * x_left_out + intercept_without))

probes = moves.select("Point", "Chirps/sec", "Residual").with_columns(
    "Slope change (left out)", loo_changes,
    "Miss without it", misses)
probes""")
md("""> **Handout Q5.4.** Fill in the table on the handout for points 1, 3, and 9. For each, divide the miss by the residual. Which points get the biggest boost when they are left out, and what do they have in common?""")
code("""probes.where("Point", are.contained_in(make_array(1, 3, 9)))""")
md("""## Part 5C: Probe every point in the game's datasets

The function below is your loop from Part 5B, wrapped so it works on any table with the same two columns. In the game you had two probes per dataset. Here you get all 15.""")
code('''def leave_one_out(t):
    # Probe every row of t: slope change it caused, and its miss from the line fit without it.
    t_slope = slope_of(t)
    loo_changes = make_array()
    misses = make_array()
    for row in np.arange(t.num_rows):
        without = t.exclude(row)
        slope_without = slope_of(without)
        intercept_without = intercept_of(without)
        x_left_out = t.column("Chirps/sec").item(row)
        y_left_out = t.column("Temp (F)").item(row)
        loo_changes = np.append(loo_changes, t_slope - slope_without)
        misses = np.append(misses, y_left_out - (slope_without * x_left_out + intercept_without))
    return t.with_columns("Slope change (left out)", loo_changes, "Miss without it", misses)

def load_dataset(number):
    t = Table.read_table(f"./data/plant_dataset_{number}.csv")
    return t.relabeled("chirps_per_sec", "Chirps/sec").relabeled("temp_f", "Temp (F)")''')
md("""Worked example: Dataset 1, sorted so the biggest misses come first.""")
code("""d1 = leave_one_out(load_dataset(1))
d1.with_column("Size of miss", np.abs(d1.column("Miss without it"))).sort("Size of miss", descending=True)""")
md("""**Your turn.** Run the same thing for Datasets 2 and 3.

> **Handout Q5.5.** For each dataset, record the point with the biggest miss and the point with the biggest slope change. Are they the same point? Which one was the plant?""")
code("""d2 = ...
d2.with_column("Size of miss", np.abs(d2.column("Miss without it"))).sort("Size of miss", descending=True)""",
"""d2 = leave_one_out(load_dataset(2))
d2.with_column("Size of miss", np.abs(d2.column("Miss without it"))).sort("Size of miss", descending=True)""")
code("""d3 = ...
d3.with_column("Size of miss", np.abs(d3.column("Miss without it"))).sort("Size of miss", descending=True)""",
"""d3 = leave_one_out(load_dataset(3))
d3.with_column("Size of miss", np.abs(d3.column("Miss without it"))).sort("Size of miss", descending=True)""")

def build(solution):
    nb = new_notebook()
    for kind, src, sol in C:
        if kind == 'md':
            nb.cells.append(new_markdown_cell(src))
        else:
            nb.cells.append(new_code_cell(sol if (solution and sol) else src))
    nb.metadata['kernelspec'] = {'name': 'python3', 'display_name': 'Python 3', 'language': 'python'}
    return nb

nbformat.write(build(False), D + 'PullTheLine_Skeleton.ipynb')
nbformat.write(build(True), '/tmp/PullTheLine_Solution.ipynb')
print('cells', len(C), 'skeleton blanks', sum(1 for k, s, sol in C if sol))
