"""Extract real early-career wages for bachelor's holders from the 2024 ACS 1-year PUMS.

Source: https://www2.census.gov/programs-surveys/acs/data/pums/2024/1-Year/csv_pus.zip
Filter: age 22-25, highest degree = bachelor's (SCHL=21), worked >=35 hrs/wk and
>=50 weeks in the past 12 months, wage income > 0.
WAGP = wages/salary past 12 months; PWGTP = person weight; ADJINC = inflation adjuster (x1e-6).
"""
import sys, zipfile
import numpy as np, pandas as pd

ZIP = sys.argv[1] if len(sys.argv) > 1 else "/tmp/csv_pus2024.zip"
cols = ["STATE", "AGEP", "SCHL", "WKHP", "WKWN", "WAGP", "PWGTP", "ADJINC"]
parts = []
with zipfile.ZipFile(ZIP) as z:
    for name in [n for n in z.namelist() if n.endswith(".csv")]:
        for chunk in pd.read_csv(z.open(name), usecols=cols, chunksize=500_000):
            parts.append(chunk[chunk.AGEP.between(22, 25) & (chunk.SCHL == 21)])
df = pd.concat(parts)
ft = df[(df.WKHP >= 35) & (df.WKWN >= 50) & (df.WAGP > 0)].copy()
ft["salary"] = (ft.WAGP * ft.ADJINC / 1e6).round()
ft[["STATE", "AGEP", "salary", "PWGTP"]].to_csv("acs2024_new_grads_fulltime.csv", index=False)

def wmedian(x, w):
    o = np.argsort(x); x, w = x[o], w[o]
    c = np.cumsum(w); return x[np.searchsorted(c, c[-1] / 2)]

x, w = ft.salary.values, ft.PWGTP.values
print("records:", len(ft), " people represented:", w.sum())
print("unweighted mean/median:", round(x.mean()), round(np.median(x)))
print("weighted   mean/median:", round(np.average(x, weights=w)), round(wmedian(x, w)))
print("max:", x.max(), " n>=200k:", (x >= 200000).sum())
print("pctiles 1,10,25,75,90,99:", np.percentile(x, [1, 10, 25, 75, 90, 99]).round())
print("top values:", np.sort(x)[-15:])
