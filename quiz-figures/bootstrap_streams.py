import pandas as pd, numpy as np, matplotlib.pyplot as plt
d=pd.read_csv("sc_daily_raw.csv",dtype={"site":str},parse_dates=["time"])
# "population": every Dec–Mar daily mean at Darby Creek near Darby, WY2021–2025
pop=d[(d.site=="01475510")&d.time.dt.month.isin([12,1,2,3])]["value"].dropna().values
rng=np.random.default_rng(0)
s=rng.choice(pop,30,replace=False)                       # 30 randomly chosen winter days
b=np.array([rng.choice(s,len(s)).mean() for _ in range(10000)])
lo,hi=np.percentile(b,[2.5,97.5])
print(f"N={len(pop)} true mean={pop.mean():.1f} median={np.median(pop):.0f}")
print(f"sample mean={s.mean():.1f} CI=({lo:.1f},{hi:.1f}) width={hi-lo:.0f}")
pd.Series(s,name="spec_cond_uS_cm").to_csv("darby_winter_sample30.csv",index=False)
# key for Q13: 4x larger sample
s4=np.random.default_rng(1).choice(pop,120,replace=False)
b4=np.array([np.random.default_rng(i).choice(s4,120).mean() for i in range(5000)])
print("n=120 CI width",np.ptp(np.percentile(b4,[2.5,97.5])).round(0))
fig,ax=plt.subplots(figsize=(8,5))
ax.hist(b,bins=30,color="#6699cc",edgecolor="white")
ax.axvline(lo,color="red",ls="--",lw=2,label=f"2.5% = {lo:.0f}")
ax.axvline(hi,color="red",ls="--",lw=2,label=f"97.5% = {hi:.0f}")
ax.axvline(s.mean(),color="black",ls="-.",lw=2,label=f"Mean = {s.mean():.0f}")
ax.set_xlabel("bootstrap means of specific conductance (µS/cm)"); ax.set_ylabel("Count")
ax.set_title("Bootstrap means with 2.5% and 97.5% percentile markers"); ax.legend()
fig.savefig("darby_bootstrap.png",dpi=200,bbox_inches="tight")
