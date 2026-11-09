"""Re-verify 'Would It Replicate?' numbers in ds313 (instructor-only; vectorized)."""
import time
import numpy as np
from datascience import make_array, percentile

rng = np.random.default_rng(2026)
SD, N = 40, 12

def surveys(true_diff, n, k):
    up = rng.normal(150, SD, (k, n)).mean(axis=1)
    dn = rng.normal(150 + true_diff, SD, (k, n)).mean(axis=1)
    return dn - up

def pvals(obs, null):
    a = np.sort(np.abs(null))
    return (len(a) - np.searchsorted(a, np.abs(obs), side='left')) / len(a)

# --- null and cutoff (10,000 like the notebook, repeated) ---
cuts, sds = [], []
for r in range(30):
    nd = surveys(0, N, 10000)
    cuts.append(np.percentile(np.abs(nd), 95)); sds.append(nd.std())
print('null SD range %.2f-%.2f; cutoff range %.1f-%.1f' % (min(sds), max(sds), min(cuts), max(cuts)))

big_null = surveys(0, N, 200000)
obs = surveys(33, N, 400000)
p = pvals(obs, big_null)
print('power n=12: %.3f' % np.mean(p < 0.05))
print('p percentiles 10/50/90:', np.round(np.percentile(p, [10, 50, 90]), 4))
for v in [34, 35, 36]:
    print('p of', v, '=', round(pvals(np.array([v]), big_null)[0], 3))

# --- conditional replication by bin ---
rep = pvals(surveys(33, N, 400000), big_null)
bins = [(0, 0.001), (0.001, 0.01), (0.01, 0.05), (0.05, 0.2), (0.2, 1.01)]
for a, b in bins:
    m = (p >= a) & (p < b)
    print('orig p in [%g,%g): n=%d rep sig %.3f' % (a, b, m.sum(), np.mean(rep[m] < 0.05)))

# --- team-level noise with 10k null and 1000 pairs ---
kept, cond = [], []
for r in range(500):
    nd = surveys(0, N, 10000)
    o = pvals(surveys(33, N, 1000), nd); rr = pvals(surveys(33, N, 1000), nd)
    m = (o >= 0.01) & (o < 0.05)
    kept.append(m.sum()); cond.append(np.mean(rr[m] < 0.05))
print('kept median %d (5-95: %d-%d); cond rate 5-95: %.2f-%.2f' % (
    np.median(kept), *np.percentile(kept, [5, 95]), *np.percentile(cond, [5, 95])))

# --- base-rate tree ---
pw = np.mean(p < 0.05); win_r = np.mean((p >= 0.01) & (p < 0.05))
pn = pvals(surveys(0, N, 400000), big_null)
a_ = np.mean(pn < 0.05); win_n = np.mean((pn >= 0.01) & (pn < 0.05))
print('null p<.05 %.3f, window real %.3f, window null %.3f' % (a_, win_r, win_n))
for prior in [0.10, 0.25, 0.50]:
    f1 = (1 - prior) * a_ / ((1 - prior) * a_ + prior * pw)
    f2 = (1 - prior) * win_n / ((1 - prior) * win_n + prior * win_r)
    print('prior %.2f: false share p<.05 %.1f%%, window %.1f%%' % (prior, 100 * f1, 100 * f2))

# --- winner's curse ---
print("winner's curse: mean sig diff %.1f, nonsig %.1f, share sig>=40 %.2f" % (
    obs[p < 0.05].mean(), obs[p >= 0.05].mean(), np.mean(obs[p < 0.05] >= 40)))

# --- seed-120 strip, exact notebook code path (same RNG call order) ---
np.random.seed(120)
rows = []
for s in np.arange(20):
    upstream = np.random.normal(150, 40, 12)
    downstream = np.random.normal(183, 40, 12)
    observed = np.mean(downstream) - np.mean(upstream)
    boot = make_array()
    for i in np.arange(1000):
        up_resample = np.random.choice(upstream, 12)
        down_resample = np.random.choice(downstream, 12)
        boot = np.append(boot, np.mean(down_resample) - np.mean(up_resample))
    rows.append((s + 1, observed, percentile(2.5, boot), percentile(97.5, boot), pvals(np.array([observed]), big_null)[0]))
np.random.seed(None)
for r in rows:
    print('%2d  %6.1f  [%6.1f, %6.1f]  p=%.4f' % r)
print('cover 33:', sum(1 for r in rows if r[2] <= 33 <= r[3]), ' p<.05:', sum(1 for r in rows if r[4] < 0.05),
      ' CI above 0:', sum(1 for r in rows if r[2] > 0))

# --- notebook-style loop timing (np.append, 10,000 null) ---
def sample_creek(t):
    return np.mean(np.random.normal(150 + t, 40, 12)) - np.mean(np.random.normal(150, 40, 12))
t0 = time.time()
nd = make_array()
for i in np.arange(10000):
    nd = np.append(nd, sample_creek(0))
print('notebook null build: %.1f s' % (time.time() - t0))
