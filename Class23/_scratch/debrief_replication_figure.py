"""Debrief figure: what controls whether a repeat survey is also significant.
Left: original p-value band (n = 12, true excess 33) -> repeat rate is flat at the power,
      versus the 'observed power' guess that treats the original estimate as the truth.
Right: repeat rate vs sites per side for several true excesses (repeat rate = power of the repeat).
Same creek as the activity: SD 40, known-SD null, two-sided p < 0.05. Logs every plotted number."""
import numpy as np
from math import erf, sqrt
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
plt.style.use('fivethirtyeight')
plt.rcParams.update({'figure.facecolor': 'white', 'axes.facecolor': 'white', 'savefig.facecolor': 'white'})

OUT = '../'
SD = 40
rng = np.random.default_rng(5026)

def surveys(true_diff, n, k):
    up = rng.normal(150, SD, (k, n)).mean(axis=1)
    dn = rng.normal(150 + true_diff, SD, (k, n)).mean(axis=1)
    return dn - up

def pvals(obs, null):
    a = np.sort(np.abs(null))
    return (len(a) - np.searchsorted(a, np.abs(obs), side='left')) / len(a)

Phi = np.vectorize(lambda x: 0.5 * (1 + erf(x / sqrt(2))))

# ---- Left panel: n = 12, true 33 ----
N = 12
null12 = surveys(0, N, 200000)
cut12 = np.percentile(np.abs(null12), 95)
SE = SD * np.sqrt(2 / N)
obs_orig = surveys(33, N, 400000)
p_orig = pvals(obs_orig, null12)
p_rep = pvals(surveys(33, N, 400000), null12)
guess = (1 - Phi((cut12 - np.abs(obs_orig)) / SE)) + Phi((-cut12 - np.abs(obs_orig)) / SE)
bands = [(0, .001), (.001, .01), (.01, .05), (.05, .2), (.2, 1.01)]
labels = ['< 0.001', '0.001–0.01', '0.01–0.05', '0.05–0.2', '> 0.2']
actual, guessed = [], []
print('n=12 cutoff %.1f, power %.3f' % (cut12, np.mean(p_rep < 0.05)))
for (lo, hi), lab in zip(bands, labels):
    m = (p_orig >= lo) & (p_orig < hi)
    actual.append(np.mean(p_rep[m] < 0.05)); guessed.append(guess[m].mean())
    print('orig p %-11s share %.3f  repeat sig %.3f  observed-power guess %.2f' % (lab, m.mean(), actual[-1], guessed[-1]))
power12 = np.mean(p_rep < 0.05)

# ---- Right panel: repeat rate (= power) vs sites per side ----
ns = np.arange(4, 61, 2)
effects = [(50, '#7a3d00'), (33, 'tab:orange'), (15, '#f5c08a'), (0, 'gray')]
curves = {}
for t, c in effects:
    curves[t] = []
    for n in ns:
        nd = surveys(0, n, 40000)
        cut = np.percentile(np.abs(nd), 95)
        curves[t].append(np.mean(np.abs(surveys(t, n, 40000)) >= cut))
    print('true %2d: ' % t + ' '.join('n%d=%.2f' % (n, v) for n, v in zip(ns, curves[t]) if n in (6, 12, 24, 48)))

fig, (axL, axR) = plt.subplots(1, 2, figsize=(14, 6.2), gridspec_kw={'width_ratios': [1, 1.1]})
x = np.arange(len(labels))
axL.bar(x, actual, color='tab:orange', width=0.6, label='what actually happened')
axL.plot(x, guessed, 'o', color='black', markersize=10, label='guess: "the original estimate is the truth"')
axL.axhline(power12, color='tab:orange', linestyle=':', linewidth=1.5)
for xi, a in zip(x, actual):
    axL.text(xi, a + 0.02, '%.0f%%' % (100 * a), ha='center', fontsize=12)
axL.set_xticks(x); axL.set_xticklabels(labels, fontsize=11)
axL.set_xlabel("original survey's p-value"); axL.set_ylabel('repeat survey also p < 0.05')
axL.set_ylim(0, 1.1); axL.set_yticks([0, .25, .5, .75, 1]); axL.set_yticklabels(['0%', '25%', '50%', '75%', '100%'])
axL.set_title('Original p-value: no effect\n(12 sites, true excess 33)', fontsize=15)
axL.legend(loc='upper right', fontsize=10.5, frameon=False)

for t, c in effects:
    axR.plot(ns, curves[t], color=c, linewidth=3, label='true excess %d mg/L' % t if t else 'no excess')
for n in (6, 12, 24, 48):
    axR.plot(n, curves[33][list(ns).index(n)], 'o', color='tab:orange', markersize=9, markeredgecolor='black')
axR.set_xlabel('sites per side'); axR.set_xticks([6, 12, 24, 36, 48, 60])
axR.set_ylim(0, 1.1); axR.set_yticks([0, .25, .5, .75, 1]); axR.set_yticklabels(['0%', '25%', '50%', '75%', '100%'])
axR.set_title('True excess and number of sites: decide it', fontsize=15)
axR.text(9, 0.87, '50 mg/L', ha='right', va='center', fontsize=12)
for t, c in effects[1:]:
    axR.text(61, curves[t][-1], ('%d mg/L' % t) if t else 'no excess', color='black' if t else 'gray',
             va='center', fontsize=12)
axR.text(61, 1.04, 'true excess', fontsize=11, va='bottom', color='dimgray')
axR.set_xlim(3, 71)
axR.text(28, 0.68, 'dots: your four teams\n(6, 12, 24, 48 sites)', fontsize=11)
fig.suptitle('What decides whether a result replicates?', fontsize=20)
plt.tight_layout()
plt.savefig(OUT + 'fig_debrief_replication.png', dpi=200)
print('figure written')
