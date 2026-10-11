import subprocess
D = '/Users/nyq/Documents/Github/Class-Activities/Drafts_of_activities/LeverageGame/'
html = open(D + 'pull_the_line.html').read()
P = "document.getElementById('probe3').click();"
js = ("r1.ya=72; r1.yb=95; drawUser(); document.getElementById('lock1').click(); pick2(0); document.getElementById('lock2').click();"
      "showTab('r3'); for (let k=0;k<3;k++){ pick3(14);" + P + "pick3(TRIALS[k].planted);" + P +
      "document.getElementById('lock3').click(); if(k<2) document.getElementById('next3').click(); }"
      "console.log('END', document.getElementById('stat3').textContent, '| next visible:', document.getElementById('next3').style.display,"
      "'| tabs:', document.querySelectorAll('nav button').length, '| R2:', document.getElementById('rev2').textContent.replace(/\s+/g,' ').trim().slice(0,90));")
t = html.replace('</body>', '<script>window.onerror=(m)=>console.log("ERR "+m);window.addEventListener("load",()=>{' + js + '});</script></body>')
open('/tmp/t5.html', 'w').write(t)
chrome = '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'
r = subprocess.run([chrome, '--headless=new', '--disable-gpu', '--virtual-time-budget=9000', '--enable-logging=stderr',
                    '--v=0', '--dump-dom', 'file:///tmp/t5.html'], capture_output=True, text=True)
for line in r.stderr.splitlines():
    if 'CONSOLE' in line:
        print(line[line.find('"'):][:300])
