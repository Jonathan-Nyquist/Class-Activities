import nbformat
from nbclient import NotebookClient
D = '/Users/nyq/Documents/Github/Class-Activities/Drafts_of_activities/LeverageGame/'
for name, path in [('SOLUTION', '/tmp/PullTheLine_Solution.ipynb'), ('SKELETON', D + 'PullTheLine_Skeleton.ipynb')]:
    nb = nbformat.read(path, as_version=4)
    client = NotebookClient(nb, timeout=120, kernel_name='python3', resources={'metadata': {'path': D}},
                            allow_errors=(name == 'SKELETON'))
    client.execute()
    print('=' * 20, name, 'executed')
    for i, c in enumerate(nb.cells):
        if c.cell_type != 'code':
            continue
        for o in c.get('outputs', []):
            if o.output_type == 'error':
                print(f'[cell {i}] ERROR {o.ename}: {o.evalue}')
            elif name == 'SOLUTION':
                txt = o.get('text') or o.get('data', {}).get('text/plain', '')
                if txt:
                    print(f'[cell {i}]', txt[:1500])
