import numpy as np
import json
from datascience import Table   # confirms the course package is now importable in ds313

def su(a):
    return (a - np.mean(a)) / np.std(a)

def slope(x, y):
    return np.mean(su(x) * su(y)) * np.std(y) / np.std(x)

def icpt(x, y):
    return np.mean(y) - slope(x, y) * np.mean(x)

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

def probe(x, y, i):
    # remove point i, refit, report slope change and point i's miss from the refit line
    xr = np.delete(x, i); yr = np.delete(y, i)
    b = slope(xr, yr); a = icpt(xr, yr)
    return slope(x, y) - b, y[i] - (a + b * x[i])

def stats(x, y):
    res = y - (icpt(x, y) + slope(x, y) * x)
    return res

# Strategy check over 2000 simulated datasets of each kind
for kind in ['high', 'low']:
    rng = np.random.default_rng(1)
    naive = 0; strat = 0; far_innocent_miss = []; plant_miss = []
    for k in range(2000):
        x, y0, y, p = make_trial(rng, kind, 15)
        res = stats(x, y)
        top = int(np.argmax(np.abs(res)))
        far = int(np.argmax(x))
        naive += (top == p)
        # two-probe strategy: probe the far point and the biggest-residual point,
        # accuse whichever has the bigger miss from the line refit without it
        cands = [far] if top == far else [far, top]
        misses = [abs(probe(x, y, c)[1]) for c in cands]
        strat += (cands[int(np.argmax(misses))] == p)
        plant_miss.append(abs(probe(x, y, p)[1]))
        if kind == 'low':
            far_innocent_miss.append(abs(probe(x, y, far)[1]))
    print(kind, 'naive biggest-residual correct', round(naive / 2000, 3),
          ' two-probe strategy correct', round(strat / 2000, 3),
          ' median plant miss-without-it', round(np.median(plant_miss), 1))
    if kind == 'low':
        print('    innocent far point: median miss-without-it', round(np.median(far_innocent_miss), 1),
              ' 95th pct', round(np.percentile(far_innocent_miss, 95), 1))

# The three trials used in the game: first draws from seed 2026, not hand-picked
rng = np.random.default_rng(2026)
trials = []
for kind in ['high', 'low', 'high']:
    x, y0, y, p = make_trial(rng, kind, 15)
    res = stats(x, y)
    top = int(np.argmax(np.abs(res))); far = int(np.argmax(x))
    rank = int(np.sum(np.abs(res) > np.abs(res[p]))) + 1
    print(kind, 'plant x', x[p], 'resid rank', rank, 'slope', round(slope(x, y0), 3), '->', round(slope(x, y), 3))
    for c in sorted(set([p, top, far])):
        d, m = probe(x, y, c)
        print('   probe x=%.1f  dslope %+.3f  miss-without-it %+.1f  resid %+.1f %s' %
              (x[c], d, m, res[c], '<- plant' if c == p else ''))
    trials.append({'kind': kind, 'x': [float(v) for v in x], 'y_orig': [float(v) for v in y0],
                   'y': [float(v) for v in y], 'planted': p, 'resid_rank': rank})
json.dump(trials, open('round3b_trials.json', 'w'))

# ---- Sensitivity: how often does the two-probe strategy work as shift grows?
print()
for shift in [15, 18, 20, 25]:
    out = []
    for kind in ['high', 'low']:
        rng = np.random.default_rng(1); strat = 0
        for k in range(2000):
            x, y0, y, p = make_trial(rng, kind, shift)
            res = stats(x, y); top = int(np.argmax(np.abs(res))); far = int(np.argmax(x))
            cands = [far] if top == far else [far, top]
            misses = [abs(probe(x, y, c)[1]) for c in cands]
            strat += (cands[int(np.argmax(misses))] == p)
        out.append(round(strat / 2000, 3))
    print('shift', shift, 'two-probe correct: far-plant', out[0], ' near-plant', out[1])
