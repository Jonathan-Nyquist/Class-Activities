import json, numpy as np, pandas as pd
d = pd.read_csv("acs2024_new_grads_fulltime.csv")
x, w = d.salary.values, d.PWGTP.values
def wmed(x, w):
    o = np.argsort(x); c = np.cumsum(w[o]); return x[o][np.searchsorted(c, c[-1] / 2)]
edges = np.arange(0, 255000, 5000)
k = np.clip((x // 5000).astype(int), 0, len(edges) - 1)
pct = np.bincount(k, weights=w, minlength=len(edges)) / w.sum() * 100
caps = {}
for cap in [None, 300000, 200000, 150000]:
    m = np.ones(len(x), bool) if cap is None else x < cap
    caps[str(cap)] = dict(mean=round(np.average(x[m], weights=w[m])), med=round(wmed(x[m], w[m])),
                          dropped=round((~m * w).sum() / w.sum() * 100, 2))
print(json.dumps(dict(pct=[round(p, 3) for p in pct], caps=caps, n=len(x))))
