"""Debrief figure: an underpowered survey misses a real 33 mg/L excess.
Same creek as Parts 2-4 (SD 40, true excess 33), known-SD null, two-sided p < 0.05.
One row per team size (6/12/24/48 sites per side). Logs every number printed on the figure."""
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
plt.style.use('fivethirtyeight')
plt.rcParams.update({'figure.facecolor': 'white', 'axes.facecolor': 'white', 'savefig.facecolor': 'white'})

OUT = '../'
SD, TRUE, K = 40, 33, 200000
rng = np.random.default_rng(3026)

def surveys(true_diff, n, k):
    up = rng.normal(150, SD, (k, n)).mean(axis=1)
    dn = rng.normal(150 + true_diff, SD, (k, n)).mean(axis=1)
    return dn - up

fig, axes = plt.subplots(4, 1, figsize=(10, 11), sharex=True)
for ax, n in zip(axes, [6, 12, 24, 48]):
    null = surveys(0, n, K)
    real = surveys(TRUE, n, K)
    cut = np.percentile(np.abs(null), 95)
    hit = np.abs(real) >= cut
    bins = cut + 2 * np.arange(-63, 40)   # bin edge exactly at the cutoff
    power = hit.mean()
    print('n=%-2d cutoff %.1f  power %.3f  missed %.3f  false alarm %.3f' % (
        n, cut, power, 1 - power, np.mean(np.abs(surveys(0, n, K)) >= cut)))

    ax.hist(null, bins=bins, histtype='step', color='gray', linewidth=2, label='no excess (0 mg/L)')
    ax.hist(real[~hit], bins=bins, color='#f5c08a', label='real excess, missed (p ≥ 0.05)')
    ax.hist(real[hit], bins=bins, color='tab:orange', label='real excess, detected (p < 0.05)')
    for c in (-cut, cut):
        ax.axvline(c, color='black', linestyle='--', linewidth=1.5)
    ax.axvline(TRUE, color='red', linewidth=2)
    ax.set_yticks([])
    ax.text(0.99, 0.92, '%d sites per side' % n, transform=ax.transAxes, fontsize=15,
            fontweight='bold', va='top', ha='right')
    ax.text(0.99, 0.72, 'missed %d%% of real excesses' % round(100 * (1 - power)),
            transform=ax.transAxes, fontsize=13, va='top', ha='right', color='#b35900')
    ax.text(-cut, ax.get_ylim()[1] * 0.45, 'cutoffs ±%.0f ' % cut, fontsize=12, ha='right', va='center')

axes[0].text(TRUE, axes[0].get_ylim()[1] * 1.02, 'true excess 33', color='red',
             ha='center', va='bottom', fontsize=12)
h, l = axes[0].get_legend_handles_labels()
fig.legend(h, l, loc='upper center', bbox_to_anchor=(0.5, 0.968), ncol=3, fontsize=11, frameon=False)
axes[-1].set_xlim(-85, 115)
axes[-1].set_xlabel('downstream minus upstream in one survey (mg/L)')
fig.suptitle('Same real excess, different survey sizes', fontsize=20, y=0.995)
plt.tight_layout(rect=(0, 0, 1, 0.965))
plt.savefig(OUT + 'fig_debrief_power.png', dpi=200)
print('figure written')
