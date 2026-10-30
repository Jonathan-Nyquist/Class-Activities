"""Generate synthetic applicant data and figures for Class 20: Who Got In.

Run with the ds313 environment from the Class20 folder:
    python3 data/make_admissions.py
"""
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from datascience import Table

SEED = 2026
N = 400
RHO = 0.4
ADMIT_FRAC = 0.30

def standard_units(x):
    return (x - np.mean(x)) / np.std(x)

def correlation(t, x, y):
    return np.mean(standard_units(t.column(x)) * standard_units(t.column(y)))

rng = np.random.default_rng(SEED)
z1 = rng.normal(size=N)
z2 = RHO * z1 + np.sqrt(1 - RHO**2) * rng.normal(size=N)

gpa = np.clip(np.round(3.30 + 0.30 * z1, 2), 2.0, 4.0)
sat = np.clip(np.round((1150 + 150 * z2) / 10) * 10, 400, 1600)

applicants = Table().with_columns("HS_GPA", gpa, "SAT", sat)
applicants = applicants.with_column(
    "Index", standard_units(applicants.column("HS_GPA")) + standard_units(applicants.column("SAT")))

n_admit = int(ADMIT_FRAC * N)
cut_index = np.sort(applicants.column("Index"))[::-1][n_admit - 1]
admitted_A = applicants.where("Index", lambda v: v >= cut_index)

cut_gpa = np.sort(applicants.column("HS_GPA"))[::-1][n_admit - 1]
admitted_B = applicants.where("HS_GPA", lambda v: v >= cut_gpa)

r_all = correlation(applicants, "HS_GPA", "SAT")
r_A = correlation(admitted_A, "HS_GPA", "SAT")
r_B = correlation(admitted_B, "HS_GPA", "SAT")

# Cutoff line in raw units: zG + zS = c  ->  SAT = mS + sS*(c - (GPA - mG)/sG)
mG, sG = np.mean(gpa), np.std(gpa)
mS, sS = np.mean(sat), np.std(sat)
def line_sat(g):
    return mS + sS * (cut_index - (g - mG) / sG)

star_gpa = np.array([3.00, 4.00])
star_sat = line_sat(star_gpa)

print("n applicants", N, " r_all", round(r_all, 3))
print("Program A: admitted", admitted_A.num_rows, " cut index", round(cut_index, 3), " r", round(r_A, 3))
print("Program B: admitted", admitted_B.num_rows, " GPA cut", cut_gpa, " r", round(r_B, 3))
print("GPA mean/sd", round(mG, 3), round(sG, 3), " SAT mean/sd", round(mS, 1), round(sS, 1))
print("GPA clipped at 4.0:", np.sum(gpa == 4.0), " SAT clipped:", np.sum(sat == 1600) + np.sum(sat == 400))
print("Stars:", [(float(g), float(s)) for g, s in zip(star_gpa, star_sat)])

applicants.select("HS_GPA", "SAT").to_csv("data/applicants.csv")

XLIM = (2.3, 4.08)
YLIM = (650, 1650)

def base(ax):
    ax.set_xlim(*XLIM)
    ax.set_ylim(*YLIM)
    ax.set_xlabel("High school GPA")
    ax.set_ylabel("SAT score")
    ax.grid(alpha=0.3)

# Handout figure: all applicants + two stars on the cutoff
fig, ax = plt.subplots(figsize=(6.2, 4.6))
ax.scatter(gpa, sat, s=12, color="0.35", alpha=0.7)
ax.scatter(star_gpa, star_sat, marker="*", s=260, color="black", zorder=5)
base(ax)
ax.set_title(f"All {N} applicants  (r = {r_all:+.2f})")
fig.tight_layout()
fig.savefig("fig_applicants.png", dpi=200)
plt.close(fig)

# Reveal A: admitted by combined index
fig, ax = plt.subplots(figsize=(6.2, 4.6))
ax.scatter(gpa, sat, s=10, color="0.85")
ax.scatter(admitted_A.column("HS_GPA"), admitted_A.column("SAT"), s=14, color="#9E1B34")
g = np.linspace(*XLIM, 50)
ax.plot(g, line_sat(g), color="black", lw=1.2)
base(ax)
ax.set_title(f"Program A admits (combined index): r = {r_A:+.2f}")
fig.tight_layout()
fig.savefig("fig_reveal_A.png", dpi=200)
plt.close(fig)

# Reveal B: admitted by GPA alone
fig, ax = plt.subplots(figsize=(6.2, 4.6))
ax.scatter(gpa, sat, s=10, color="0.85")
ax.scatter(admitted_B.column("HS_GPA"), admitted_B.column("SAT"), s=14, color="#1B5E9E")
ax.axvline(cut_gpa, color="black", lw=1.2)
base(ax)
ax.set_title(f"Program B admits (GPA only): r = {r_B:+.2f}")
fig.tight_layout()
fig.savefig("fig_reveal_B.png", dpi=200)
plt.close(fig)
