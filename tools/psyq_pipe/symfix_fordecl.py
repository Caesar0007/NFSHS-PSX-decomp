"""symfix_fordecl.py [--apply] [--fn a,b] -- FOR-DECLARATION fixer.  cc1plus gives `for (int v = ...; ...)` its own debug scope
holding `v`.  When retail has a local ALONE in a scope one level deeper than where our source declares it, and our source
drives a loop with it, rewrite the loop as a for-declaration and drop the separate declaration:

    T v;  ...  for (v = INIT; COND; STEP)                    ->  for (T v = INIT; COND; STEP)
    T v;  ...  v = INIT; do { BODY  v = v + 1; } while (COND); ->  for (T v = INIT; COND; v++) { BODY }

Only single-declarator `T v;` declarations (no initialiser) are handled.  A use of v outside the loop makes the file fail to
compile -- the driver treats that like moved bytes and reverts.  C++ files only."""
import importlib.util
import json
import re
import sys
from collections import Counter, defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
spec = importlib.util.spec_from_file_location('stp', str(ROOT / 'tools/psyq_pipe/symtree_parse.py'))
stp = importlib.util.module_from_spec(spec)
spec.loader.exec_module(stp)
apply = '--apply' in sys.argv
only = set(sys.argv[sys.argv.index('--fn') + 1].split(',')) if '--fn' in sys.argv else None
ours, retail = stp.parse(str(ROOT / 'build/psyq_g/nfs4_sym.txt')), stp.parse(stp.RETAIL)
files = {p.relative_to(ROOT).as_posix().upper(): p for p in (ROOT / 'recon').rglob('*.cpp')}


def src_of(fn):
    f = ours[fn]['hdr'].get('file', '').replace(chr(92), '/')
    while '//' in f:
        f = f.replace('//', '/')
    i = f.upper().find('/RECON/')
    return files.get(f[i + 1:].upper()) if i >= 0 else None


def body_end(lines, start):
    depth, opened, in_c = 0, False, False
    for i in range(start, len(lines)):
        l, j = lines[i], 0
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
                depth += l[j] == '{'; opened |= l[j] == '{'; depth -= l[j] == '}'
                j += 1
        if opened and depth == 0:
            return i
    return None


def candidates(fn):
    o, r = ours[fn], retail[fn]
    rn = Counter(n for n, *_ in r['locals']); on = Counter(n for n, *_ in o['locals'])
    out = []
    for n, h, ty, d in r['locals']:
        if rn[n] != 1 or on[n] != 1 or h.startswith(('REGPARM', 'ARG')):
            continue
        od = next(dd for nn, hh, tt, dd in o['locals'] if nn == n)
        alone = sum(1 for nn, hh, tt, dd in r['locals'] if dd == d) >= 1
        if d == od + 1 and alone:
            out.append(n)
    return out


plan = defaultdict(list)
for fn in sorted(set(ours) & set(retail)):
    if only is not None and fn not in only:
        continue
    c = candidates(fn)
    if c:
        plan[fn] = c
byfile = defaultdict(list)
for fn in plan:
    s = src_of(fn)
    if s:
        byfile[s].append(fn)
total = 0
for src, fns in sorted(byfile.items()):
    lines = src.read_text(encoding='utf-8', errors='surrogateescape').splitlines(keepends=True)
    done = []
    for fn in sorted(fns, key=lambda f: -int(ours[f]['hdr']['line'])):
        a = int(ours[fn]['hdr']['line']) - 1
        b = body_end(lines, a)
        n_ok = 0
        if b is None:
            done.append((fn, 0)); continue
        for v in plan[fn]:
            seg = lines[a:b + 1]
            text = ''.join(seg)
            decl = re.search(r'^([ \t]*)((?:unsigned |signed |register )*[A-Za-z_]\w*(?:\s*\*+)?)\s+%s;[ \t]*(?:/\*[^\n]*\*/[ \t]*)?\r?\n' % re.escape(v), text, re.M)
            if not decl:
                continue
            ty = decl.group(2).strip()
            new = None
            m = re.search(r'for \(\s*%s = ' % re.escape(v), text)
            if m and len(re.findall(r'for \(\s*%s = ' % re.escape(v), text)) == 1:
                new = text[:m.start()] + 'for (%s %s = ' % (ty, v) + text[m.end():]
            else:
                m = re.search(r'^([ \t]*)%s = ([^;\n]+);\s*\n\s*do \{\s*\n(.*?)^[ \t]*%s = %s \+ 1;\s*\n\s*\} while \(([^\n]+)\);' % (
                    re.escape(v), re.escape(v), re.escape(v)), text, re.M | re.S)
                if m and text.count('%s = %s + 1;' % (v, v)) == 1:
                    ind = m.group(1)
                    new = (text[:m.start()] + '%sfor (%s %s = %s; %s; %s++) {\n%s%s}' % (ind, ty, v, m.group(2), m.group(4), v, m.group(3), ind) + text[m.end():])
            if new is None:
                continue
            d2 = re.search(r'^([ \t]*)((?:unsigned |signed |register )*[A-Za-z_]\w*(?:\s*\*+)?)\s+%s;[ \t]*(?:/\*[^\n]*\*/[ \t]*)?\r?\n' % re.escape(v), new, re.M)
            new = new[:d2.start()] + new[d2.end():]
            lines[a:b + 1] = new.splitlines(keepends=True)
            b = a + len(new.splitlines(keepends=True)) - 1
            n_ok += 1
        done.append((fn, n_ok))
        total += n_ok > 0
    if any(c for _, c in done):
        print('%s [%s] %s' % (src.name.upper(), src.relative_to(ROOT).as_posix(), ' '.join('%s:%d' % (f, c) for f, c in done)))
        if apply:
            src.write_text(''.join(lines), encoding='utf-8', errors='surrogateescape', newline='')
print('functions:', total, '(applied)' if apply else '(dry run)')
