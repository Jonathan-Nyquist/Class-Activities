import pandas as pd, seaborn as sns, matplotlib.pyplot as plt
sns.set_theme(style="whitegrid")
def iqr(s): return s.quantile(.75)-s.quantile(.25)
def outs(s):
    q1,q3=s.quantile(.25),s.quantile(.75); i=q3-q1
    return f"{int((s<q1-1.5*i).sum())} low / {int((s>q3+1.5*i).sum())} high"
d=pd.read_csv("sc_daily_raw.csv",dtype={"site":str},parse_dates=["time"])
lab={"01478120":"White Clay Creek\n(agricultural)","01465500":"Neshaminy Creek\n(suburban)","01475510":"Darby Creek\n(urban)"}
d=d[d.site.isin(lab)&(d.time.dt.weekday==1)].copy()   # one reading per week (Tuesdays), WY2021–2025
d["stream"]=pd.Categorical(d.site.map(lab),categories=list(lab.values()))
d["season"]=pd.Categorical(d.time.dt.month.isin([12,1,2,3]).map({True:"Dec–Mar",False:"Apr–Nov"}),categories=["Apr–Nov","Dec–Mar"])
d=d.rename(columns={"value":"spec_cond_uS_cm"})
d[["site","name","time","stream","season","spec_cond_uS_cm"]].to_csv("streams_weekly_sc.csv",index=False)
print(d.groupby(["stream","season"],observed=True)["spec_cond_uS_cm"].agg(["count","median",iqr,outs,"min","max"]))
fig,ax=plt.subplots(figsize=(7.5,5))
sns.boxplot(d,x="stream",y="spec_cond_uS_cm",hue="season",ax=ax,fliersize=4)
ax.set_xlabel(""); ax.set_ylabel("specific conductance (µS/cm at 25 °C)")
ax.legend(title="season",loc="upper left",bbox_to_anchor=(1.01,1))
fig.savefig("streams_sc_box.png",dpi=200,bbox_inches="tight")
