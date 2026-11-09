import json

SRC = '/Users/nyq/Documents/Github/Class-Activities/Drafts_of_activities/pvalue_replication/ClassNN_PValue_Replication_Skeleton.ipynb'
DST = '/Users/nyq/Documents/Github/Class-Activities/Class23/Class23_WouldItReplicate_Skeleton.ipynb'

nb = json.load(open(SRC))
cells = nb['cells']

def src(c):
    return ''.join(c['source'])

def lines(text):
    parts = text.split('\n')
    return [p + '\n' for p in parts[:-1]] + [parts[-1]]

def md(text):
    return {'cell_type': 'markdown', 'metadata': {}, 'source': lines(text)}

def code(text):
    return {'cell_type': 'code', 'metadata': {}, 'execution_count': None, 'outputs': [], 'source': lines(text)}

def edit(i, old, new):
    s = src(cells[i])
    assert old in s, (i, old)
    cells[i]['source'] = lines(s.replace(old, new))

edit(0, 'This notebook is Parts 2–4.', 'This notebook is Parts 2, 3, 4 and 6. Parts 5 and 7 are on paper and on the screen.')
edit(9, 'One complete survey: the difference it observed and its p-value. Run this cell three\ntimes and record all three on the worksheet (question 3).',
     'One complete survey: the difference it observed and its p-value. Run this cell a few\ntimes. Nothing about the creek changes between runs.')
edit(23, '## Part 4. Twenty Surveys, Twenty Intervals', '## Part 6. Twenty Surveys, Twenty Intervals')
edit(26, 'Answer questions 8–10 on the worksheet from the plot and this table.',
     'Answer question 12 on the worksheet from the plot and this table. Then look up: Part 7 is on the screen.')

part4 = [
    md('---\n## Part 4. More Sites\n\nEverything so far used **12 sites on each side**. Your instructor will give your team a\ndifferent number: **6, 12, 24 or 48** sites per side. The creek itself does not change: the true\nexcess is still 33 mg/L and the SD is still 40 mg/L.\n\n**4.1** Put your team\'s number in the cell below and run it.'),
    code("sites = 12   # change this to your team's number of sites per side\n\ndef sample_creek_sites(true_difference):\n    upstream = np.random.normal(150, 40, sites)\n    downstream = np.random.normal(150 + true_difference, 40, sites)\n    return np.mean(downstream) - np.mean(upstream)\n\nsample_creek_sites(33)"),
    md('**4.2** A survey with a different number of sites needs its own null distribution. This is the\nsame idea as 2.2: survey a creek with **no** excess 10,000 times, with your number of sites.'),
    code("null_diffs_sites = make_array()\nfor i in np.arange(10000):\n    null_diffs_sites = np.append(null_diffs_sites, sample_creek_sites(0))\n\ncutoff_sites = percentile(95, np.abs(null_diffs_sites))\nprint('sites per side:', sites)\nprint('a survey needs a difference farther than', np.round(cutoff_sites, 1), 'mg/L from zero for p < 0.05')\n\ndef p_value_sites(observed):\n    as_extreme = np.count_nonzero(np.abs(null_diffs_sites) >= np.abs(observed))\n    return as_extreme / len(null_diffs_sites)"),
    md('**4.3** Now run many surveys two ways: in the real creek (excess **33**) and in a creek with **no**\nexcess (**0**). Run at 10 first. Then **write your prediction for question 8**, change the 10 to\n1000, and run again.'),
    code("real_p = make_array()\nnone_p = make_array()\nfor i in np.arange(10):\n    real_p = np.append(real_p, p_value_sites(sample_creek_sites(33)))\n    none_p = np.append(none_p, p_value_sites(sample_creek_sites(0)))\n\nprint('sites per side:', sites, '   surveys each way:', len(real_p))\nprint('real excess (33 mg/L): fraction with p < 0.05 =', np.count_nonzero(real_p < 0.05) / len(real_p))\nprint('no excess (0 mg/L):    fraction with p < 0.05 =', np.count_nonzero(none_p < 0.05) / len(none_p))"),
    md('Report both fractions to the board. **Part 5 is on the worksheet;** come back here for Part 6.'),
]

nb['cells'] = cells[:23] + part4 + cells[23:29]   # drops old finish-early B (cells 29-30)
for c in nb['cells']:
    if c['cell_type'] == 'code':
        c['outputs'] = []
        c['execution_count'] = None
json.dump(nb, open(DST, 'w'), indent=1, ensure_ascii=False)
for i, c in enumerate(nb['cells']):
    print(i, c['cell_type'], src(c).split('\n')[0][:70])
