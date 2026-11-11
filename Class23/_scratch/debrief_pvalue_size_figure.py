"""Debrief figure: a p-value does not tell you how big the excess is.
Left: four surveys that all give p = 0.01, at 6 / 12 / 48 / 20,000 sites per side -> very different estimated excesses.
Right: 12-site surveys of the same creek (true excess 33) -> p ranges over orders of magnitude.
Known-SD null as in the activity. With known SD the difference of means is exactly Normal(true, 40*sqrt(2/n)),
so differences are drawn from that directly (identical distribution to averaging n sites; needed for n = 20,000)."""
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
plt.style.use('fivethirtyeight')
plt.rcParams.update({'figure.facecolor': 'white', 'axes.facecolor': 'white', 'savefig.facecolor': 'white'})

OUT = '../'
SD = 40
rng = np.random.default_rng(6026)

def diffs(true_diff, n, k):
    return rng.normal(true_diff, SD * np.sqrt(2 / n), k)

def pvals(obs, null):
    a = np.sort(np.abs(null))
    return (len(a) - np.searchsorted(a, np.abs(obs), side='left')) / len(a)

# ---- Left: the excess that gives p = 0.01 at each survey size ----
sizes = [6, 12, 48, 20000]
rows = []
for n in sizes:
    null = diffs(0, n, 1000000)
    d01 = np.percentile(np.abs(null), 99)          # |difference| with p = 0.01
    se = null.std()
    lo, hi = d01 - 1.96 * se, d01 + 1.96 * se
    rows.append((n, d01, lo, hi))
    print('n=%-5d  difference giving p=0.01: %6.2f mg/L   95%% range %6.2f to %6.2f   (check p=%.4f)' % (
        n, d01, lo, hi, pvals(np.array([d01]), null)[0]))

# ---- Right: same creek, true 33, n = 12 ----
null12 = diffs(0, 12, 1000000)
p12 = pvals(diffs(33, 12, 400000), null12)
print('n=12 true 33: p 10/50/90 pct', np.round(np.percentile(p12, [10, 50, 90]), 4),
      ' share p<0.001 %.3f, p>0.2 %.3f' % (np.mean(p12 < 0.001), np.mean(p12 > 0.2)))
show = p12[:200]
show = np.clip(show, 1e-5, 1)   # p below 0.00001 plotted at 0.00001
print('shown 200: p<.05 %d, clipped at 1e-5: %d, max %.2f' % (np.sum(show < 0.05), np.sum(p12[:200] < 1e-5), show.max()))

fig, (axL, axR) = plt.subplots(1, 2, figsize=(14, 6.2), gridspec_kw={'width_ratios': [1.15, 1]})
for i, (n, d, lo, hi) in enumerate(rows):
    y = len(rows) - 1 - i
    axL.plot([lo, hi], [y, y], color='tab:orange', linewidth=7, solid_capstyle='butt', alpha=0.45)
    axL.plot(d, y, 'o', color='tab:orange', markersize=12, markeredgecolor='black')
    if d >= 10:
        axL.text(d, y + 0.28, '%.0f mg/L' % d, ha='center', fontsize=12)
    else:
        axL.text(d + 3, y, '%.1f mg/L  (Part 7 survey size)' % d, ha='left', va='center', fontsize=12)
axL.axvline(0, color='black', linestyle=':', linewidth=1.5)
axL.set_yticks(range(len(rows)))
axL.set_yticklabels(['6 sites', '12 sites', '48 sites', '20,000 readings'][::-1], fontsize=13)
axL.set_ylim(-0.6, len(rows) - 0.3)
axL.set_xlim(-5, 110)
axL.set_xlabel('estimated excess (mg/L), bar = 95% range')
axL.set_title('Every one of these surveys: p = 0.01', fontsize=15)

jit = np.random.default_rng(1).uniform(-1, 1, len(show))
col = np.where(show < 0.05, 'tab:orange', '#f5c08a')
axR.scatter(show, jit, c=col, s=40, edgecolors='none')
axR.axvline(0.05, color='black', linestyle='--', linewidth=1.5)
axR.text(0.05, 1.35, ' p = 0.05', fontsize=12, va='center')
axR.set_xscale('log'); axR.set_xlim(5e-6, 1.5)
axR.set_xticks([1e-5, 1e-4, 1e-3, 1e-2, 1e-1, 1])
axR.set_xticklabels(['≤0.00001', '0.0001', '0.001', '0.01', '0.1', '1'], fontsize=11)
axR.set_yticks([]); axR.set_ylim(-1.6, 1.6)
axR.set_xlabel("survey's p-value (log scale)")
axR.set_title('200 surveys of one creek, true excess 33\n(12 sites each)', fontsize=15)

fig.suptitle('The p-value does not tell you how big the excess is', fontsize=20)
plt.tight_layout()
plt.savefig(OUT + 'fig_debrief_pvalue_size.png', dpi=200)
print('figure written')
