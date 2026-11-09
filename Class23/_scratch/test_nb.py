"""Execute the skeleton with student fills at a given sites value; report cell times and key outputs."""
import sys, json, time, copy
import nbformat
from nbclient import NotebookClient

sites = int(sys.argv[1])
NB = '/Users/nyq/Documents/Github/Class-Activities/Class23/Class23_WouldItReplicate_Skeleton.ipynb'
nb = nbformat.read(NB, as_version=4)
for c in nb.cells:
    if c.cell_type != 'code':
        continue
    s = c.source
    s = s.replace('np.arange(10):', 'np.arange(1000):')
    s = s.replace('are.between(..., ...)', 'are.between(0.01, 0.05)')
    s = s.replace('sites = 12 ', 'sites = %d ' % sites)
    s = s.replace('%matplotlib inline', '')
    c.source = s
client = NotebookClient(nb, timeout=600, kernel_name='python3')
with client.setup_kernel():
    for i, c in enumerate(nb.cells):
        if c.cell_type != 'code':
            continue
        t0 = time.time()
        client.execute_cell(c, i)
        dt = time.time() - t0
        texts = []
        for o in c.outputs:
            if o.output_type == 'stream':
                texts.append(o.text.strip())
            elif o.output_type == 'execute_result' and 'text/plain' in o.data:
                texts.append(o.data['text/plain'][:200])
            elif o.output_type == 'error':
                texts.append('ERROR ' + o.ename + ': ' + o.evalue)
        print('--- cell %d (%.1f s)' % (i, dt))
        if texts and i not in (32,):
            print('\n'.join(texts)[:600])
