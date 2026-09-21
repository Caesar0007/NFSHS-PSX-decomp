"""g_codediff_fn.py REL -- which FUNCTIONS of build/gdebug/<REL>.s (-g) differ in instructions from build/<REL>.s, with the diff."""
import difflib
import re
import sys
from pathlib import Path

R = Path(__file__).resolve().parents[2].as_posix() + '/build/'


def fns(p):
    out, cur = {}, None
    for l in open(p, errors='replace'):
        m = re.match(r'^\t\.ent\t(\S+)', l)
        if m:
            cur = out.setdefault(m.group(1), [])
            continue
        if re.match(r'^\t\.end\t', l):
            cur = None
            continue
        if cur is not None:
            l = l.split('#')[0].rstrip()
            if re.match(r'^\t[a-z]', l) and not l.startswith('\t.'):
                cur.append(re.sub(r'\$L\w+', '$L', re.sub(r'\s+', ' ', l.strip())))
    return out


rel = sys.argv[1]
a, b = fns(R + 'gdebug/' + rel + '.s'), fns(R + rel + '.s')
print('functions: -g %d, plain %d; only -g: %s; only plain: %s' % (len(a), len(b), sorted(set(a) - set(b))[:6], sorted(set(b) - set(a))[:6]))
for n in sorted(set(a) & set(b)):
    if a[n] != b[n]:
        print('==', n, len(a[n]), 'vs', len(b[n]))
        for l in list(difflib.unified_diff(a[n], b[n], '-g', 'plain', lineterm='', n=2))[:40]:
            print('   ', l)
