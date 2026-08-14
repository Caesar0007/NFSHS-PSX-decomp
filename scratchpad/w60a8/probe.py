#!/usr/bin/env python3
"""w60a8 probe harness: apply byte-level substitutions to a TU, gate the named
fn(s) (or the whole TU), print the result, ALWAYS restore from the .base copy.

usage: probe.py TU_REL BASE_COPY FN[,FN...] SUBS_JSON_FILE
SUBS_JSON_FILE = a JSON list of [old, new] utf-8 string pairs (applied in order,
each must occur exactly once unless prefixed count is given as a 3rd element).
"""
import json, os, subprocess, sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
tu_rel, base, fns, subs_file = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]
tu = ROOT / tu_rel
basep = ROOT / base
orig = basep.read_bytes()
subs = json.loads(Path(subs_file).read_text(encoding='utf-8'))

d = orig
for pair in subs:
    want = pair[2] if len(pair) > 2 else 1
    # the tree has MIXED line endings per file -- try LF-literal first, then CRLF
    cands = [(pair[0].encode('utf-8'), pair[1].encode('utf-8')),
             (pair[0].encode('utf-8').replace(b'\n', b'\r\n'),
              pair[1].encode('utf-8').replace(b'\n', b'\r\n'))]
    for o, nw in cands:
        if d.count(o) == want:
            d = d.replace(o, nw)
            break
    else:
        sys.exit(f"SUB COUNT {[d.count(o) for o, _ in cands]} != {want} for {pair[0]!r}")

try:
    tmp = str(tu) + '.probetmp'
    open(tmp, 'wb').write(d)
    os.replace(tmp, tu)
    if fns == 'TU':
        cmd = [sys.executable, str(ROOT / 'tools' / 'tugate.py'), tu_rel]
    else:
        cmd = [sys.executable, str(ROOT / 'tools' / 'verify_asm.py'), tu_rel, fns]
    r = subprocess.run(cmd, cwd=str(ROOT), capture_output=True, text=True, timeout=1500)
    print(r.stdout[-4000:])
    if r.returncode:
        print("STDERR:", r.stderr[-2000:])
finally:
    tmp = str(tu) + '.probetmp'
    open(tmp, 'wb').write(orig)
    os.replace(tmp, tu)
    print("[restored]")
