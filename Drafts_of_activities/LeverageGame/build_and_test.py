import json, subprocess, os
D = '/Users/nyq/Documents/Github/Class-Activities/Drafts_of_activities/LeverageGame/'
html = open(D + 'pull_the_line.html').read()
if '__TRIALS__' in html:
    html = html.replace('__TRIALS__', json.dumps(json.load(open(D + 'round3_trials.json'))))
    open(D + 'pull_the_line.html', 'w').write(html)

# test copies: append a script that plays each round, then screenshot with headless Chrome
tests = {
  't1': "r1.ya=72; r1.yb=95; drawUser(); document.getElementById('lock1').click(); document.getElementById('sdbtn').click();",
  't2': "showTab('r2'); pick2(8); document.getElementById('lock2').click();",
  't3': "showTab('r3'); pick3(13); document.getElementById('lock3').click();",
  't3b': "showTab('r3'); document.getElementById('lock3'); r3.k=1; renderTrial(); pick3(14); document.getElementById('lock3').click();",
  't4': "r1.ya=72; r1.yb=95; drawUser(); document.getElementById('lock1').click(); pick2(8); document.getElementById('lock2').click();"
        "for (let k=0;k<6;k++){ pick3(TRIALS[k].planted); document.getElementById('lock3').click(); if(k<5){r3.k++; renderTrial();} }"
        "showTab('results'); console.log('CODE', document.getElementById('code').textContent);",
}
chrome = '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'
for name, js in tests.items():
    t = html.replace('</body>', '<script>window.addEventListener("load",()=>{' + js + '});</script></body>')
    open('/tmp/' + name + '.html', 'w').write(t)
    subprocess.run([chrome, '--headless=new', '--disable-gpu', '--hide-scrollbars', '--window-size=1100,900',
                    '--virtual-time-budget=9000', '--screenshot=' + D + 'shot_' + name + '.png',
                    'file:///tmp/' + name + '.html'], capture_output=True)
    print(name, os.path.exists(D + 'shot_' + name + '.png'))
r = subprocess.run([chrome, '--headless=new', '--disable-gpu', '--virtual-time-budget=9000',
                    '--enable-logging=stderr', '--v=0', '--dump-dom', 'file:///tmp/t4.html'], capture_output=True, text=True)
for line in r.stderr.splitlines():
    if 'CODE' in line or 'Uncaught' in line or 'Error' in line:
        print(line[-300:])
i = r.stdout.find('id="code"'); print(r.stdout[i:i+200])
