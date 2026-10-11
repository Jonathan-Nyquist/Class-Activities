import csv, json
import numpy as np
from datascience import Table

D = '/Users/nyq/Documents/Github/Class-Activities/Drafts_of_activities/LeverageGame/'
t = Table.read_table('/Users/nyq/Documents/Github/Class-Activities/Class18/data/cricket_thermometer.csv')
x = t.column(0); y = t.column(1)

def su(a): return (a - np.mean(a)) / np.std(a)
def slope(x, y): return np.mean(su(x) * su(y)) * np.std(y) / np.std(x)

b = slope(x, y); n = len(x); denom = n * np.std(x) ** 2
rows = []
for i in range(n):
    y2 = y.copy(); y2[i] += 10
    rows.append((i + 1, x[i], slope(x, y2) - b, 10 * (x[i] - np.mean(x)) / denom))
print('max |actual - formula|', max(abs(r[2] - r[3]) for r in rows))
ranked = sorted(rows, key=lambda r: -abs(r[2]))
for k, r in enumerate(ranked):
    print('rank', k + 1, 'point', r[0], 'x=%.1f' % r[1], 'dslope %+.3f' % r[2])

T = json.load(open(D + 'round3b_trials_shift20.json'))
for j, tr in enumerate(T):
    p = tr['planted']
    print('dataset', j + 1, tr['kind'], 'plant x', tr['x'][p], 'moved', 'up' if tr['y'][p] > tr['y_orig'][p] else 'down',
          'far x', max(tr['x']))
