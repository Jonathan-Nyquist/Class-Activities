import csv
import numpy as np

rows = list(csv.reader(open('/Users/nyq/Documents/Github/Class-Activities/Class18/data/cricket_thermometer.csv')))[1:]
x = np.array([float(r[0]) for r in rows])
y = np.array([float(r[1]) for r in rows])

def su(a):
    return (a - np.mean(a)) / np.std(a)

def corr(x, y):
    return np.mean(su(x) * su(y))

def slope(x, y):
    return corr(x, y) * np.std(y) / np.std(x)

def icpt(x, y):
    return np.mean(y) - slope(x, y) * np.mean(x)

b = slope(x, y); a = icpt(x, y); r = corr(x, y)
print('slope', round(b, 4), 'intercept', round(a, 4), 'r', round(r, 4))
print('SD-line slope', round(np.std(y) / np.std(x), 4), 'mean x', round(np.mean(x), 3), 'SD x', round(np.std(x), 3))
print('OLS SSE', round(np.sum((y - (a + b * x)) ** 2), 2))
for i in range(15):
    y2 = y.copy(); y2[i] += 10
    print(i + 1, round(x[i], 2), round(y[i], 1), 'dx', round(x[i] - np.mean(x), 2),
          'resid', round(y[i] - a - b * x[i], 2), 'dslope', round(slope(x, y2) - b, 3))
