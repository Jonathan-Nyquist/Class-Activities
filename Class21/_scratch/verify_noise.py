import numpy as np
from datascience import *
exec(open('verify.py').read().split("print('== Old")[0])

for gseed in [21, 2021, 1913]:
    np.random.seed(gseed)
    noise = Table().with_columns('eruptions', np.round(np.random.uniform(1.6, 5.1, 272), 2),
                                 'waiting', np.round(np.random.uniform(43, 96, 272)))
    print('== noise data seed', gseed)
    for s in range(12):
        lab, st, sp = kmeans(noise, 2, s)
        print(s, st, round(sp, 1), summary(noise, lab, 2))
    print('-- k=3')
    for s in range(6):
        lab, st, sp = kmeans(noise, 3, s)
        print(s, st, round(sp, 1), [r[0] for r in summary(noise, lab, 3)])
