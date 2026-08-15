#!/usr/bin/env python3
"""Bounded variant sweep with guaranteed restore.

Usage: variant.py FILE FN  --  reads variants from a JSON list on stdin:
  [{"name":..., "subs":[[old,new],...]}, ...]
Each variant is applied to a fresh copy of FILE (CRLF-preserving), gated with
verify_asm, then FILE is restored from the snapshot in a finally block.
"""
import json, os, subprocess, sys, shutil
from pathlib import Path

ROOT = Path(r'C:\Temp\nfs4-decomp')
f = ROOT / sys.argv[1]
fn = sys.argv[2]
raw0 = f.read_bytes()
eol = '\r\n' if raw0.count(b'\r\n') > raw0.count(b'\n') // 2 else '\n'
base = raw0.decode('utf-8')
variants = json.load(sys.stdin)

def gate():
    env = dict(os.environ); env['VA_MAX'] = '4'
    r = subprocess.run([sys.executable, 'tools/verify_asm.py', sys.argv[1], fn],
                       cwd=ROOT, capture_output=True, text=True, env=env)
    for ln in (r.stdout + r.stderr).splitlines():
        if fn in ln and ('PASS' in ln or 'FAIL' in ln or 'NO ORACLE' in ln):
            return ln.strip()
    return (r.stdout + r.stderr)[-200:].replace('\n', ' ')

try:
    for v in variants:
        t = base
        ok = True
        for old, new in v['subs']:
            o = old.replace('\n', eol); n = new.replace('\n', eol)
            if t.count(o) != 1:
                print(f"{v['name']}: SKIP (anchor count={t.count(o)})"); ok = False; break
            t = t.replace(o, n, 1)
        if not ok:
            continue
        f.write_bytes(t.encode('utf-8'))
        print(f"{v['name']}: {gate()}")
finally:
    f.write_bytes(raw0)
    print('-- restored --')
