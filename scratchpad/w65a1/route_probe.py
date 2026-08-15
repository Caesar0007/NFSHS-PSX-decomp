#!/usr/bin/env python3
"""route.py <recon-file> <FN> [start] [end] -- WHOLE-BLOCK ROUTING VIEW.

Prints, index by index, OUR instruction stream (from the same object verify_asm
gates) next to the ORACLE .s stream, with every branch/jump target rendered as a
TARGET INDEX (not a label / not normalised away).  This is the view verify_asm is
blind to (04Q: branch targets normalise to `T`).

Reuses tools/verify_asm.py's own compile + resolver front-end (12H anti-drift) and
tools/brdist.py's oracle index model (the .word-is-an-instruction fix included).
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(r'C:\Temp\nfs4-decomp')
sys.path.insert(0, str(ROOT / 'tools'))
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
BR = re.compile(r'^\s*(b\w*|j)\b')

src = (ROOT / 'scratchpad' / 'w65a1' / 'verify_probe.py').read_text()
head = src.split('allpass=True')[0]
g = {'__name__': '__vsrc__', '__file__': str(ROOT / 'scratchpad' / 'w65a1' / 'verify_probe.py')}
cpp = sys.argv[1]
fn = sys.argv[2]
lo = int(sys.argv[3]) if len(sys.argv) > 3 else 0
hi = int(sys.argv[4]) if len(sys.argv) > 4 else 10 ** 9
sys.argv = ['verify_asm.py', cpp, '__none__']
exec(compile(head, 'verify_asm_head', 'exec'), g)
obj = g['obj']
dis = subprocess.run([OBJD, '-d', '-r', '-z', str(obj)], capture_output=True, text=True).stdout


def ours(fn):
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
    base = body[0][0] if body else 0
    out = []
    for i, (a, t) in enumerate(body):
        tgt = None
        if BR.match(t):
            m = re.search(r'\b([0-9a-f]+)\b\s*<', t) or re.search(r',([0-9a-f]+)$', t)
            if m:
                tgt = (int(m.group(1), 16) - base) // 4
        out.append((t, tgt))
    return out


def oracle(fn):
    p = g['_find_oracle_path'](fn)
    if p is None:
        return None
    idx, labels, rows = 0, {}, []
    for ln in p.read_text().splitlines():
        s = re.sub(r'/\*.*?\*/', '', ln).strip()
        if s.startswith('endlabel'):
            break
        if s.endswith(':') and s.startswith('.L'):
            labels.setdefault(s[:-1], idx)
            continue
        m = re.match(r'^(?:jlabel|alabel|dlabel)\s+(\.L\w+)', s)
        if m:                    # splat emits jump-table / alt-entry labels this way
            labels.setdefault(m.group(1), idx)
            continue
        if s.startswith('.word'):
            rows.append((s, None, idx))
            idx += 1
            continue
        if not s or s.startswith(('.', 'glabel', 'nonmatching', 'dlabel', 'jlabel', 'alabel')) or s.endswith(':'):
            continue
        tl = None
        if BR.match(s):
            m = re.search(r'(\.L\w+)\s*$', s)
            tl = m.group(1) if m else None
        rows.append((s, tl, idx))
        idx += 1
    return [(s, (labels[t] if t in labels else -1) if t else None) for s, t, _ in rows], labels


o = ours(fn)
e, labels = oracle(fn)
rev = {}
for k, v in labels.items():
    rev.setdefault(v, []).append(k)
print('idx  %-42s %-42s' % ('OURS', 'ORACLE'))
for i in range(max(len(o), len(e))):
    if not (lo <= i <= hi):
        continue
    ot, otg = o[i] if i < len(o) else ('', None)
    et, etg = e[i] if i < len(e) else ('', None)
    mark = ''
    if otg is not None and etg is not None and otg != etg:
        mark = ' <<<<<<'
    lab = ('%s: ' % ','.join(rev[i])) if i in rev else ''
    oo = ot + ('   -> %d' % otg if otg is not None else '')
    ee = et + ('   -> %d' % etg if etg is not None else '')
    print('%4d %-42s %-42s %s%s' % (i, oo, ee, lab, mark))
