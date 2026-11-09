import seaborn as sns, matplotlib.pyplot as plt, pandas as pd
sns.set_theme(style="whitegrid")
def iqr(s): return s.quantile(.75)-s.quantile(.25)
def nout(s):
    q1,q3=s.quantile(.25),s.quantile(.75); i=q3-q1
    return int(((s<q1-1.5*i)|(s>q3+1.5*i)).sum())
d=sns.load_dataset("diamonds")
d=d[d.cut.isin(["Fair","Good","Ideal"])].copy()
d["cut"]=d.cut.cat.remove_unused_categories().cat.reorder_categories(["Fair","Good","Ideal"])
d["size"]=pd.cut(d.carat,[0,1,99],right=False,labels=["under 1 carat","1 carat or more"])
print(d.groupby("cut",observed=True)["price"].agg(["count","median",iqr,nout]))
print(d.groupby(["cut","size"],observed=True)["price"].agg(["count","median",iqr,nout]))
print(d.groupby("cut",observed=True)["carat"].agg(["median",lambda s:(s>=1).mean()]))

s=d.groupby(["cut","size"],observed=True).sample(n=100,random_state=301)
s.to_csv("diamonds_quiz_sample.csv",index=False)
print(s.groupby(["cut","size"],observed=True)["price"].agg(["median",iqr,nout,"max"]))
fig,ax=plt.subplots(figsize=(7,5))
sns.boxplot(s,x="cut",y="price",hue="size",ax=ax,fliersize=4)
ax.set_xlabel("cut quality (Fair → Ideal = worse → better)"); ax.set_ylabel("price (US $)")
ax.legend(title="diamond size",loc="upper left",bbox_to_anchor=(1.01,1))
fig.savefig("diamonds_cut_price_box.png",dpi=200,bbox_inches="tight")
