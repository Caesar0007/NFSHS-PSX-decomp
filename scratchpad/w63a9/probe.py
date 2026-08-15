#!/usr/bin/env python3
"""w63-a9 variant probe harness.

usage: python scratchpad/w63a9/probe.py <spec.json>

spec.json = {"rel": "recon/.../X.c", "fns": ["a","b"],
             "variants": [{"name":"v1","edits":[["OLD","NEW"], ...]}, ...]}

Every edit is an exact literal replace applied to the file text (line endings
preserved: OLD/NEW are written with \n and translated to the file's dominant
ending before matching).  Restores the original in a finally block.
"""
import json, os, subprocess, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
spec = json.load(open(sys.argv[1], 'rb'))
rel = spec['rel']
fns = spec['fns']
path = ROOT / rel

orig = path.read_bytes()
crlf = orig.count(b'\r\n') * 2 >= orig.count(b'\n')
EOL = b'\r\n' if crlf else b'\n'


def conv(s):
    return s.replace('\n', '\x00').encode('ascii').replace(b'\x00', EOL)


def gate():
    r = subprocess.run([sys.executable, 'tools/vprobe.py', rel, ','.join(fns)],
                       cwd=str(ROOT), capture_output=True, text=True)
    out = (r.stdout or '') + (r.stderr or '')
    res = {}
    for ln in out.splitlines():
        for f in fns:
            if (' ' + f + ':') in ln:
                res[f] = ln.strip()
    if not res:
        res['__err__'] = out.strip()[-400:]
    return res


results = []
try:
    for v in spec['variants']:
        d = orig
        ok = True
        for old, new in v['edits']:
            o, n = conv(old), conv(new)
            c = d.count(o)
            if c != 1:
                results.append((v['name'], 'ANCHOR count=%d for %r' % (c, old[:60])))
                ok = False
                break
            d = d.replace(o, n)
        if not ok:
            continue
        assert len(d) > 100
        path.write_bytes(d)
        results.append((v['name'], gate()))
finally:
    path.write_bytes(orig)

for name, r in results:
    print('---', name)
    print('   ', r)
