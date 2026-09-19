"""fevirt_errs.py [--lines] FILE... -- compile each TU (tools/build.py --only) and summarise the compiler ERRORS by
normalised message (line numbers and warnings dropped), so a header change can be triaged across many TUs at once.
--lines: also print file:line for each error (first 12 per message)."""
import re
import subprocess
import sys
from collections import defaultdict

ROOT = 'C:/Temp/nfs4-decomp/'
show = '--lines' in sys.argv
files = [a for a in sys.argv[1:] if not a.startswith('--')]
total = defaultdict(list)
for rel in files:
    out = subprocess.run(['python', 'tools/build.py', '--no-link', '--only', rel], capture_output=True, text=True, cwd=ROOT)
    txt = (out.stdout + out.stderr).replace('\\\\', '/').replace('\\', '/')
    ok = re.search(r'^OK ', txt, re.M) is not None
    n = 0
    for m in re.finditer(r'^(?:[A-Za-z]:)?[^\n:]*?([\w.]+\.(?:cpp|h|c)):(\d+): (?!warning)([^\n]+)', txt, re.M):
        msg = m.group(3)
        if msg.startswith(('In ', 'candidates', 'at this point', '   ')):
            continue
        total[msg].append('%s:%s (%s)' % (m.group(1), m.group(2), rel.split('/')[-1]))
        n += 1
    print('%-4s %3d errors  %s' % ('OK' if ok else 'FAIL', n, rel))
print()
for msg, where in sorted(total.items(), key=lambda kv: -len(kv[1])):
    print('%4d  %s' % (len(where), msg[:170]))
    if show:
        for w in where[:12]:
            print('         ' + w)
