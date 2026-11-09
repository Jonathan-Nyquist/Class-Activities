"""Power curve in the simulated creek: n = 6/12/24/48 per side (instructor-only; vectorized)."""
import numpy as np

rng = np.random.default_rng(3026)
SD = 40

def surveys(true_diff, n, k):
    up = rng.normal(150, SD, (k, n)).mean(axis=1)
    dn = rng.normal(150 + true_diff, SD, (k, n)).mean(axis=1)
    return dn - up

def pvals(obs, null):
    a = np.sort(np.abs(null))
    return (len(a) - np.searchsorted(a, np.abs(obs), side='left')) / len(a)

print('n   cutoff  power(33)  team5-95     null-rate  team5-95')
res = {}
for n in [6, 12, 24, 48]:
    big_null = surveys(0, n, 200000)
    cut = np.percentile(np.abs(big_null), 95)
    pw = np.mean(pvals(surveys(33, n, 200000), big_null) < 0.05)
    fa = np.mean(pvals(surveys(0, n, 200000), big_null) < 0.05)
    tp, tf = [], []
    for r in range(300):            # one team: own 10k null, 1000 surveys each way
        nd = surveys(0, n, 10000)
        tp.append(np.mean(pvals(surveys(33, n, 1000), nd) < 0.05))
        tf.append(np.mean(pvals(surveys(0, n, 1000), nd) < 0.05))
    res[n] = (pw, fa)
    print('%-3d %5.1f   %.3f      %.2f-%.2f    %.3f      %.3f-%.3f' % (
        n, cut, pw, *np.percentile(tp, [5, 95]), fa, *np.percentile(tf, [5, 95])))

print('\nBase-rate board table: 1000 creeks, 100 real (33 mg/L), 900 none')
for n in [6, 12, 24, 48]:
    pw, fa = res[n]
    tp, fp = 100 * pw, 900 * fa
    print('n=%-2d  true hits %5.1f  false alarms %5.1f  false share %.0f%%' % (n, tp, fp, 100 * fp / (tp + fp)))
