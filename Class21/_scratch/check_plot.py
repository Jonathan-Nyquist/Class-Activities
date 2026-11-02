import sys, numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from datascience import *
import datascience
print('datascience', datascience.__version__)

def standard_units(arr):
    return (arr - np.mean(arr)) / np.std(arr)

exec(open('_scratch/helper.py').read())
faithful = Table.read_table('data/faithful.csv')
noise = Table.read_table('data/noise.csv')
for name, t, k, seeds in [('faithful', faithful, 2, range(10)), ('noise', noise, 2, range(4)), ('faithful', faithful, 3, range(8))]:
    for s in seeds:
        c = kmeans(t, k, s)
        print(name, k, s, sorted(list(c.group('cluster').column('count'))))
c = kmeans(faithful, 2, 0)
plot_clusters(c, 'test')
plt.savefig('_scratch/test_' + datascience.__version__ + '.png', dpi=80, bbox_inches='tight')
print(c.group('cluster'))
