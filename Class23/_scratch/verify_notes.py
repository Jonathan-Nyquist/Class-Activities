"""Re-verify instructor-note claims carried over from the draft: Goodman values, bootstrap coverage at n=12."""
import numpy as np
from math import erf, sqrt

rng = np.random.default_rng(4026)
SD, N = 40, 12
SE = SD * np.sqrt(2 / N)

def Phi(x):
    return 0.5 * (1 + np.vectorize(erf)(x / sqrt(2)))

def surveys(t, k):
    return rng.normal(150 + t, SD, (k, N)).mean(1) - rng.normal(150, SD, (k, N)).mean(1)

null = surveys(0, 200000)
a = np.sort(np.abs(null))
def pv(o):
    return (len(a) - np.searchsorted(a, np.abs(o))) / len(a)
cut = np.percentile(a, 95)
print('SE %.2f, cutoff %.2f' % (SE, cut))

# Goodman / observed power: replicate centred on observed difference
def goodman(obs):
    return (1 - Phi((cut - np.abs(obs)) / SE)) + Phi((-cut - np.abs(obs)) / SE)
for target in [0.01, 0.03, 0.05]:
    d = np.quantile(a, 1 - target)
    print('Goodman at p=%.2f: %.2f' % (target, goodman(np.array([d]))[0]))
obs = surveys(33, 200000); p = pv(obs); g = goodman(obs)
rep = pv(surveys(33, 200000))
for lo, hi in [(0, .001), (.001, .01), (.01, .05), (.05, .2), (.2, 1.01)]:
    m = (p >= lo) & (p < hi)
    print('bin [%g,%g): replicate %.3f  Goodman avg %.2f' % (lo, hi, np.mean(rep[m] < .05), g[m].mean()))

# bootstrap coverage, 4000 surveys x 1000 resamples
K, B = 4000, 1000
cover = 0; excl0 = 0; sig = 0; disagree = 0; widths = []
for k in range(K):
    up = rng.normal(150, SD, N); dn = rng.normal(183, SD, N)
    o = dn.mean() - up.mean()
    bu = up[rng.integers(0, N, (B, N))].mean(1); bd = dn[rng.integers(0, N, (B, N))].mean(1)
    lo, hi = np.percentile(bd - bu, [2.5, 97.5])
    cover += lo <= 33 <= hi; ex = lo > 0 or hi < 0; s = pv(np.array([o]))[0] < 0.05
    excl0 += ex; sig += s; disagree += ex != s; widths.append(hi - lo)
print('coverage %.3f, median width %.1f (normal theory %.1f), excl0 %.3f, sig %.3f, disagree %.3f' % (
    cover / K, np.median(widths), 2 * 1.96 * SE, excl0 / K, sig / K, disagree / K))
