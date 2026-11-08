"""Coverage of 95% intervals for a difference in means, normal data SD 40, no true difference.
False alarm of 'reject if 0 outside CI' = 1 - coverage. Percentile vs BCa vs bootstrap-t vs Welch t."""
import numpy as np
from scipy import stats

rng = np.random.default_rng(8026)
SD, K, B = 40, 3000, 2000

def bca(up, dn, boot, obs):
    z0 = stats.norm.ppf(np.mean(boot < obs))
    # jackknife over all 2N points (leave one out from either group)
    jk = [np.delete(dn, i).mean() - up.mean() for i in range(len(dn))] + \
         [dn.mean() - np.delete(up, i).mean() for i in range(len(up))]
    jk = np.array(jk); m = jk.mean()
    acc = np.sum((m - jk) ** 3) / (6 * np.sum((m - jk) ** 2) ** 1.5)
    out = []
    for q in [0.025, 0.975]:
        z = stats.norm.ppf(q)
        out.append(stats.norm.cdf(z0 + (z0 + z) / (1 - acc * (z0 + z))))
    return np.quantile(boot, out)

print('n/side  percentile  BCa     boot-t  Welch-t   (false-alarm rate with no real difference)')
for N in [6, 12, 24, 48]:
    miss = np.zeros(4)
    for k in range(K):
        up = rng.normal(150, SD, N); dn = rng.normal(150, SD, N)
        obs = dn.mean() - up.mean()
        iu = rng.integers(0, N, (B, N)); idn = rng.integers(0, N, (B, N))
        bu = up[iu]; bd = dn[idn]
        boot = bd.mean(1) - bu.mean(1)
        se_b = np.sqrt(bd.var(1, ddof=1) / N + bu.var(1, ddof=1) / N)
        se = np.sqrt(dn.var(ddof=1) / N + up.var(ddof=1) / N)
        tstar = (boot - obs) / se_b
        cis = [np.percentile(boot, [2.5, 97.5]),
               bca(up, dn, boot, obs),
               [obs - np.quantile(tstar, 0.975) * se, obs - np.quantile(tstar, 0.025) * se]]
        df = se ** 4 / ((dn.var(ddof=1) / N) ** 2 / (N - 1) + (up.var(ddof=1) / N) ** 2 / (N - 1))
        tq = stats.t.ppf(0.975, df)
        cis.append([obs - tq * se, obs + tq * se])
        for j, (lo, hi) in enumerate(cis):
            miss[j] += not (lo <= 0 <= hi)
    print('%-6d  %.3f       %.3f   %.3f   %.3f' % (N, *(miss / K)))
