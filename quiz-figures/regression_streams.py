import pandas as pd, numpy as np, matplotlib.pyplot as plt
sc=pd.read_csv("sc_daily_raw.csv",dtype={"site":str}); q=pd.read_csv("q_daily_raw.csv",dtype={"site":str})
m=sc.merge(q,on=["site","time"]).rename(columns={"value":"sc"}); m["time"]=pd.to_datetime(m.time)
d=m[(m.site=="01475510")&(m.time.dt.weekday==1)].dropna(subset=["sc","Q_cfs"]).copy()   # Darby Creek, weekly (Tuesdays), WY2021-25
d["season"]=np.where(d.time.dt.month.isin([12,1,2,3]),"Dec–Mar","Apr–Nov")
d["log10Q"]=np.log10(d.Q_cfs)
d[["time","season","Q_cfs","log10Q","sc"]].to_csv("darby_weekly_sc_q.csv",index=False)
def stats(x,y,a,b):
    r=y-(a*x+b); return 1-(r**2).sum()/((y-y.mean())**2).sum(), np.sqrt((r**2).mean())
def panel(ax,h,a,b,color="tab:blue",title=None):
    R2,rmse=stats(h.log10Q,h.sc,a,b)
    ax.scatter(h.Q_cfs,h.sc,s=14,color=color,alpha=.8)
    xs=np.linspace(h.log10Q.min(),h.log10Q.max(),50); ax.plot(10**xs,a*xs+b,color="red",lw=2,label=f"$R^2$={R2:.2f}, RMSE={rmse:.0f} µS/cm")
    ax.set_xscale("log"); ax.set_xlabel("discharge (ft³/s, log scale)"); ax.set_ylabel("specific conductance (µS/cm)")
    ax.legend(loc="upper right",fontsize=9); 
    if title: ax.set_title(title,fontsize=11)
    return R2,rmse,a,b
s=d[d.season=="Apr–Nov"]; a,b=np.polyfit(s.log10Q,s.sc,1)
fig,axs=plt.subplots(1,2,figsize=(10,4),sharey=True,sharex=True)
print("best",panel(axs[0],s,a,b,title="Line A"))
a2=a*0.5; b2=s.sc.mean()-a2*s.log10Q.mean()
print("alt",panel(axs[1],s,a2,b2,title="Line B"))
fig.tight_layout(); fig.savefig("darby_reg_two_lines.png",dpi=200)
w=d[d.season=="Dec–Mar"]; aw,bw=np.polyfit(w.log10Q,w.sc,1)
fig,axs=plt.subplots(1,2,figsize=(10,4),sharey=True,sharex=True)
print("AprNov",panel(axs[0],s,a,b,title="Apr–Nov"))
print("DecMar",panel(axs[1],w,aw,bw,color="tab:orange",title="Dec–Mar"))
fig.tight_layout(); fig.savefig("darby_reg_seasons.png",dpi=200)
print(len(s),len(w), "Q range",s.Q_cfs.min(),s.Q_cfs.max(), "median Q",s.Q_cfs.median())
