import requests, pandas as pd, io
sites=["01473000","01465500","01475510","014670261","01478120","01480617"]
base="https://api.waterdata.usgs.gov/ogcapi/v0/collections"
out=[]
for s in sites:
    m=requests.get(f"{base}/monitoring-locations/items/USGS-{s}?f=json").json()["properties"]
    r=requests.get(f"{base}/daily/items",params=dict(f="csv",monitoring_location_id=f"USGS-{s}",parameter_code="00095",statistic_id="00003",time="2020-10-01/2025-09-30",limit=10000))
    d=pd.read_csv(io.StringIO(r.text)); d["site"]=s; d["name"]=m["monitoring_location_name"]
    print(s,m["monitoring_location_name"],m.get("drainage_area"),len(d))
    out.append(d[["site","name","time","value","approval_status","qualifier"]])
pd.concat(out).to_csv("sc_daily_raw.csv",index=False)
