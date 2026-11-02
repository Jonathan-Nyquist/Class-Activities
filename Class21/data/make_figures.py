# Builds the handout and reveal figures for Class 21. Run from Class21/ with ds313.
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from datascience import *

def standard_units(arr):
    return (arr - np.mean(arr)) / np.std(arr)

exec(open('data/kmeans_helper.py').read())

faithful = Table.read_table('data/faithful.csv')
noise = Table.read_table('data/noise.csv')
colors = ['#1f4e9e', '#c8102e', '#e8a33d']

def blank_scatter(tbl, fname, title):
    fig, ax = plt.subplots(figsize=(5.2, 4.2))
    ax.scatter(tbl.column(0), tbl.column(1), s=14, color='#555555')
    ax.set_xlabel('eruption length (minutes)')
    ax.set_ylabel('waiting time before eruption (minutes)')
    ax.set_xlim(1.4, 5.3); ax.set_ylim(40, 99)
    ax.grid(True, color='#dddddd'); ax.set_axisbelow(True)
    ax.set_title(title)
    fig.savefig(fname, dpi=200, bbox_inches='tight'); plt.close(fig)

def panel(ax, tbl, k, seed):
    c = kmeans(tbl, k, seed)
    sizes = []
    for g in np.arange(k):
        sub = c.where('cluster', g)
        ax.scatter(sub.column(0), sub.column(1), s=10, color=colors[g])
        sizes.append(sub.num_rows)
    ax.set_title('seed = ' + str(seed) + '   sizes: ' + ', '.join(str(s) for s in sorted(sizes)), fontsize=10)
    ax.set_xlim(1.4, 5.3); ax.set_ylim(40, 99)
    ax.set_xlabel('eruptions'); ax.set_ylabel('waiting')

def reveal(tbl, k, seeds, fname, suptitle):
    fig, axes = plt.subplots(1, len(seeds), figsize=(4.2 * len(seeds), 3.8))
    for ax, s in zip(axes, seeds):
        panel(ax, tbl, k, s)
    fig.suptitle(suptitle)
    fig.tight_layout()
    fig.savefig(fname, dpi=160, bbox_inches='tight'); plt.close(fig)

blank_scatter(faithful, 'fig_faithful.png', 'Old Faithful: 272 eruptions')
blank_scatter(noise, 'fig_noise.png', 'Random points: 272 rows, no groups built in')
reveal(faithful, 2, [0, 2], 'fig_reveal_faithful_k2.png', 'Old Faithful, k = 2')
reveal(noise, 2, [0, 2], 'fig_reveal_noise_k2.png', 'Random points, k = 2')
reveal(faithful, 3, [0, 6], 'fig_reveal_faithful_k3.png', 'Old Faithful, k = 3')
print('done')
