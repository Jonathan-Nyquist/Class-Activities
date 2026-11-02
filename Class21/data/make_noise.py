# Generates data/noise.csv: 272 points spread uniformly over the same
# ranges as Old Faithful (eruptions 1.6-5.1 min, waiting 43-96 min).
# Seed 21. Run with the ds313 env from the Class21 folder.
import numpy as np
from datascience import *

np.random.seed(21)
eruptions = np.round(np.random.uniform(1.6, 5.1, 272), 2)
waiting = np.round(np.random.uniform(43, 96, 272))
noise = Table().with_columns('eruptions', eruptions, 'waiting', waiting)
noise.to_csv('data/noise.csv')
print(noise.num_rows, 'rows written to data/noise.csv')
