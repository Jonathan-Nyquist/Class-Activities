import numpy as np
from datascience import *

faithful = Table.read_table('https://raw.githubusercontent.com/data-8/textbook/main/assets/data/faithful.csv')
faithful.to_csv('/Users/nyq/Documents/Github/Class-Activities/Class21/data/faithful.csv')

def standard_units(arr):
    return (arr - np.mean(arr)) / np.std(arr)

def kmeans(tbl, k, seed, standardize=True):
    x = tbl.column(0)
    y = tbl.column(1)
    if standardize:
        x = standard_units(x)
        y = standard_units(y)
    np.random.seed(seed)
    start = np.random.choice(np.arange(tbl.num_rows), k, replace=False)
    cx = x.take(start)
    cy = y.take(start)
    labels = np.zeros(tbl.num_rows)
    for step in np.arange(50):
        new = make_array()
        for i in np.arange(tbl.num_rows):
            d = np.sqrt((x.item(i) - cx) ** 2 + (y.item(i) - cy) ** 2)
            new = np.append(new, np.argmin(d))
        for c in np.arange(k):
            if np.sum(new == c) > 0:
                cx[c] = np.mean(x[new == c])
                cy[c] = np.mean(y[new == c])
        if np.all(new == labels) and step > 0:
            break
        labels = new
    spread = 0
    for i in np.arange(tbl.num_rows):
        c = int(labels.item(i))
        spread = spread + (x.item(i) - cx[c]) ** 2 + (y.item(i) - cy[c]) ** 2
    return labels, step, spread

def summary(tbl, labels, k):
    out = []
    for c in np.arange(k):
        sub = tbl.where(labels == c)
        out.append((sub.num_rows, round(np.mean(sub.column(0)), 2), round(np.mean(sub.column(1)), 1),
                    round(min(sub.column(0)), 2), round(max(sub.column(0)), 2)))
    return sorted(out)

print('== Old Faithful k=2, standardized, seeds 0-19')
for s in range(20):
    lab, st, sp = kmeans(faithful, 2, s)
    print(s, st, round(sp, 1), summary(faithful, lab, 2))

print('== Old Faithful k=2 RAW, seeds 0-4')
for s in range(5):
    lab, st, sp = kmeans(faithful, 2, s, standardize=False)
    print(s, st, summary(faithful, lab, 2))

print('== Old Faithful k=3, standardized, seeds 0-19')
for s in range(20):
    lab, st, sp = kmeans(faithful, 3, s)
    print(s, st, round(sp, 1), summary(faithful, lab, 3))
