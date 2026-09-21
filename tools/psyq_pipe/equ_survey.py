#!/usr/bin/env python3
"""equ_survey.py -- the data labels Route C still has to give slink as `equ` constants (no source defines them).

For each one: the retail SYM names around the address (globals AND statics, with the object each static was declared in),
the objects of ours that reference it, and the retail bytes there.  That is the evidence for who owns it.
usage: equ_survey.py [label ...]"""
import os
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'tools'))
OUT = ROOT / os.environ.get('NFS4_LANE_OUT', 'build/psyq_off')
T = Path(__import__('retail_sym').txt())
EXE = ROOT / 'rom/nfs4-f.exe'
only = sys.argv[1:]

labels = []
for m in re.finditer(r'^(\S+)\s+equ\s+\$([0-9a-fA-F]+)', (OUT / 'off.lnk').read_text(encoding='latin-1'), re.M):
    labels.append((m.group(1), int(m.group(2), 16)))

# SYM: every record with an address, remembering the object (FILE record) in force
recs = []
cur = ''
for l in T.read_text(encoding='latin-1').splitlines():
    m = re.search(r'Def class FILE .* name (\S+)', l)
    if m:
        cur = m.group(1).split(chr(92))[-1]
        continue
    m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) (\S+) (.*)$', l)
    if m:
        a = int(m.group(1), 16)
        if 0x80010000 <= a < 0x80200000:
            recs.append((a, m.group(2), m.group(3).strip(), cur))
recs.sort(key=lambda r: r[0])
addrs = [r[0] for r in recs]

exe = EXE.read_bytes()


def rbytes(a, n):
    o = a - int.from_bytes(exe[0x18:0x1c], 'little') + 0x800
    return exe[o:o + n] if 0 <= o < len(exe) else b''


import bisect
sfiles = None


def refs(name):
    global sfiles
    if sfiles is None:
        sfiles = [p for p in (ROOT / 'build' / 'recon').rglob('*.s') if 'region_gate' not in p.name and '__' not in p.name]
    out = []
    pat = re.compile(r'\b%s\b' % re.escape(name))
    for p in sfiles:
        try:
            if pat.search(p.read_text(encoding='latin-1')):
                out.append(str(p.relative_to(ROOT / 'build')).replace(chr(92), '/'))
        except OSError:
            pass
    return out


for name, a in labels:
    if only and name not in only:
        continue
    print('=== %s  $%08x   bytes %s' % (name, a, rbytes(a, 16).hex(' ')))
    i = bisect.bisect_right(addrs, a)
    lo = max(0, i - 4)
    for r in recs[lo:i + 3]:
        print('   %s $%08x %-4s %-52s %s' % ('>' if r[0] == a else ' ', r[0], r[1], r[2][:52], r[3]))
    for r in refs(name)[:6]:
        print('   ref: ' + r)
