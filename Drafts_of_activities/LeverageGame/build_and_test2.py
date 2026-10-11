import subprocess, re
D = '/Users/nyq/Documents/Github/Class-Activities/Drafts_of_activities/LeverageGame/'
html = open(D + 'pull_the_line.html').read()
P = "document.getElementById('probe3').click();"
tests = {
  't3': "showTab('r3'); pick3(TRIALS[0].x.indexOf(18.3));" + P + "pick3(14);" + P + "document.getElementById('lock3').click();",
  't3b': "showTab('r3'); r3.k=1; renderTrial(); pick3(14);" + P + "pick3(TRIALS[1].planted);" + P,
  't3c': "showTab('r3'); r3.k=1; renderTrial(); pick3(14);" + P + "pick3(TRIALS[1].planted);" + P + "document.getElementById('lock3').click();",
  't4': "r1.ya=72; r1.yb=95; drawUser(); document.getElementById('lock1').click(); pick2(8); document.getElementById('lock2').click();"
        "for (let k=0;k<3;k++){ pick3(14);" + P + "pick3(TRIALS[k].planted); document.getElementById('lock3').click(); if(k<2){r3.k++; renderTrial();} }"
        "showTab('results'); console.log('CODE', document.getElementById('code').textContent);",
}
chrome = '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'
for name, js in tests.items():
    t = html.replace('</body>', '<script>window.onerror=(m)=>console.log("ERR "+m);'
                     'window.addEventListener("load",()=>{' + js + '});</script></body>')
    open('/tmp/' + name + '.html', 'w').write(t)
    subprocess.run([chrome, '--headless=new', '--disable-gpu', '--hide-scrollbars', '--window-size=1100,1000',
                    '--virtual-time-budget=9000', '--screenshot=' + D + 'shot_' + name + '.png',
                    'file:///tmp/' + name + '.html'], capture_output=True)
    r = subprocess.run([chrome, '--headless=new', '--disable-gpu', '--virtual-time-budget=9000',
                        '--enable-logging=stderr', '--v=0', '--dump-dom', 'file:///tmp/' + name + '.html'],
                       capture_output=True, text=True)
    for line in r.stderr.splitlines():
        if 'CONSOLE' in line:
            print(name, line[line.find('"'):][:220])
    i = r.stdout.find('id="probes3"')
    print(name, 'probe table:', re.sub(r'<[^>]+>', ' ', r.stdout[i:i+700]).split()[:40] if i > 0 else None)
