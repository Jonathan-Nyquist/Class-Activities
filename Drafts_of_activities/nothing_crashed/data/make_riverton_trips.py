import numpy as np, csv, datetime
rng = np.random.default_rng(1414)
routes = {'Blue':300,'Red':150,'Green':100,'Gold':70}
base = {'Blue':-0.4,'Red':0.4,'Green':1.2,'Gold':2.2}
rows=[]
start=datetime.date(2025,1,1)
for r,n in routes.items():
    days = rng.integers(0,365,n)
    for d in days:
        date = start+datetime.timedelta(days=int(d))
        m = date.month
        winter = {1:4.0,2:2.0,12:1.5}.get(m,0.0)
        rain = rng.random() < 0.25
        mu = base[r] + winter + (1.5 if rain else 0)
        late = rng.normal(mu, 3.5)
        rows.append((date.isoformat(), r, 'rain' if rain else 'dry', round(late,1)))
rows.sort(key=lambda x:(x[0],x[1]))
with open('/Users/nyq/Documents/Python/Class-Activities/Drafts_of_activities/nothing_crashed/data/riverton_trips.csv','w',newline='') as f:
    w=csv.writer(f); w.writerow(['date','line','minutes late'])
    for row in rows: w.writerow((row[0],row[1],row[3]))
