"""w64a9 probe: literal-replace source variants, gate, restore. Line-ending preserving.

usage: python scratchpad/w64a9/probe.py <variants.json>
json: {"file": "recon/...", "fns": ["a","b"], "variants": [{"name":..,"subs":[[old,new],..]}, ..]}
The control (no subs) is always run first.
"""
import json, subprocess, sys, os
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
spec = json.loads(Path(sys.argv[1]).read_text(encoding='utf-8'))
target = ROOT / spec['file']
fns = spec['fns']

orig = target.read_bytes()


def gate():
    out = {}
    for fn in fns:
        r = subprocess.run([sys.executable, 'tools/verify_asm.py', spec['file'], fn],
                           cwd=str(ROOT), capture_output=True, text=True)
        txt = (r.stdout or '') + (r.stderr or '')
        line = [L for L in txt.splitlines() if 'PASS' in L or 'FAIL' in L or 'NO ORACLE' in L]
        out[fn] = line[0].strip() if line else 'ERR:' + txt.strip()[:120]
    return out


try:
    print('== CONTROL')
    for k, v in gate().items():
        print('   ', v)
    for var in spec['variants']:
        txt = orig.decode('utf-8')
        crlf = '\r\n' in txt
        ok = True
        for old, new in var['subs']:
            if crlf:
                old = old.replace('\r\n', '\n').replace('\n', '\r\n')
                new = new.replace('\r\n', '\n').replace('\n', '\r\n')
            n = txt.count(old)
            if n != var.get('count', 1):
                print(f"!! {var['name']}: anchor count {n} != {var.get('count',1)} for {old[:60]!r}")
                ok = False
                break
            txt = txt.replace(old, new)
        if not ok:
            continue
        target.write_bytes(txt.encode('utf-8'))
        print(f"== {var['name']}")
        for k, v in gate().items():
            print('   ', v)
finally:
    target.write_bytes(orig)
    print('restored', target)
