"""strip_try.py FUNCTION VARIANTS.py -- try source variants of one LINK_STRIPPED function in its real file and report the
gate's differing-word count for each.  VARIANTS.py defines FILE (repo-relative), START / END markers (text kept outside
the replaced span) and VARIANTS = [(name, body_text), ...].  The best variant is left in place."""
import re
import subprocess
import sys

R = 'C:/Temp/nfs4-decomp/'
fn = sys.argv[1]
ns = {}
exec(open(sys.argv[2], encoding='utf-8').read(), ns)
p = R + ns['FILE']
orig = open(p, encoding='utf-8').read()
a = orig.index(ns['START'])
b = orig.index(ns['END'], a)
best = None
for name, body in ns['VARIANTS']:
    open(p, 'w', encoding='utf-8', newline='').write(orig[:a] + body + orig[b:])
    r = subprocess.run([sys.executable, R + 'tools/build.py', '--only', ns['FILE']], capture_output=True, text=True, cwd=R)
    if 'OK build' not in r.stdout:
        print('%-28s COMPILE ERROR' % name)
        continue
    g = subprocess.run([sys.executable, R + 'tools/link_stripped_check.py'], capture_output=True, text=True, cwd=R).stdout
    m = re.search(r' ' + re.escape(fn) + r'\s+SDK \S+ (BYTE-EXACT|(\d+) DIFFERING)', g)
    d = 0 if m and m.group(1) == 'BYTE-EXACT' else int(m.group(2)) if m else 999
    print('%-28s %s' % (name, 'BYTE-EXACT' if d == 0 else '%d differing words' % d))
    if best is None or d < best[0]:
        best = (d, body)
    if d == 0:
        break
open(p, 'w', encoding='utf-8', newline='').write(orig[:a] + best[1] + orig[b:])
subprocess.run([sys.executable, R + 'tools/build.py', '--only', ns['FILE']], capture_output=True, text=True, cwd=R)
print('kept best:', best[0])
