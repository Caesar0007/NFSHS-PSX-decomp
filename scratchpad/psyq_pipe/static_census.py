"""static_census.py -- for every symbol retail has LOCAL (SYM kind 6) but our PSYLINK SYM has global: where it is defined
and which other recon files mention it (a mention in another compiled file means it cannot simply become `static`)."""
import glob
import re
import subprocess

R = 'C:/Temp/nfs4-decomp/'
names = [l.split()[5] for l in open(R + 'build/tmp/linkage.txt') if 'retail 6 ours 2' in l]
files = [p.replace(chr(92), '/') for p in glob.glob(R + 'recon/**/*', recursive=True) if p.endswith(('.c', '.cpp', '.h', '.inc'))]
text = {p: open(p, encoding='utf-8', errors='replace').read() for p in files}
for n in names:
    pat = re.compile(r'\b' + re.escape(n) + r'\b')
    hits = [p for p in files if pat.search(text[p])]
    defs = [p for p in hits if re.search(r'^(?!\s)(?!.*;\s*$)[\w \*]*\b' + re.escape(n) + r'\s*\([^;]*$', text[p], re.M) and p.endswith(('.c', '.cpp'))]
    print('%-32s def %-44s others %s' % (n, ','.join(d.replace(R + 'recon/', '') for d in defs) or '?',
                                         ' '.join(h.replace(R + 'recon/', '').split('/')[-1] for h in hits if h not in defs)[:90]))
