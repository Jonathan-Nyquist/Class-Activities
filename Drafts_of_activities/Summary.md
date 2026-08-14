Here's a handoff summary. Everything below has been verified by running the code, not recalled.

---

# Elements of Data Science — Class Activity Development (Handoff)

## Context

**Course:** SCTC 1913, Honors Elements of Data Science for the Physical and Life Sciences. Class meets 9:30–10:45 (75 min). Labs are homework for Honors students, not in-class time.

**Repo:** `~/Documents/Python/Class-Activities`, one folder per class, reachable via Desktop Commander. Typst at `/opt/homebrew/bin/typst`.

**House format** (matches Class13/14/15):
- `ClassNN_Title.typ` / `.pdf` — student handout, ~4 pages, "Team Members" header, `question` / `blank` / `answer-space` helpers. **No `minutes:` on `part-heading()` calls** — that argument exists in `preamble.typ` but timing belongs in the instructor notes only (see Open Items — this has leaked onto the student handout twice now).
- `ClassNN_Title_Instructor.typ` / `.pdf` — instructor notes with `note` / `warn` blocks, timing table, answer key
- `ClassNN_Title_Skeleton.ipynb` — students run it, **answer on paper**, questions cross-referenced as `> **Handout Q2.3**`
- `data/` subfolder

