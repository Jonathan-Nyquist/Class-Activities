"""Does a permutation p-value (data-only, Class 15) agree better with the bootstrap CI than the known-SD null does?"""
import numpy as np
rng = np.random.default_rng(5026)
SD, N, K, B = 40, 12, 3000, 1000

null = rng.normal(150, SD, (200000, N)).mean(1) - rng.normal(150, SD, (200000, N)).mean(1)
a = np.sort(np.abs(null))
def p_known(o):
    return (len(a) - np.searchsorted(a, abs(o))) / len(a)

stats = {'ci_ex0': 0, 'p_known': 0, 'p_perm': 0, 'dis_known': 0, 'dis_perm': 0, 'known_perm_dis': 0}
for k in range(K):
    up = rng.normal(150, SD, N); dn = rng.normal(183, SD, N)
    o = dn.mean() - up.mean()
    bu = up[rng.integers(0, N, (B, N))].mean(1); bd = dn[rng.integers(0, N, (B, N))].mean(1)
    lo, hi = np.percentile(bd - bu, [2.5, 97.5]); ex = lo > 0 or hi < 0
    pooled = np.concatenate([up, dn])
    idx = np.argsort(rng.random((B, 2 * N)), axis=1)
    sh = pooled[idx]
    pd = sh[:, N:].mean(1) - sh[:, :N].mean(1)
    pp = np.mean(np.abs(pd) >= abs(o))
    sk = p_known(o) < 0.05; sp = pp < 0.05
    stats['ci_ex0'] += ex; stats['p_known'] += sk; stats['p_perm'] += sp
    stats['dis_known'] += ex != sk; stats['dis_perm'] += ex != sp; stats['known_perm_dis'] += sk != sp
for key in stats:
    print('%-15s %.3f' % (key, stats[key] / K))
