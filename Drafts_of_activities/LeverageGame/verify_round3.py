import numpy as np
import json

def su(a):
    return (a - np.mean(a)) / np.std(a)

def slope(x, y):
    return np.mean(su(x) * su(y)) * np.std(y) / np.std(x)

def icpt(x, y):
    return np.mean(y) - slope(x, y) * np.mean(x)

# Every trial has 13 ordinary points + 1 point near mean x + 1 isolated point far right.
# 'high' trial: the far-right point is planted.  'low' trial: the near-mean point is planted
# and the far-right point is innocent (a decoy), so "always pick the extreme x" doesn't win.
def make_trial(rng, kind, shift):
    xs = np.round(rng.uniform(14.4, 18.6, 13), 1)
    xm = np.round(np.mean(xs) + rng.uniform(-0.3, 0.3), 1)
    xf = np.round(rng.uniform(21.0, 22.0), 1)
    x = np.append(xs, [xm, xf])
    y0 = np.round(25 + 3.3 * x + rng.normal(0, 3.5, 15), 1)
    y = y0.copy()
    k = 14 if kind == 'high' else 13
    y[k] = np.round(y[k] + rng.choice([-1, 1]) * shift, 1)
    order = np.argsort(x, kind='stable')
    return x[order], y0[order], y[order], int(np.where(order == k)[0][0])

def rank_of(x, y, p):
    res = y - (icpt(x, y) + slope(x, y) * x)
    return int(np.sum(np.abs(res) > np.abs(res[p]))) + 1

for kind in ['high', 'low']:
    rng = np.random.default_rng(1)
    ranks = []
    for k in range(2000):
        x, y0, y, p = make_trial(rng, kind, 15)
        ranks.append(rank_of(x, y, p))
    ranks = np.array(ranks)
    print(kind, 'planted pt has biggest |resid| in', round(np.mean(ranks == 1), 3), ' median rank', np.median(ranks))

# Trials used in the game: first draws from seed 2026, NOT cherry-picked
rng = np.random.default_rng(2026)
trials = []
for kind in ['high', 'low', 'low', 'high', 'low', 'high']:
    x, y0, y, p = make_trial(rng, kind, 15)
    b = slope(x, y); a = icpt(x, y)
    res = y - (a + b * x)
    print(kind, 'planted idx', p, 'x', x[p], '|resid| rank', rank_of(x, y, p),
          'biggest-resid x', x[int(np.argmax(np.abs(res)))],
          'slope true', round(slope(x, y0), 3), 'slope planted', round(b, 3))
    trials.append({'kind': kind, 'x': [float(v) for v in x], 'y_orig': [float(v) for v in y0],
                   'y': [float(v) for v in y], 'planted': p, 'resid_rank': rank_of(x, y, p)})
json.dump(trials, open('round3_trials.json', 'w'))
print(json.dumps(trials))