**Environment (updated Aug 13, confirmed again during Class 20):**
- **Desktop Commander + the local `ds313` conda env is the default for all Python verification and file-building — not the sandbox.** `ds313` (`~/mamba/envs/ds313`, i.e. `/Users/nyq/mamba/envs/ds313/bin/python3`) has `datascience` 0.18.1, `ipywidgets`, `seaborn`, `jupyterquiz`, `nbformat`, `nbclient` installed and confirmed working. The old note claiming no local env had `datascience` was simply wrong / has since been fixed.
- `gofer-ok` (`from gofer.ok import check`) is **not installed and not needed** — it isn't on PyPI under that name, and per Jon the autograder checks are lab-only; none of these in-class activities use `check()`.
- A duplicate `ds313` env (an orphaned copy under Homebrew's micromamba Cellar path) was found and removed in August. If a same-named duplicate ever reappears, compare `micromamba env list` and `conda env list` side by side.
- Liberation Serif is still not installed on this Mac — Typst warns and falls back silently. Affects every handout in the series. Unresolved; left unchanged so classes match each other.
- `preamble.typ` in each class folder is still **Claude's reconstruction**, not Jon's real house-style file — recurring open item since Class 16, see Open Items.

---

## Class 16 — "Compared to What?" ✅ Complete

Normal distributions, CLT, standardization. 50 minutes. Files in `Class16/`, data = `Pennypack_anions_2022-03-22.csv` (39 sites) + `WWTP_N.csv` (330 hourly nitrate readings).

**Arc:** the 2-SD outlier rule fails on chloride → fix with the right reference group → CLT on logger data → SD vs SE → instructor demo rescuing p = 0.

| Key numbers | |
|---|---|
| Cl all 39 sites | mean 184.26, SD 48.80 |
| 2-SD rule flags | PP1-1 (z = −2.69), PP1-2 (−2.14) — the two *cleanest* sites |
| 2-SD rule misses | PP1-9, Cl 280.6, z = +1.97 — the actual spike |
| Within-group fix | upstream n=9, mean 129.9, SD 62.5 → PP1-9 at **z = +2.41** |
| | downstream n=30, mean 200.6, SD 27.8 → PP1-11, PP1-13, PP4-4 |
| Logger population | 330 readings, mean 3.819, SD 1.997, non-normal (flat-topped) |
| σ/√n verified | n = 1, 6, 24, 100 |
| Downstream Cl | n=30, mean 200.6, SD 28.3 (ddof=1), **SE 5.2**, 95% CI 190–211 |
| Closing demo | nitrate diff 3.131; 20,000 shuffles → **0 hits**; null SD 0.64; z = 4.87; **p ≈ 5.7×10⁻⁷** |

Note the SD 27.8 vs 28.3 discrepancy is intentional — `group_z` uses `np.std` (ddof=0, matching the mini-project's `five_num_table`), Part 3 switches to ddof=1 for the SE. Documented in the instructor notes.

---

## Class 17 — "Cars 2 Has an Alibi" ✅ Complete

Univariate EDA, box plots, correlation. First bivariate class. 50 minutes. Files in `Class17/`, data = Pixar `public_response.csv` (tidytuesday). Skeleton is 42 cells, **2 blanks** (`standard_units`, `correlation`).

**Arc:** box plot flags Cars 2 → scatter makes it look worse → removing it *raises* r → decomposition explains why.

| | mean | median | gap | IQR |
|---|---|---|---|---|
| rotten_tomatoes | 88.52 | 96 | **−7.48** | 17.0 |
| metacritic | 79.38 | 81 | −1.62 | 21.0 |
| critics_choice | 87.14 | 89 | −1.86 | 12.0 |

n = 21 after dropna. One flier in the whole box plot: Cars 2 on RT. The RT mean/median gap is a *scale* artifact — RT reports % of critics positive, so it saturates (14 of 21 at ≥90).

**Correlations:** RT–meta 0.802, RT–CC 0.852, meta–CC 0.865.

**Part 3 decomposition** (the core of the activity):

| | r |
|---|---|
| observed | 0.802 |
| if Cars 2 had scored 46 instead of 57 | **0.867** |
| Cars 2 removed | 0.826 |

Off-line costs +0.065; range restriction gives back −0.041 (RT range 60 → 31, SD 14.26 → 9.49); net +0.024. Leave-one-out: **Onward +0.0473**, Cars 2 +0.0239, WALL-E +0.0091.

**Important correction made mid-development:** the activity was originally titled "Cars 2 Is Innocent" with instructor notes claiming Cars 2 "sits roughly on the trend." That was false. Cars 2 has leverage 0.599 (mean 0.095) and **Cook's D 3.687** against Onward's 0.147 — 25× more influential by standard diagnostics. It just happens to be the point whose two effects on *r specifically* nearly cancel. Retitled, and the notes now instruct: if a student argues Cars 2 matters more, **agree with them**.

Also in notes: `Table.read_table` reads `cinema_score` as a string column, so Soul's missing value becomes the literal string `'nan'` and survives `dropna()` → 21 rows. `pandas.read_csv` on the same file gives 20. Right answer, fragile mechanism.

Quartiles-by-hand question uses the MathBits twelve: 24…57 → Q1 26.5, Q2 36, Q3 51, IQR 24.5.

⚠️ `correlation()` here takes **two arrays**, not a table + column labels — diverges from the *Inferential Thinking* signature. Part 3 needs it that way.

---

## Class 18 — "Better Than Guessing" ✅ Complete

Linear regression and R². 40 minutes. Files in `Class18/`, data = `cricket_thermometer.csv` (15 rows). Skeleton is 34 cells, four `...` blanks across three lines (all Part 2).

**Timing:** Part 1 two baselines, paper only (6) → Part 2 cricket walkthrough (20) → Part 3 extrapolation + negative R² (8) → Part 4 the twist + residual plots (6).

**Structural change from the source notebook:** order inverted. Students do the six-step calculation once on the crickets; the y = x² example arrives afterward as a twist. Fits 40 minutes (one walkthrough, not two) and makes the punchline land — the fake data gets the *higher* R².

| Cricket | |
|---|---|
| mean temp | 80.04 °F |
| SS_Total | 629.84 |
| slope / intercept | 3.2911 / 25.2323 |
| SS_Residual | 190.55 |
| **R² = r²** | **0.6975** (r = 0.8351) |
| predictions | 19 → 87.8 °F, 40 → **156.9 °F**, 0 → 25.2 °F |

**Second data set** (x = 0…6, y = x²): line y = 6x − 5, SS_Total 1092, SS_Residual 84, **R² = 0.9231** — higher than the crickets, and plainly the wrong model. Residuals: **+5, 0, −3, −4, −3, 0, +5**, a textbook U. Cricket residuals scatter −6.52 to +5.00 with no shape.

**Negative R² caveat (documented):** forcing b = 0 while keeping the fitted slope gives R² = −14.465. But that's *not* what through-origin regression does — refitting gives slope 4.792 and **R² = +0.551**, positive. The notes tell you not to overclaim.

**Q2.4 links back to Class 17:** square last week's r = 0.802 → **0.643**. Recalibrates "strong correlation."

---

## Class 19 — "The Confidence Game" ✅ Complete

Bootstrap confidence intervals — for a mean, and for a regression slope. 48 minutes (15+20+3+10, 2 min buffer). Files in `Class19/`, data = `weight-height.csv` (Part 1, real Kaggle Gender/Height/Weight set, 10,000 rows, height in inches — corrected from a mislabeled "cm" in the source warm-up notebook) and `cricket_thermometer.csv` (Part 2, same 15-row Pierce dataset as Class 18 — reproduces Class 18's numbers exactly).

**Arc:** replicate-vs-resample on a die roll (why bootstrap works at all) → worked height-mean example, predict-first before scaling n=10 to n=500 → callback to Class 18's cricket slope, predict-first before bootstrapping it → spaghetti plot (40 resampled regression lines) → adapt to the intercept (turns into an unplanned extrapolation-uncertainty lesson) → paper discussion on when the method breaks.

| Key numbers | |
|---|---|
| Population mean height (pooled) | 66.37 in (Male mean 69.03/SD 2.86, Female mean 63.71/SD 2.70 — mildly bimodal, doesn't break the bootstrap) |
| n=10 bootstrap CI (one draw) | 63.93–67.69, width 3.77 |
| n=500 bootstrap CI (one draw) | 65.99–66.65, width 0.66 |
| Width ratio | ~5.7× narrower for 50× more data (theory: √50 ≈ 7.07) |
| Cricket slope | 3.2911, 95% CI 2.27–4.54 (excludes 0) |
| Cricket intercept | 25.2323, 95% CI 3.7–43.5 — an order of magnitude wider proportionally, since it's extrapolating to 0 chirps/sec |

Slope CI excluding 0 connects directly to hypothesis testing (CI excludes 0 ≡ reject the null at 5%). The spaghetti plot is the one cell in this class using `fig, ax = plt.subplots()` instead of the `plt.` namespace — justified by needing many overlaid lines cleanly; still an exception, not a new default.

**Resolved old open item:** `Cricket_Thermometer.ipynb` (bootstrap CI for slope, seaborn regplot) is now folded into Part 2 via the spaghetti plot — no separate notebook needed.

**Bug caught and fixed mid-build:** `part-heading()` calls in the student handout were passing `minutes:` and printing "(≈ N MIN)" on student-facing pages. Timing belongs in the instructor notes' table only. Fixed by dropping `minutes:` from all four calls. **This recurred in Class 20 below.**

---

## Class 20 — "The Registrar's Report" ✅ Complete

Survivorship bias, paired with a WWII-bomber (Wald) lecture. Quiz day — 30 minutes, deliberately short. Files in `Class20/`, data = `registrar_report.csv` (63 rows, graduates only) and `full_cohort.csv` (100 rows, entire entering cohort), both generated fresh (seed 42): 60% graduate / 20% drop out / 20% still enrolled at a 6-year tracking window.

**Arc:** naive graduates-only average looks reassuring → commit to a prediction → reveal the 37 students the average silently dropped → hand-built Kaplan-Meier curve shows the honest picture, including censoring → close by mapping both cases onto the same table.

| Key numbers | |
|---|---|
| Naive graduates-only stat | mean 4.31 yr, median 4.00 yr (n=63) |
| Full cohort breakdown | 63 graduate / 19 drop out / 18 still enrolled |
| Honest completion rate | 63.0% |
| KM 50%-graduated point | year 4.5 — later than the naive 4.31 (naive stat biased low/optimistic) |
| KM plateau at year 6 | 22.8% of entering cohort still hasn't graduated (unresolved/censored) |

**Handout is 3 pages.** Part 4 (bomber/registrar analogy table + closing question) got its own page after the first draft left students almost no room to write — table cells now give 2 lines each, Q3.1/Q3.2/Q4.2 expanded from 2 to 4 lines.

**Notebook code deliberately kept simple**, at Jon's explicit request, since this is written for newbie Python programmers: `kaplan_meier()` uses `np.unique` instead of `sorted(set(...))`, builds arrays with `make_array`/`np.append` (same pattern as Class 19's bootstrap loops) instead of Python lists, returns a `Table` instead of a tuple to unpack, and every loop uses `np.arange` indexing instead of `zip`. More lines, no idiom students haven't already seen in a lab.

**Censoring is shown, not just computed.** The KM plot has tick marks (`|`) at every dropout/still-enrolled student's year, at the survival level in effect when they left — mirrors the `show_censors` convention from Jon's original `lifelines` prototype, hand-built here instead. All 18 still-enrolled students stack at the same point (year 6, 22.8%) since they share a censoring time — that's real, not a rendering glitch. A cell prints the 19/18 split; both handout and notebook name "censoring" explicitly.

**Same `part-heading()` bug as Class 19, caught again.** Fixed the same way. Two occurrences now — see Open Items for the real fix.

---

## Open items

1. **Font fallback** — Liberation Serif not installed, affects every handout in the series. Unresolved.
2. **`preamble.typ` is still Claude's reconstruction**, not Jon's real house-style file — open since Class 16. Paste the real one over it before compiling for real.
3. **`part-heading(..., minutes: N)` keeps leaking onto student handouts** — happened in both Class 19 and Class 20, caught and fixed both times after the fact. The `minutes:` parameter should probably just be removed from `part-heading()` in `preamble.typ` entirely, so it's structurally impossible to pass it on a handout again.
4. **Cars 2 leverage callback owed.** Class 17's notes promised the catching diagnostic arrives Class 18. Residual plots only half-deliver (Onward has the bigger residual, −18.0 vs +10.8; Cars 2 has the leverage). Closing it needs a fifth part teaching leverage as "distance from the center of x" — didn't fit 40 minutes.
5. **`PennypackCreek-new.ipynb` still has two bugs.** `pp.column()` returns the table's underlying array, so `np.random.shuffle` scrambles the nitrate column in place — needs `.copy()`. Also defines the test statistic as downstream − upstream but simulates the reverse; harmless (null is symmetric) but confusing. Never patched.
6. **Class 18 deck title slide reads "Class 17, 23 October 2025"** — copy-paste from the previous deck.
7. **Class 17 deck's "Outlier?" slide** could gain the two r values (0.802 / 0.826) so the lecture matches the activity.