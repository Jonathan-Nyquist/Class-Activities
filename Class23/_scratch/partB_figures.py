"""Part B: huge n, tiny effect. Same creek SD (40), true difference 2 mg/L (0.05 SD), 20,000 readings per side.
Produces figures for the slides and logs every number."""
import time
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
plt.style.use('fivethirtyeight')
plt.rcParams.update({'figure.facecolor': 'white', 'axes.facecolor': 'white', 'savefig.facecolor': 'white'})

OUT = '../'
SD, N, TRUE = 40, 20000, 2
rng = np.random.default_rng(1905)  # chosen from seeds 1900-1959 so observed is typical (|obs-2| < 0.15); design gives p<0.05 in 99.9%, p<0.001 in 97% of surveys

up = rng.normal(150, SD, N)
dn = rng.normal(150 + TRUE, SD, N)
obs = dn.mean() - up.mean()
print('observed difference %.2f mg/L; in SD units %.3f' % (obs, obs / SD))

# null: 10,000 surveys of a no-difference creek at n = 20,000 (chunked)
t0 = time.time()
null = np.concatenate([rng.normal(150, SD, (500, N)).mean(1) - rng.normal(150, SD, (500, N)).mean(1)
                       for _ in range(20)])
print('null built in %.0f s; null SD %.3f; max |null| %.2f' % (time.time() - t0, null.std(), np.abs(null).max()))
p = np.mean(np.abs(null) >= abs(obs))
print('p-value from 10,000 null surveys: %g' % p)
print('normal-theory z = %.2f' % (obs / (SD * np.sqrt(2 / N))))

# bootstrap CI, 1000 resamples
boot = np.array([rng.choice(dn, N).mean() - rng.choice(up, N).mean() for _ in range(1000)])
lo, hi = np.percentile(boot, [2.5, 97.5])
print('95%% bootstrap CI: %.2f to %.2f mg/L' % (lo, hi))

# Fig B1: overlaid histograms
bins = np.arange(0, 301, 5)
plt.figure(figsize=(10, 5.5))
plt.hist(up, bins=bins, alpha=0.55, label='upstream (20,000 readings)', color='tab:blue')
plt.hist(dn, bins=bins, alpha=0.55, label='downstream (20,000 readings)', color='tab:orange')
plt.xlabel('chloride (mg/L)'); plt.ylabel('readings'); plt.legend(loc='upper right')
plt.title('Is downstream different?')
plt.tight_layout(); plt.savefig(OUT + 'fig_B1_histograms.png', dpi=200); plt.close()

# Fig B2: null distribution with observed
plt.figure(figsize=(10, 5.5))
plt.hist(null, bins=np.arange(-2.5, 2.51, 0.1), color='gray')
plt.axvline(obs, color='red', linewidth=3)
plt.text(obs, plt.ylim()[1] * 0.9, '  observed\n  %.1f mg/L' % obs, color='red', va='top')
plt.xlabel('downstream minus upstream (mg/L)'); plt.ylabel('null surveys')
plt.title('10,000 surveys of a creek with NO difference')
plt.tight_layout(); plt.savefig(OUT + 'fig_B2_null.png', dpi=200); plt.close()

# Fig B3: CI on a 0-40 axis next to the Part A creek's 33 mg/L
plt.figure(figsize=(10, 3.8))
plt.plot([lo, hi], [1, 1], color='tab:blue', linewidth=8, solid_capstyle='butt')
plt.plot(obs, 1, 'o', color='black', markersize=8)
plt.axvline(0, color='black', linestyle=':', linewidth=1.5)
plt.axvline(33, color='red', linewidth=1.5)
plt.text(33, 1.35, ' Part A creek: 33 mg/L', color='red', va='center')
plt.text(hi, 0.7, '  95%% CI %.1f to %.1f mg/L' % (lo, hi), va='center')
plt.xlim(-5, 45); plt.ylim(0.4, 1.6); plt.yticks([])
plt.xlabel('downstream minus upstream (mg/L)')
plt.title('How big is it?')
plt.tight_layout(); plt.savefig(OUT + 'fig_B3_ci.png', dpi=200); plt.close()
print('figures written')
