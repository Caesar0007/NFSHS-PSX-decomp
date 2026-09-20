"""symfix_rename.py [--apply] [--fn a,b] -- RENAME fixer.  When a function has exactly one EXTRA local and one MISSING retail
local with the SAME home (same register / same stack slot), our local is the retail one under another name: rename it
inside that function (word-boundary replace between the function's first line and its closing brace).  `this` is never a
rename target.  The byte gate (symloop.py) and the board decide whether it was right."""
import importlib.util
import json
import re
import sys
from collections import defaultdict
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
spec = importlib.util.spec_from_file_location('stp', str(ROOT / 'scratchpad/psyq_pipe/symtree_parse.py'))
stp = importlib.util.module_from_spec(spec)
spec.loader.exec_module(stp)
apply = '--apply' in sys.argv
only = set(sys.argv[sys.argv.index('--fn') + 1].split(',')) if '--fn' in sys.argv else None
rep = json.load(open(ROOT / 'build/psyq_g/symtree_report.json'))
ours = stp.parse(str(ROOT / 'build/psyq_g/nfs4_sym.txt'))
files = {p.relative_to(ROOT).as_posix().upper(): p for p in (ROOT / 'recon').rglob('*') if p.is_file()}


def src_of(fn):
    f = ours[fn]['hdr'].get('file', '').replace(chr(92), '/')
    while '//' in f:
        f = f.replace('//', '/')
    i = f.upper().find('/RECON/')
    return files.get(f[i + 1:].upper()) if i >= 0 else None


def body_end(lines, start):
    depth, opened, in_c = 0, False, False
    for i in range(start, len(lines)):
        l = lines[i]
        j = 0
        while j < len(l):
            if in_c:
                k = l.find('*/', j)
                if k < 0:
                    break
                j, in_c = k + 2, False
            elif l.startswith('/*', j):
                in_c = True; j += 2
            elif l.startswith('//', j):
                break
            else:
                if l[j] == '{':
                    depth += 1; opened = True
                elif l[j] == '}':
                    depth -= 1
                j += 1
        if opened and depth == 0:
            return i
    return None


plan = defaultdict(list)
for fn, v in rep.items():
    if only is not None and fn not in only:
        continue
    ex, ms = defaultdict(list), defaultdict(list)
    for i in v['issues']:
        p = i.split()
        if p[0] == 'EXTRA':
            ex[p[2]].append(p[1])
        elif p[0] == 'MISSING':
            ms[p[2]].append(p[1])
    for h in ex:
        if h in ms and len(ex[h]) == 1 and len(ms[h]) == 1 and ms[h][0] != 'this' and ex[h][0] != 'this':
            plan[fn].append((ex[h][0], ms[h][0], h))
byfile = defaultdict(list)
for fn in plan:
    s = src_of(fn)
    if s:
        byfile[s].append(fn)
for src, fns in sorted(byfile.items()):
    lines = src.read_text(encoding='utf-8', errors='surrogateescape').splitlines(keepends=True)
    for fn in fns:
        a = int(ours[fn]['hdr']['line']) - 1
        b = body_end(lines, a)
        if b is None:
            continue
        for old, new, home in plan[fn]:
            if any(re.search(r'\b%s\b' % re.escape(new), l) for l in lines[a:b + 1]):
                print('   skip %s: `%s` already appears in the function' % (fn, new)); continue
            for k in range(a, b + 1):
                lines[k] = re.sub(r'\b%s\b' % re.escape(old), new, lines[k])
    print('%s [%s] %s' % (src.name.upper(), src.relative_to(ROOT).as_posix(), ' '.join('%s:%d' % (f, len(plan[f])) for f in fns)))
    if apply:
        src.write_text(''.join(lines), encoding='utf-8', errors='surrogateescape', newline='')
print('functions:', sum(len(v) for v in byfile.values()), '(applied)' if apply else '(dry run)')
