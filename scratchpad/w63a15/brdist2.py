#!/usr/bin/env python3
"""brdist2.py CPP -- w63a15 fix of tools/brdist.py.

DEFECT FOUND in tools/brdist.py: ours_branches() parses the target address with
    re.search(r'\\b([0-9a-f]{4,8})\\b\\s*<', t)
objdump prints the target WITHOUT zero padding, so any object whose function
sits below 0x1000 (i.e. a target address of 1-3 hex digits, which is EVERY
small/medium TU) yields no match -> the branch is recorded as None -> the
compare loop skips it (`a is not None and b is not None`).  The census then
reports "0 divergence" VACUOUSLY for exactly the branches it exists to find.
Proof: Cars_ResetCollidedCars word 15 is `bnez v0,d20` (3 hex digits) with
offset 0x100 vs retail 0x4b -- brdist.py reports cars.cpp clean.

Only the regex is changed ({4,8} -> +).  Everything else is brdist.py verbatim.
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(r'C:\Temp\nfs4-decomp')
sys.path.insert(0, str(ROOT / 'tools'))
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
BR = re.compile(r'^\s*(b\w*|j)\b')

src = (ROOT / 'tools' / 'verify_asm.py').read_text()
head = src.split('allpass=True')[0]
g = {'__name__': '__vsrc__', '__file__': str(ROOT / 'tools' / 'verify_asm.py')}
cpp = sys.argv[1]
sys.argv = ['verify_asm.py', cpp, '__none__']
exec(compile(head, 'verify_asm_head', 'exec'), g)
obj = g['obj']
dis = subprocess.run([OBJD, '-d', '-r', '-z', str(obj)], capture_output=True, text=True).stdout


def ours_branches(fn):
    lab = g['_resolve'](fn)
    body, on = [], False
    for ln in dis.splitlines():
        m = re.match(r'^([0-9a-f]{8}) <(.+)>:', ln)
        if m:
            on = (m.group(2) == lab)
            continue
        if not on:
            continue
        m = re.match(r'^\s*([0-9a-f]+):\t[0-9a-f ]+\t(.*)$', ln)
        if m:
            body.append((int(m.group(1), 16), m.group(2).split(';')[0].strip()))
        elif ln.strip() == '':
            on = False
    out = []
    for i, (a, t) in enumerate(body):
        if BR.match(t):
            m = re.search(r'\b([0-9a-f]+)\b\s*<', t) or re.search(r',([0-9a-f]+)$', t)
            if m:
                out.append((i, (int(m.group(1), 16) - a) // 4))
            else:
                out.append((i, None))
    return out


def oracle_branches(fn):
    p = ROOT / 'asm' / 'nonmatchings' / 'main' / (fn + '.s')
    if not p.exists():
        p = ROOT / 'asm' / 'nonmatchings' / 'front' / (fn + '.s')
    if not p.exists():
        return None
    idx, labels, brs = 0, {}, []
    for ln in p.read_text().splitlines():
        s = re.sub(r'/\*.*?\*/', '', ln).strip()
        if s.startswith('endlabel'):
            break
        if s.endswith(':') and s.startswith('.L'):
            labels[s[:-1]] = idx
            continue
        if not s or s.startswith(('.', 'glabel', 'nonmatching', 'dlabel', 'jlabel', 'alabel')) or s.endswith(':'):
            continue
        if BR.match(s):
            m = re.search(r'(\.L\w+)\s*$', s)
            brs.append((idx, m.group(1) if m else None))
        idx += 1
    return [(i, (labels[t] - i) if (t and t in labels) else None) for i, t in brs]


fns = sorted({m.group(2) for m in (re.match(r'^([0-9a-f]{8}) <(.+)>:', l) for l in dis.splitlines()) if m})
bad = 0
for fn in fns:
    e = oracle_branches(fn)
    if e is None:
        continue
    o = ours_branches(fn)
    if len(o) != len(e):
        print('%-60s BRANCH COUNT %d vs %d' % (fn, len(o), len(e)))
        bad += 1
        continue
    d = [(k, a, b) for k, ((_, a), (_, b)) in enumerate(zip(o, e)) if a is not None and b is not None and a != b]
    if d:
        print('%-60s %d offset diffs (idx,ours,oracle)=%s' % (fn, len(d), d[:8]))
        bad += 1
print('# %d fns checked, %d with branch-offset/count divergence' % (len(fns), bad))
