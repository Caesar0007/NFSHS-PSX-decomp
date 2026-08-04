#!/usr/bin/env python3
"""w48_a1_flagprobe.py -- patch PER_TU_FLAGS in place for ONE TU, gate the whole TU, restore.

usage: python scratch/w48_a1_flagprobe.py <recon/path.c> <fn,fn,...> [key=value ...]
  key=value: no_schedule_insns=True | no_schedule_insns2=True | no_delayed_branch=True
             | g_value=0 | no_split_addresses=True | ...
  with NO key=value pairs it just gates the baseline.
Always restores tools/build.py in a finally block (timeout-safe enough: also `git checkout --`
tools/build.py after a kill).
"""
import subprocess, sys, re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
BUILD = ROOT / 'tools' / 'build.py'

tu = sys.argv[1]
fns = sys.argv[2]
kvs = sys.argv[3:]

orig = BUILD.read_bytes()
try:
    if kvs:
        d = {}
        for kv in kvs:
            k, v = kv.split('=', 1)
            d[k] = (True if v == 'True' else (False if v == 'False' else v))
        txt = orig.decode('utf-8')
        nl = '\r\n' if '\r\n' in txt else '\n'
        # 04G DUPLICATE-KEY HAZARD: PER_TU_FLAGS is a dict LITERAL -- a second
        # entry for the same path is silently discarded by the LAST one.  So if
        # the TU already has an entry, MERGE into it instead of prepending.
        pat = re.compile(r'^([ \t]*)(["\'])' + re.escape(tu) + r'\2\s*:\s*\{(.*?)\},[ \t]*(#.*)?$',
                         re.M)
        m = pat.search(txt)
        if m:
            merged = (m.group(3).strip().rstrip(',') + ', ' if m.group(3).strip() else '')
            merged += ', '.join('%r: %r' % (k, v) for k, v in d.items())
            txt = txt[:m.start()] + '%s%s%s%s: {%s},' % (m.group(1), m.group(2), tu, m.group(2), merged) + txt[m.end():]
        else:
            entry = ('    %r: %r,\n' % (tu, d)).replace('\n', nl)
            txt = txt.replace('PER_TU_FLAGS = {' + nl,
                              'PER_TU_FLAGS = {' + nl + entry, 1)
        assert txt != orig.decode('utf-8'), 'probe patch did not apply'
        BUILD.write_bytes(txt.encode('utf-8'))
    # nuke stale pyc/build outputs for this TU
    for p in (ROOT / 'tools' / '__pycache__').glob('build*.pyc'):
        p.unlink()
    if fns.startswith('SBS:'):
        r = subprocess.run([sys.executable, 'tools/side_by_side.py', tu, fns[4:]],
                           cwd=str(ROOT), capture_output=True, text=True)
        print(r.stdout + r.stderr)
        raise SystemExit(0)
    r = subprocess.run([sys.executable, 'tools/verify_asm.py', tu, fns],
                       cwd=str(ROOT), capture_output=True, text=True)
    out = [l for l in (r.stdout + r.stderr).splitlines()
           if re.search(r'PASS|FAIL|NOT IN|Error|error', l)]
    npass = sum(1 for l in out if 'PASS' in l)
    tot = sum(int(m.group(1)) for l in out for m in [re.search(r'FAIL (\d+) diffs', l)] if m)
    print('\n'.join(out))
    print('== %s  %s : PASS=%d  totaldiffs=%d' % (tu, ' '.join(kvs) or 'BASELINE', npass, tot))
finally:
    BUILD.write_bytes(orig)
    for p in (ROOT / 'tools' / '__pycache__').glob('build*.pyc'):
        p.unlink()
