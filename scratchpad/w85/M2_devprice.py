#!/usr/bin/env python
"""W85-M2: price EVERY device site in recon/syslib/psx/libmcrd/LIBMCRD.c.

For each `__asm__ ...;` statement (comments excluded) the statement is deleted
from a copy of the pristine TU, the TU is dropped on the live path and the
OWNING function is gated with tools/verify_asm.py.  The pristine file is
restored after every probe.  Prints  fn / line / device / gate-after.
"""
import os, re, subprocess, sys, shutil, pathlib

ROOT = pathlib.Path(__file__).resolve().parents[2]
LIVE = ROOT / 'recon/syslib/psx/libmcrd/LIBMCRD.c'
ORIG = ROOT / 'scratchpad/w85/M2_LIBMCRD.orig.c'
SRC = ORIG.read_text()
LINES = SRC.split('\n')


def strip_comments(lines):
    inblk = False
    out = []
    for ln in lines:
        res = ''
        i = 0
        while i < len(ln):
            if inblk:
                j = ln.find('*/', i)
                if j < 0:
                    i = len(ln)
                    break
                inblk = False
                i = j + 2
                continue
            j = ln.find('/*', i)
            k = ln.find('//', i)
            if j >= 0 and (k < 0 or j < k):
                res += ln[i:j]
                inblk = True
                i = j + 2
                continue
            if k >= 0:
                res += ln[i:k]
                i = len(ln)
                break
            res += ln[i:]
            i = len(ln)
        out.append(res)
    return out


CODE = strip_comments(LINES)
FNPAT = re.compile(r'^(?:static |extern |__inline__ |static __inline__ )*'
                   r'[A-Za-z_][\w \*]*\b(MemCard\w+)\s*\(')


def owner(idx):
    cur = None
    for n in range(idx, -1, -1):
        m = FNPAT.match(CODE[n])
        if m:
            return m.group(1)
    return cur


def gate(fn):
    p = subprocess.run([sys.executable, 'tools/verify_asm.py',
                        'recon/syslib/psx/libmcrd/LIBMCRD.c', fn],
                       cwd=str(ROOT), capture_output=True, text=True)
    for ln in (p.stdout + p.stderr).splitlines():
        if fn in ln:
            return ln.strip()
    return (p.stdout + p.stderr).strip().replace('\n', ' ')[:90]


# collect device statements: start line -> end line (inclusive), text
sites = []
i = 0
while i < len(CODE):
    if '__asm__' in CODE[i] and not CODE[i].lstrip().startswith('#define'):
        j = i
        while ';' not in CODE[j] and j + 1 < len(CODE):
            j += 1
        sites.append((i, j))
        i = j + 1
    else:
        i += 1

print('%d device statements' % len(sites))
try:
    for (a, b) in sites:
        fn = owner(a)
        if fn is None:
            continue
        new = LINES[:a] + LINES[b + 1:]
        LIVE.write_text('\n'.join(new))
        res = gate(fn)
        print('%-22s L%-5d %-58s -> %s' %
              (fn, a + 1, LINES[a].strip()[:58], res))
        sys.stdout.flush()
finally:
    shutil.copyfile(ORIG, LIVE)
